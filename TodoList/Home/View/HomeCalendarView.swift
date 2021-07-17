//
//  HomeCalendarView.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI

struct HomeCalendarView: View {

  @State var data:DateType!
  private(set) var date = Date()

    var body: some View {
      VStack {
        if let _ = self.data {
          ZStack {
            VStack(spacing:15) {
              ZStack {
                HStack {
                  Spacer()
                  Text(self.data!.month)
                    .font(.title).foregroundColor(.white)
                  Spacer()
                }
                .padding(.vertical)
              }
              .background(Color.red)

              Text(self.data!.date)
                .fontWeight(.bold)
                .font(.system(size: 65))


              Text(self.data!.day)
                .font(.title)

              Divider()

              ZStack {
                Text(self.data!.year)
                  .font(.title)
              }
            }
            .padding(.bottom,12)
          }
          .frame(width: UIScreen.main.bounds.width / 1.5)
          .background(Color.white)
          .cornerRadius(15)
        }
      }
      .onAppear(perform: {
        self.updateDate()
      })
    }

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
}

struct HomeCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCalendarView()
    }
}
