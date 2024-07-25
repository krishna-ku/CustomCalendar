//
//  Item.swift
//  CustomCalendar
//
//  Created by krishna on 25/07/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    var scheduledDate: String
    var amount: String
}
