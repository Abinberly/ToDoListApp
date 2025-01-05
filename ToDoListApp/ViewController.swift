//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var cellModels: [ToDoListTableViewCellModel] = []
    var tasks: [Task] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).context
    
    @IBOutlet weak var tblToDoList: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCellModels()
        fetchTasks()
    }

    func fetchTasks() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
            request.sortDescriptors = [sortDescriptor]
        do {
            tasks = try context.fetch(request)
            createCellModels()
        } catch {
            print("Error fetching tasks \(error)")
        }
    }
    
    func createCellModels() {
        cellModels = []
        for task in tasks {
            let cellModel = ToDoListTableViewCellModel(tasks: task, cellType: .data)
            cellModels.append(cellModel)
        }
        
        if tasks.isEmpty {
            cellModels.append(ToDoListTableViewCellModel(cellType: .noData))
        }
        
        DispatchQueue.main.async {
            self.tblToDoList?.reloadData()
        }
    }
    
    func saveContext() {
        do {
            try context.save()
            fetchTasks()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    @IBAction func didClickAddTask(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add Task", message: "Enter task details", preferredStyle: .alert)
        alert.addTextField { textfield in
            textfield.placeholder = "Enter task name."
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Priority (1 = Low, 2 = Medium, 3 = High)"
            textfield.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let name = alert.textFields?[0].text, !name.isEmpty, let priorityText = alert.textFields?[1].text, let priority = Int16(priorityText) else { return }
            
            let newTask = Task(context: self.context)
            newTask.name = name
            newTask.priority = priority
            self.saveContext()
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        guard let cell = tblToDoList?.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as? ToDoListTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = cellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { deleteAction, sourceView, completionHandler in
            self.tasks.remove(at: indexPath.row)
            self.createCellModels()
            completionHandler(true)
        }
        if let originalImage = UIImage(named: "trash.can") {
            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 24, height: 24)).image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
            }
            deleteAction.image = resizedImage
        }
        deleteAction.backgroundColor = .white
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
    }
}
