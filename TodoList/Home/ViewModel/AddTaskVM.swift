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
  var isSaved = false
  private var dataStorage:DataStorageProtocol!
  // saving data in Core Data...

  init(dataStorage:DataStorageProtocol) {
    self.dataStorage = dataStorage
  }

  func saveTask(task:String, date:Date, completion:(Bool) -> Void){
    dataStorage.saveTask(task: task, date: date) { (isSaved) in
      self.isSaved = isSaved
      completion(isSaved)
    }
  }

}
