# Delete Flight From Log Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Let a user hard-delete a tracked flight (and its positions, booking, distance, FlightAware data) from their log.

**Architecture:** New `DELETE /v1/flight/:flightId` in the existing Nest `FlightController`/`FlightService`, scoped to the auth user. Flutter "Recently Tracked" rows become swipe-to-delete with a confirm dialog, calling the regenerated Dart client.

**Tech Stack:** NestJS + Prisma (api/, bun), jest + ts-jest, openapi-generator dart-dio, Flutter.

**Spec:** `docs/superpowers/specs/2026-11-21-delete-flight-from-log-design.md`

## Global Constraints

- Use bun, not npm, in `api/`.
- Hard delete only; no soft-delete flag, no undo.
- Endpoint path: `DELETE /v1/flight/:flightId`; 404 when the flight does not exist or belongs to another user.
- `FlightPositions` must be deleted explicitly (no cascade); bookings, GreatCircleDistance, FlightAwareData cascade via schema.
- No Redis caching exists for tracked flights or profile stats — nothing to invalidate.

## Review Focus

- Deleting another user's flight id → 404, nothing deleted. (Task 1 test)
- Flight with no positions / no FlightAware data → still deletes cleanly. (Task 1 test: `deleteMany` returning count 0 is fine)
- Swipe then cancel in the dialog → row snaps back, no API call. (Task 3 manual check)
- API failure (offline / 500) → row stays in list, snackbar shows error. (Task 3 manual check)
- Deleted flight is the one shown in the Android widget → widget refreshes. (Task 3 manual check)

---

### Task 1: API delete endpoint

**Files:**
- Modify: `api/src/resources/flight/flight.service.ts` (add method after `deleteFlightBooking`, ~line 1338)
- Modify: `api/src/resources/flight/flight.controller.ts` (add route after `deleteFlightBooking`; register it **after** `@Delete('booking/:bookingId')` so `booking/...` still matches first)
- Test: `api/src/resources/flight/flight-delete.spec.ts` (new)

**Interfaces:**
- Produces: `FlightService.deleteFlight(flightId: string, userId: string): Promise<{ message: string }>`; route `DELETE /v1/flight/:flightId`, operationId → generated Dart `flightControllerDeleteFlightV1({ required String flightId })`.

- [ ] **Step 1: Install deps** — `cd api && bun install`. Expected: `node_modules/.bin/jest` exists.

- [ ] **Step 2: Write the failing test** in `flight-delete.spec.ts`. Mock `src/db` with `jest.mock('src/db', () => ({ prisma: { flight: { findFirst: jest.fn(), delete: jest.fn() }, flightPositions: { deleteMany: jest.fn() }, $transaction: jest.fn((ops) => Promise.all(ops)) } }))`. Build the service directly: `new FlightService({ get: () => undefined } as any, {} as any, { getOrNil: () => null } as any)`.

```ts
it('throws NotFound and deletes nothing when flight not owned', async () => {
  prisma.flight.findFirst.mockResolvedValue(null);
  await expect(service.deleteFlight('f1', 'u1')).rejects.toBeInstanceOf(NotFoundException);
  expect(prisma.flight.findFirst).toHaveBeenCalledWith({ where: { id: 'f1', userId: 'u1' } });
  expect(prisma.flight.delete).not.toHaveBeenCalled();
  expect(prisma.flightPositions.deleteMany).not.toHaveBeenCalled();
});

it('deletes positions then flight in one transaction', async () => {
  prisma.flight.findFirst.mockResolvedValue({ id: 'f1' });
  await expect(service.deleteFlight('f1', 'u1')).resolves.toEqual({ message: 'Flight deleted successfully' });
  expect(prisma.flightPositions.deleteMany).toHaveBeenCalledWith({ where: { flightId: 'f1' } });
  expect(prisma.flight.delete).toHaveBeenCalledWith({ where: { id: 'f1' } });
  expect(prisma.$transaction).toHaveBeenCalledTimes(1);
});
```

If `rootDir: src` breaks the `src/db` path alias in jest, add `"moduleNameMapper": { "^src/(.*)$": "<rootDir>/$1" }` to the jest block in `api/package.json`.

- [ ] **Step 3: Run test, verify fail** — `cd api && bunx jest src/resources/flight/flight-delete.spec.ts`. Expected: FAIL, `service.deleteFlight is not a function`.

- [ ] **Step 4: Implement `deleteFlight`** — same shape as `deleteFlightBooking`: `findFirst({ where: { id, userId } })`, throw `NotFoundException('Flight not found or does not belong to the user')`, then `prisma.$transaction([prisma.flightPositions.deleteMany({ where: { flightId } }), prisma.flight.delete({ where: { id: flightId } })])`, return `{ message: 'Flight deleted successfully' }`.

- [ ] **Step 5: Add controller route** — `@Delete(':flightId')` with `ApiOperation({ summary: 'Delete a tracked flight', description: 'Deletes a flight from the user log, including positions, booking, distance and FlightAware data' })`, `ApiParam flightId`, 200 schema `{ message }`, `ApiNotFoundResponse`, `ApiUnauthorizedResponse`, `ApiInternalServerErrorResponse` — copy decorators from `deleteFlightBooking`. Handler `deleteFlight(@Param('flightId') flightId, @Auth() auth: User)`.

- [ ] **Step 6: Run test, verify pass** — same command. Expected: 2 passed.

- [ ] **Step 7: Commit**
```bash
git add api/src/resources/flight api/package.json
git commit -m "feat(api): delete tracked flight endpoint"
```

### Task 2: Regenerate Dart client

**Files:**
- Modify: `api/openapi.json` (written by `api/src/main.ts:81` on boot)
- Modify: `openapi/**` (generated)

**Interfaces:**
- Consumes: Task 1 route.
- Produces: `FlightApi.flightControllerDeleteFlightV1({ required String flightId })`.

- [ ] **Step 1:** Start API once (`cd api && bun run start:dev`), wait for boot, stop it. Expected: `git diff api/openapi.json` shows `delete` under `/v1/flight/{flightId}`.
- [ ] **Step 2:** From repo root run `./generate-openapi-client.sh`. Expected: ends with `Done!`; `grep -rn flightControllerDeleteFlightV1 openapi/lib` hits.
- [ ] **Step 3: Commit** — `git add api/openapi.json openapi && git commit -m "chore: regenerate openapi client"`.

### Task 3: Swipe-to-delete in Recently Tracked

**Files:**
- Modify: `app/lib/services/main.dart` (add method next to `getTrackedFlights`, ~line 163)
- Modify: `app/lib/screens/home/home_controller.dart` (add method next to `loadTrackedFlights`, ~line 263)
- Modify: `app/lib/screens/home/widgets/tracked_flights_list.dart`
- Modify: `app/lib/screens/home/main.dart:441` (pass new callback)

**Interfaces:**
- Consumes: `FlightApi.flightControllerDeleteFlightV1` (Task 2), `WidgetUpdateService.updateWidget()` (existing static).
- Produces: `FlightDataService.deleteFlight(String flightId): Future<void>` (error handling copied from `BookingService.deleteFlightBooking`); `HomeController.deleteTrackedFlight(String flightId): Future<void>` (calls service, then removes the item locally — `trackedFlights = trackedFlights.rebuild((b) => b.removeWhere((f) => f.id == flightId)); notifyListeners();` — and calls `WidgetUpdateService.updateWidget()`; rethrows `ApiException`. Do NOT call `loadTrackedFlights()`: it flips `loadingTrackedFlights`, which hides the list (`main.dart:439`), and a dismissed `Dismissible` must leave the tree immediately or Flutter throws "A dismissed Dismissible widget is still part of the tree"); `TrackedFlightsList` gains `required Future<void> Function(FlightResponseEntity flight) onDelete`.

- [ ] **Step 1: Service + controller methods** as in Interfaces. Run `cd app && flutter analyze lib/services/main.dart lib/screens/home/home_controller.dart`. Expected: no new errors.
- [ ] **Step 2: Wrap each row in `Dismissible`** — `key: ValueKey(flight.id)`, `direction: DismissDirection.endToStart`, red background with `Icons.delete_outline` aligned right. `confirmDismiss`: show `AlertDialog` titled "Delete flight?", body "Removes ${flightNo} on ${dd MMM yyyy} from your log and stats." plus, when `flight.bookings?.isNotEmpty == true`, " Its booking will be deleted too."; buttons Cancel / Delete. On Delete, `await onDelete(flight)` inside try; on `ApiException` show snackbar with its message and return `false` (row stays); on success return `true`.
- [ ] **Step 3: Wire in `main.dart:441`** — `onDelete: (f) => controller.deleteTrackedFlight(f.id)`.
- [ ] **Step 4: Verify** — `cd app && flutter analyze` (no new errors). Run on Android device/emulator against local API and check each Review Focus line: delete a flight (gone from list, gone from Stats on reopen, widget refreshed); swipe + Cancel (row returns, no request in API log); stop API and delete (row stays, snackbar shown); delete a flight with a booking (dialog mentions booking).
- [ ] **Step 5: Commit**
```bash
git add app/lib
git commit -m "feat(app): swipe to delete tracked flights"
```
