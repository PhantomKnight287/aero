package fyi.procrastinator.aero.presentation.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.rotate
import androidx.compose.ui.graphics.drawscope.translate
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material3.Text
import coil3.compose.AsyncImage
import fyi.procrastinator.aero.R
import fyi.procrastinator.aero.presentation.model.FlightUi
import fyi.procrastinator.aero.presentation.model.Phase
import fyi.procrastinator.aero.presentation.model.Punctuality
import fyi.procrastinator.aero.presentation.theme.AeroColors
import fyi.procrastinator.aero.presentation.theme.AeroText
import kotlin.math.cos
import kotlin.math.sin

/** Green early, red late or cancelled, white on time: as on the phone. */
fun Punctuality.color(): Color = when (this) {
    Punctuality.Early -> AeroColors.success
    Punctuality.Late, Punctuality.Cancelled -> AeroColors.danger
    Punctuality.OnTime -> AeroColors.text
}

/** The one place a flight's status is coloured: a small dot. */
fun FlightUi.dotColor(): Color = when {
    phase == Phase.Cancelled || phase == Phase.Diverted -> AeroColors.danger
    overall == Punctuality.Late -> AeroColors.warn
    else -> AeroColors.success
}

@Composable
fun StatusDot(color: Color, modifier: Modifier = Modifier) {
    Box(modifier.size(7.dp).clip(CircleShape).background(color))
}

/** Airline logo, or its code on a tile when there's none (previews, offline). */
@Composable
fun AirlineMark(iata: String, logoUrl: String?, size: Int = 28) {
    val shape = RoundedCornerShape((size / 4).dp)
    if (logoUrl != null) {
        AsyncImage(
            model = logoUrl,
            contentDescription = null,
            modifier = Modifier.size(size.dp).clip(shape),
        )
    } else {
        Box(
            Modifier.size(size.dp).clip(shape).background(AeroColors.panelHigh),
            contentAlignment = Alignment.Center,
        ) {
            Text(iata, style = AeroText.label.copy(color = AeroColors.text))
        }
    }
}

/**
 * The phone's progress bar bent into a rainbow: departure at the left foot,
 * arrival at the right, the plane riding the arc. Flown part in white.
 */
@Composable
/** [progress] null draws the empty track only: cancelled and diverted flights. */
fun FlightArc(progress: Float?, modifier: Modifier = Modifier, inset: Dp = 30.dp) {
    val plane = rememberVectorPainter(ImageVector.vectorResource(R.drawable.ic_flight))
    Canvas(modifier) {
        val stroke = 3.dp.toPx()
        // Feet [inset] in from the sides, so the codes below can sit under them.
        // Feet stop above the bottom edge so the plane clears the codes below.
        val lift = 14.dp.toPx()
        val r = minOf(size.width / 2 - inset.toPx(), size.height - lift - 12.dp.toPx())
        val center = Offset(size.width / 2, size.height - lift)
        val topLeft = Offset(center.x - r, center.y - r)
        val arc = Size(r * 2, r * 2)
        drawArc(
            AeroColors.line, 180f, 180f, false, topLeft, arc,
            style = Stroke(stroke, cap = StrokeCap.Round),
        )
        if (progress == null) return@Canvas
        val p = progress.coerceIn(0f, 1f)
        drawArc(
            AeroColors.text, 180f, 180f * p, false, topLeft, arc,
            style = Stroke(stroke, cap = StrokeCap.Round),
        )
        // Plane on a black disc, nose along the arc.
        val angle = Math.toRadians(180.0 + 180.0 * p)
        val at = Offset(
            center.x + r * cos(angle).toFloat(),
            center.y + r * sin(angle).toFloat(),
        )
        val disc = 11.dp.toPx()
        drawCircle(AeroColors.text, disc, at)
        val icon = 14.dp.toPx()
        // Nose up at the left foot, level at the top, down at the right foot.
        rotate(degrees = 180f * p, pivot = at) {
            translate(at.x - icon / 2, at.y - icon / 2) {
                with(plane) {
                    draw(Size(icon, icon), colorFilter = ColorFilter.tint(AeroColors.ink))
                }
            }
        }
    }
}

/** Dark grey inset panel, the watch's version of the phone's grey card. */
@Composable
fun Panel(modifier: Modifier = Modifier, content: @Composable ColumnScope.() -> Unit) {
    Column(
        modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(18.dp))
            .background(AeroColors.panel)
            .padding(horizontal = 14.dp, vertical = 10.dp),
        verticalArrangement = Arrangement.spacedBy(4.dp),
        content = content,
    )
}

/** Label on the left, value on the right. */
@Composable
fun InfoRow(label: String, value: String, valueColor: Color = AeroColors.text) {
    Row(Modifier.fillMaxWidth()) {
        Text(label, style = AeroText.caption, modifier = Modifier.width(58.dp).padding(top = 1.dp))
        // Two lines before cutting: aircraft names run long on small watches.
        Text(
            value,
            style = AeroText.body.copy(color = valueColor),
            maxLines = 2,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.weight(1f),
        )
    }
}
