//
//  CalenderView.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI

struct CalenderView: View {

  @ObservedObject var viewModel = CalendarVM()

    var body: some View {
      VStack {
        if viewModel.data != nil {
          ZStack {
            VStack(spacing:15) {
              ZStack {
                HStack {
                  Spacer()
                  Text(self.viewModel.data.month)
                    .font(.title).foregroundColor(.white)
                  Spacer()
                }
                .padding(.vertical)

                HStack {
                  Button(action: {
                    self.viewModel.setNewDate(value: -1, component: .month)
                  }){
                    Image(systemName: "arrow.left")
                  }

                  Spacer()

                  Button(action: {
                    self.viewModel.setNewDate(value: 1, component: .month)
                  }){
                    Image(systemName: "arrow.right")
                  }
                }
                .foregroundColor(.white)
                .padding(.horizontal,30)
              }
              .background(Color.red)

              Text(self.viewModel.data.date)
                .fontWeight(.bold)
                .font(.system(size: 65))


              Text(self.viewModel.data.day)
                .font(.title)

              Divider()

              ZStack {
                Text(self.viewModel.data.year)
                  .font(.title)

                HStack{
                  Spacer()

                  Button(action:{
                    withAnimation(.default) {
                      self.viewModel.setExpand()
                    }
                  }) {
                    Image(systemName: "chevron.right")
                      .renderingMode(.original)
                      .resizable()
                      .frame(width: 10, height: 10)
                      .rotationEffect(.init(degrees: viewModel.expand ? 270 : 90))
                  }
                  .padding(.trailing,30)
                }
              }

              if viewModel.expand {
                Toggle(isOn: $viewModel.year) {
                  Text("Year")
                    .font(.title)
                }
                .padding(.trailing,15)
                .padding(.leading,25)
              }
            }
            .padding(.bottom, viewModel.expand ? 15 : 12)

            HStack {
              Button(action: {
                self.viewModel.setNewDate(value: -1, component: viewModel.year ? .year : .day)
              }){
                Image(systemName: "arrow.left")
                  .foregroundColor(.black)
              }

              Spacer()

              Button(action: {
                self.viewModel.setNewDate(value: 1, component: viewModel.year ? .year : .day)
              }){
                Image(systemName: "arrow.right")
                  .foregroundColor(.black)
              }
            }
            .padding(.horizontal,30)
          }
          .frame(width: UIScreen.main.bounds.width / 1.5)
          .background(Color.white)
          .cornerRadius(15)
        }
      }
      .onAppear(perform: {
        self.viewModel.updateDate()
      })
    }

}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}
