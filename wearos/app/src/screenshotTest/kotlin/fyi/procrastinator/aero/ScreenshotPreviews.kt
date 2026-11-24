package fyi.procrastinator.aero

import androidx.compose.runtime.Composable
import androidx.wear.compose.ui.tooling.preview.WearPreviewLargeRound
import androidx.wear.compose.ui.tooling.preview.WearPreviewSmallRound
import com.android.tools.screenshot.PreviewTest
import fyi.procrastinator.aero.presentation.screens.detail.DetailAircraftPreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailArrivedPreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailPanelsPreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailCancelledPreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailInFlightPreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailLatePreview
import fyi.procrastinator.aero.presentation.screens.detail.DetailScheduledPreview
import fyi.procrastinator.aero.presentation.screens.list.FlightListEmptyPreview
import fyi.procrastinator.aero.presentation.screens.list.FlightListPreview

/*
 * The app's @Preview screens rendered to PNG, on a large and a small round
 * watch. Refresh after a UI change and look at the images:
 *   ./gradlew updateDebugScreenshotTest
 * Images land in app/src/screenshotTestDebug/reference/.
 */

@PreviewTest @WearPreviewLargeRound @WearPreviewSmallRound @Composable
fun List() = FlightListPreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun ListEmpty() = FlightListEmptyPreview()

@PreviewTest @WearPreviewLargeRound @WearPreviewSmallRound @Composable
fun InFlight() = DetailInFlightPreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun Late() = DetailLatePreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun Scheduled() = DetailScheduledPreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun Arrived() = DetailArrivedPreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun Cancelled() = DetailCancelledPreview()

@PreviewTest @WearPreviewLargeRound @WearPreviewSmallRound @Composable
fun Panels() = DetailPanelsPreview()

@PreviewTest @WearPreviewLargeRound @Composable
fun AircraftAndInbound() = DetailAircraftPreview()
