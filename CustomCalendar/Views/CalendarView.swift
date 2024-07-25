//
//  CalendarView.swift
//  CustomCalendar
//
//  Created by krishna on 25/07/24.
//

import SwiftUI

struct CalendarView: View {
    
    private let items = [
            Item(scheduledDate: "2024/07/05", amount: "11057.92"),
            Item(scheduledDate: "2024/07/18", amount: "100.92"),
            Item(scheduledDate: "2024/07/10", amount: "100.92"),
            Item(scheduledDate: "2024/07/15", amount: "100.92"),
            Item(scheduledDate: "2024/08/01", amount: "100.92")
        ]
    
    var body: some View {
        VStack {
            CustomDatePickerView(highlightDates: items.map { convertStringToDate(dateString: $0.scheduledDate)})
        }
    }
    func convertStringToDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString) ?? Date()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

#Preview {
    CalendarView()
}
