//
//  DataStorage.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import Foundation
import CoreData

protocol DataStorageProtocol {
  func getTasks(completion:((String) -> Void))
  func deleteOldTasks()
  func deleteTask(task:String,completion:() -> Void)
  func saveTask(task:String, date:Date,completion:(Bool) -> Void)
}

class DataStorage:DataStorageProtocol {
  
  private var context:NSManagedObjectContext!

  init(context:NSManagedObjectContext) {
    self.context = context
  }

  func getTasks(completion: ((String) -> Void)) {
    let req = NSFetchRequest<Todo>(entityName: "Todo")

    do{

        // going to fetch all data...

        let todos = try context.fetch(req)

        for todo in todos{

          let task = todo.task!
          let date = todo.date!

            // comparing date and displaying only today tasks...

            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-YYYY"

            if formatter.string(from: date) == formatter.string(from: Date()){

                // append to array..
              completion(task)

            }
        }

    }
    catch{

        print(error.localizedDescription)
    }
  }

  func deleteOldTasks() {
    // deleting all old data...

    let req = NSFetchRequest<Todo>(entityName: "Todo")

    do{

      // going to fetch all data...

      let todos = try context.fetch(req)


      for todo in todos {

        let date = todo.date!

        // comparing date and displaying only today tasks...

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"

        // quering old data...

        if formatter.string(from: date) < formatter.string(from: Date()){

          context.delete(todo)
          try context.save()

        }
      }

    }
    catch{

      print(error.localizedDescription)
    }
  }

  func deleteTask(task: String,completion: () -> Void) {
    // deleting all old data...

    let req = NSFetchRequest<Todo>(entityName: "Todo")

    do{

      // going to fetch all data...

      let result = try context.fetch(req)


      for todo in result{

        let currenttask = todo.task!

        if task == currenttask{

          context.delete(todo)
          try context.save()

          completion()
        }
      }
    }
    catch{

      print(error.localizedDescription)
    }
  }

  func saveTask(task:String, date:Date, completion: (Bool) -> Void) {
    // going to insert new object into entity Todo...

    let todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo

    // key specified in core data..
    todo.task = task
    todo.date = date

    do{
      // saving data...
      try context.save()

      completion(true)
    }
    catch{
      completion(false)
      print(error.localizedDescription)
    }
  }

}
