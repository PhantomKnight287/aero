import { Hono } from "hono";
import { logger } from "hono/logger";
const app = new Hono();

app.use(logger());

app.all("*", async (c) => {
  if (
    (c.req.method === "POST" || c.req.method === "PATCH") &&
    c.req.header("Content-Type") === "application/json"
  ) {
    console.dir(await c.req.json(), { depth: null });
  }
  return c.text("Hello Bun!");
});

export default app;
