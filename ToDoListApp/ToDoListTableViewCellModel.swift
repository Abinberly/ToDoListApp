//
//  ToDoListTableViewCellModel.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import Foundation
import UIKit
enum ToDoListTableViewCellType {
    case data
    case noData
}
enum ToDoListPriorityType: Int {
    case one = 1
    case two = 2
    case three = 3
}
class ToDoListTableViewCellModel: NSObject {
    var identifier: String = "todoList.tableCell.data"
    var tasks: Task?
    var cellType: ToDoListTableViewCellType = .data
    init(tasks: Task = Task(), cellType: ToDoListTableViewCellType) {
        self.tasks = tasks
        switch cellType {
        case .data:
            self.identifier = "todoList.tableCell.data"
        case .noData:
            self.identifier = "todoList.tableCell.noData"
        }
    }
    func getTasksName()-> String {
        return tasks?.name ?? ""
    }
    func getTasksPriority()-> String {
        return "\(tasks?.priority ?? 0)"
    }
    func getCellColor()-> UIColor {
        var cellColor: UIColor = .clear
        guard let taskPriiority = tasks?.priority else { return cellColor }
        
        switch ToDoListPriorityType(rawValue: Int(taskPriiority)) {
        case .one:
            cellColor = .red
        case .two:
            cellColor = .yellow
        case .three:
            cellColor = .green
        default:
            cellColor = .clear
        }
        return cellColor
    }
}
