//
//  AddTaskVM.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI
import CoreData

class AddTaskVM: ObservableObject {

  @Published var date:Date = Date()
  @Published var task = ""
  @Published var keyboardHeight:CGFloat = 0
  // saving data in Core Data...

  func saveTask(completion:(Bool) -> Void){

      // creating context from Presistent Controller...

    let context = PersistenceController.shared.container.viewContext

      // going to insert new object into entity Todo...

      let entity = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context)

      // key specified in core data..
    entity.setValue(self.task, forKey: "task")
    entity.setValue(self.date, forKey: "date")

      do{

          // saving data...
          try context.save()

          // if succeeds..
          // pop the view...

          // it will dismiss top view on stack...
        completion(true)
      }
      catch{

          print(error.localizedDescription)
      }
  }

}
