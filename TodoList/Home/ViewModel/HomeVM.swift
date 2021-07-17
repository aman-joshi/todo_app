//
//  HomeVM.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI
import CoreData

class HomeVM: ObservableObject {

  private let context = PersistenceController.shared.container.viewContext

  @Published var todayTasks : [String] = []


  func getTasks(){

      let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")

      do{

          // going to fetch all data...

          let result = try context.fetch(req)

          self.todayTasks.removeAll()

          for i in result as! [NSManagedObject]{

              let task = i.value(forKey: "task") as! String
              let date = i.value(forKey: "date") as! Date

              // comparing date and displaying only today tasks...

              let formatter = DateFormatter()
              formatter.dateFormat = "dd-MM-YYYY"

              if formatter.string(from: date) == formatter.string(from: Date()){

                  // append to array..

                  self.todayTasks.append(task)
              }
          }

      }
      catch{

          print(error.localizedDescription)
      }
  }

  func deleteOldTasks(){

    // deleting all old data...

    let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")

    do{

      // going to fetch all data...

      let result = try context.fetch(req)


      for i in result as! [NSManagedObject]{

        let date = i.value(forKey: "date") as! Date

        // comparing date and displaying only today tasks...

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"

        // quering old data...

        if formatter.string(from: date) < formatter.string(from: Date()){

          context.delete(i)
          try context.save()

        }
      }

    }
    catch{

      print(error.localizedDescription)
    }
  }

  func deleteTask(task: Int){

      // deleting all old data...

      let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")

      do{

          // going to fetch all data...

          let result = try context.fetch(req)


          for i in result as! [NSManagedObject]{

              let currenttask = i.value(forKey: "task") as! String

              if self.todayTasks[task] == currenttask{

                  context.delete(i)
                  try context.save()

                  self.todayTasks.remove(at: task)

                  return
              }
          }

      }
      catch{

          print(error.localizedDescription)
      }
  }
}

