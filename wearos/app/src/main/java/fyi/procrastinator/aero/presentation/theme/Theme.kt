package fyi.procrastinator.aero.presentation.theme

import androidx.compose.runtime.Composable
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.googlefonts.Font
import androidx.compose.ui.text.googlefonts.GoogleFont
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Typography
import fyi.procrastinator.aero.R

val provider = GoogleFont.Provider(
    providerAuthority = "com.google.android.gms.fonts",
    providerPackage = "com.google.android.gms",
    certificates = R.array.com_google_android_gms_fonts_certs
)

@Composable
fun AeroTheme(
    content: @Composable () -> Unit
) {
    /**
     * Empty theme to customize for your app.
     * See: https://developer.android.com/jetpack/compose/designsystems/custom
     */1
    MaterialTheme(
        content = content,
        typography = Typography(
            defaultFontFamily = FontFamily(
                Font(googleFont = GoogleFont("Geist"), provider)
            )
        )
    )
}