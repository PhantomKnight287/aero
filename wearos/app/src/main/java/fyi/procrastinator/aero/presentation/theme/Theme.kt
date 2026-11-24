package fyi.procrastinator.aero.presentation.theme

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontVariation
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material3.ColorScheme
import androidx.wear.compose.material3.MaterialTheme
import androidx.wear.compose.material3.Typography
import fyi.procrastinator.aero.R

/**
 * The phone app's palette, inverted for an OLED watch: white type on black,
 * dark grey panels, colour only for status. Status hues are a step brighter
 * than the phone's so they hold up on black.
 */
object AeroColors {
    val ink = Color(0xFF000000)
    val panel = Color(0xFF1C1C1E)
    val panelHigh = Color(0xFF2A2A2D)
    val line = Color(0xFF3A3A3C)
    val text = Color(0xFFFFFFFF)
    val muted = Color(0xFF8E8E93)
    val success = Color(0xFF4CAF50)
    val danger = Color(0xFFEF5350)
    val warn = Color(0xFFFFA726)
}

@OptIn(androidx.compose.ui.text.ExperimentalTextApi::class)
private fun inter(weight: Int) = Font(
    R.font.inter,
    weight = FontWeight(weight),
    variationSettings = FontVariation.Settings(FontVariation.weight(weight)),
)

/** Inter at the weights the screens use; variable font, one file. */
val Inter = FontFamily(inter(400), inter(500), inter(600), inter(700))

/** CalSans for headlines and airport codes, as on the phone. */
val CalSans = FontFamily(Font(R.font.calsans))

/** Type that isn't one of Material's roles. */
object AeroText {
    val code = TextStyle(fontFamily = CalSans, fontSize = 22.sp, color = AeroColors.text)
    val codeLarge = TextStyle(fontFamily = CalSans, fontSize = 30.sp, color = AeroColors.text)
    val clock = TextStyle(
        fontFamily = Inter,
        fontSize = 18.sp,
        fontWeight = FontWeight.SemiBold,
        fontFeatureSettings = "tnum",
    )
    val label = TextStyle(
        fontFamily = Inter,
        fontSize = 10.sp,
        fontWeight = FontWeight.SemiBold,
        letterSpacing = 0.6.sp,
        color = AeroColors.muted,
    )
    val body = TextStyle(fontFamily = Inter, fontSize = 13.sp, color = AeroColors.text)
    val caption = TextStyle(fontFamily = Inter, fontSize = 12.sp, color = AeroColors.muted)
}

private val scheme = ColorScheme(
    primary = AeroColors.text,
    onPrimary = AeroColors.ink,
    primaryContainer = AeroColors.panelHigh,
    onPrimaryContainer = AeroColors.text,
    secondary = AeroColors.muted,
    onSecondary = AeroColors.ink,
    background = AeroColors.ink,
    onBackground = AeroColors.text,
    onSurface = AeroColors.text,
    onSurfaceVariant = AeroColors.muted,
    surfaceContainerLow = AeroColors.panel,
    surfaceContainer = AeroColors.panel,
    surfaceContainerHigh = AeroColors.panelHigh,
    outline = AeroColors.line,
    outlineVariant = AeroColors.line,
    error = AeroColors.danger,
)

@Composable
fun AeroTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = scheme,
        typography = Typography(defaultFontFamily = Inter),
        content = content,
    )
}
