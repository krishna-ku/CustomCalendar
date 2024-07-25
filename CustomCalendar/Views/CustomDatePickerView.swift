//
//  CustomDatePickerView.swift
//  CustomCalendar
//
//  Created by krishna on 25/07/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    
    let highlightDates: [Date]
    @State private var currentMonth: Date = Date()
    @State private var showMonthAndYearPicker = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { moveMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(monthFormatter.string(from: currentMonth))
                    .font(.headline)
                
                Text(yearFormatter.string(from: currentMonth))
                    .font(.headline)
                
                Image(systemName: "chevron.down")
                    .onTapGesture {
                        showMonthAndYearPicker.toggle()
                    }
                Spacer()
                Button(action: { moveMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()
            if !showMonthAndYearPicker {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 7), spacing: 10) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                    }
                    ForEach(generateDates(for: currentMonth), id: \.date) { dateInfo in
                        Text(dayFormatter.string(from: dateInfo.date))
                            .font(.body)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(8)
                            .background(highlightDates.contains {Calendar.current.isDate($0, inSameDayAs: dateInfo.date)} ? Color.blue.opacity(dateInfo.isCurrentMonth ? 0.8 : 0.4) : Color.clear)
                            .cornerRadius(4)
                            .foregroundColor(dateInfo.isCurrentMonth ? .primary : .gray)
                    }
                }
            }
            
            if showMonthAndYearPicker {
                MonthYearPickerView(selectedDate: $currentMonth, isVisible: $showMonthAndYearPicker)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .transition(.move(edge: .top))
            }
        }
        .padding()
        .onAppear() {
            setCurrentMonth()
        }
    }
    
    private var daysOfWeek: [String] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        return calendar.shortWeekdaySymbols
    }
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    
    private var yearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    private func moveMonth(by offset: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: offset, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    private func setCurrentMonth() {
        currentMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) ?? Date()
    }
    
    private func generateDates(for month: Date) -> [(date: Date, isCurrentMonth: Bool)] {
        var dates: [(date: Date, isCurrentMonth: Bool)] = []
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: month)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!        // Calculate the first day to display
        var firstDay = startOfMonth
        
        if let weekday = calendar.dateComponents([.weekday], from: firstDay).weekday {
            firstDay = calendar.date(byAdding: .day,    value: -(weekday - calendar.firstWeekday), to: firstDay)!
        }
        // Generate all dates for the current month
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                dates.append((date: date, isCurrentMonth: true))
            }
        }
        
        // Add previous month's dates to fill the first row if necessary
        while calendar.component(.weekday, from: dates.first!.date) != calendar.firstWeekday {
            if let prevDate = calendar.date(byAdding: .day, value: -1, to: dates.first!.date) {
                dates.insert((date: prevDate, isCurrentMonth: false), at: 0)
            }
        }
        
        // Add next month's dates to fill the last row if necessary
        while dates.count % 7 != 0 {
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: dates.last!.date) {
                dates.append((date: nextDate, isCurrentMonth: false))
            }
        }
        
        return dates
    }
    
//    private func isSameMonth(_ date1: Date, as date2: Date) -> Bool {
//        let calendar = Calendar.current
//        return calendar.component(.month, from: date1) == calendar.component(.month, from: date2)
//    }
}

#Preview {
    CustomDatePickerView(highlightDates: [.init()])
}
