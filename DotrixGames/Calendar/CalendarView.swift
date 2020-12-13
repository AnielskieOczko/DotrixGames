import SwiftUI
import Combine
import ElegantCalendar

struct CalendarView: View {

    @ObservedObject var calendarManager = ElegantCalendarManager(
        configuration: CalendarConfiguration(startDate: Date(),
                                             endDate: Date(timeIntervalSinceNow: 60*60*24*30*5)))

    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
    }
}
