package fyi.procrastinator.aero.widgets.current_active_flight
import HomeWidgetGlanceWidgetReceiver

class CurrentActiveFlightReceiver: HomeWidgetGlanceWidgetReceiver<CurrentActiveFlight>(){
    override val glanceAppWidget = CurrentActiveFlight()

}