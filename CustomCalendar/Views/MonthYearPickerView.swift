//
//  MonthYearPickerView.swift
//  CustomCalendar
//
//  Created by krishna on 25/07/24.
//

import SwiftUI

struct MonthYearPickerView: View {
    @Binding var selectedDate: Date
    @Binding var isVisible: Bool
    
    var body: some View {
        HStack {
            Picker("Select Month", selection: $selectedDate) {
                ForEach(1...12, id: \.self) { month in
                    Text(Calendar.current.monthSymbols[month - 1]).tag(Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: selectedDate), month: month))!)
                }
            }
            .pickerStyle(WheelPickerStyle())
            //            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Picker("Select Year", selection: $selectedDate) {
                let currentYear = Calendar.current.component(.year, from: Date())
                ForEach((currentYear-100)...(currentYear+100), id: \.self) { year in
                    Text("\(String(year))").tag(Calendar.current.date(from: DateComponents(year: year, month: Calendar.current.component(.month, from: selectedDate)))!)
                }
            }
            .pickerStyle(WheelPickerStyle())
            //            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MonthYearPickerView(selectedDate: .constant(Date()), isVisible: .constant(true))
}
