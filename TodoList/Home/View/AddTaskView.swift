//
//  AddTaskView.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI
import CoreData

struct AddTaskView: View {

  @ObservedObject var viewModel = AddTaskVM()
  @ObservedObject var calenderVM = CalendarVM()
  @Environment(\.presentationMode) var present

    var body: some View {
      VStack {
        Spacer(minLength: 0)

        CalenderView(viewModel: self.calenderVM)
          .scaleEffect((UIScreen.main.bounds.height < 750 && viewModel.keyboardHeight != 0) ? 0.65 : 1.0)
          .padding((UIScreen.main.bounds.height < 750 && viewModel.keyboardHeight != 0) ? -60 : 0)

        Spacer(minLength: 0)

        Divider()
          .background(Color.black.opacity(0.8))
        TextField("Type Here", text: $viewModel.task)
          .padding([.horizontal,.bottom])

      }
      .padding(.bottom, viewModel.keyboardHeight)
      .navigationBarTitle("Add New Task",displayMode: .large)
      .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.bottom))
      .navigationBarItems(trailing:

                            Button(action:{
                              saveTask()
                            }) {
                              Text("Done").fontWeight(.bold)
                            }.disabled(viewModel.task == "" ? true : false)
      )

      .onAppear(perform: {

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (notification) in
          let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
          let height = frame.cgRectValue.height
          withAnimation {
            self.viewModel.keyboardHeight = height * 0.1
          }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (notification) in

          withAnimation {
            self.viewModel.keyboardHeight = 0
          }
        }

      })
    }

  func saveTask() {
    viewModel.saveTask { (isSaved) in
      self.present.wrappedValue.dismiss()
    }
  }
  
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
