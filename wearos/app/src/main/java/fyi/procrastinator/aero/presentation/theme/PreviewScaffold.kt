package fyi.procrastinator.aero.presentation.theme

import androidx.compose.runtime.Composable
import androidx.wear.compose.material3.AppScaffold
import androidx.wear.compose.material3.TimeText
import androidx.wear.compose.material3.TimeSource

/** The watch-face classic, so previews don't change with the real clock. */
private object PreviewTime : TimeSource {
    @Composable
    override fun currentTime(): String = "10:09"
}

/** Theme and scaffold for @Preview, with the clock pinned. */
@Composable
fun PreviewScaffold(content: @Composable () -> Unit) = AeroTheme {
    AppScaffold(timeText = { TimeText(timeSource = PreviewTime) }) { content() }
}
