//
//  CalendarVM.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI

class CalendarVM: ObservableObject {

  private(set) var date = Date()
  @Published var data:DateType!
  @Published var expand:Bool = false
  @Published var year:Bool = false

  func updateDate() {
    let current = Calendar.current

    let date = current.component(.day, from: self.date)
    let month = current.component(.month, from: self.date)
    let monthStr = current.monthSymbols[month - 1]
    let year = current.component(.year, from: self.date)
    let week = current.component(.weekday, from: self.date)
    let day = current.weekdaySymbols[week - 1]

    self.data = DateType(day: day, date: "\(date)", year: "\(year)", month: monthStr)
  }

  func setExpand() {
    self.expand.toggle()
  }

  func setYear() {
    self.year.toggle()
  }

  func setNewDate(value:Int,component:Calendar.Component) {
    self.date = Calendar.current.date(byAdding: component, value: value, to: self.date)!
    self.updateDate()
  }

}
