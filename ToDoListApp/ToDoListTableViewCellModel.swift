//
//  ToDoListTableViewCellModel.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import Foundation
enum ToDoListTableViewCellType {
    case data
    case noData
}
class ToDoListTableViewCellModel: NSObject {
    var identifier: String = "todoList.tableCell.data"
    var tasks: String = ""
    var cellType: ToDoListTableViewCellType = .data
    init(tasks: String, cellType: ToDoListTableViewCellType) {
        self.tasks = tasks
        switch cellType {
        case .data:
            self.identifier = "todoList.tableCell.data"
        case .noData:
            self.identifier = "todoList.tableCell.noData"
        }
    }
    func getTasks()-> String {
        return tasks
    }
}
