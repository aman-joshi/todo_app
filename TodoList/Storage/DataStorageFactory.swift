//
//  DataStorageFactory.swift
//  TodoList
//
//  Created by Aman Joshi on 18/07/21.
//

import Foundation

struct DataStorageFactory {

 static func get() -> DataStorageProtocol {
    return self.getDataStorage()
  }

  private static func getDataStorage() -> DataStorage {
    return DataStorage(context: PersistenceController.shared.container.viewContext)
  }
}
