//
//  HomeVM.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI
import CoreData

class HomeVM: ObservableObject {

  @Published var todayTasks : [String] = []
  private var dataStorage:DataStorageProtocol!

  init(dataStorage:DataStorageProtocol) {
    self.dataStorage = dataStorage
  }

  func getTasks(){
    self.todayTasks.removeAll()
    dataStorage.getTasks { (task) in
      self.todayTasks.append(task)
    }
  }

  func deleteOldTasks(){
    dataStorage.deleteOldTasks()
  }

  func deleteTask(task: Int){
    dataStorage.deleteTask(task: self.todayTasks[task]) {
      self.todayTasks.remove(at: task)
    }
  }
}

