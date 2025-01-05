//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import UIKit

class ViewController: UIViewController {

    var cellModels: [ToDoListTableViewCellModel] = []
    var tasks: [Task] = []
    
    @IBOutlet weak var tblToDoList: UITableView?
    @IBOutlet weak var txtTasksField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCellModels()
    }

    func createCellModels() {
        cellModels = []
        cellModels.append(ToDoListTableViewCellModel(tasks: "", cellType: .data))
        DispatchQueue.main.async {
            self.tblToDoList?.reloadData()
        }
    }

    @IBAction func didClickAddTask(_ sender: UIButton) {
        print("Value --==---==---==---==>>>", txtTasksField?.text ?? "123")
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
}


//Extensions
extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            guard let color = self.layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var clipsToCircle: Bool {
        get {
            return false
        }
        set {
            self.layer.cornerRadius = self.frame.height/2
        }
    }
}
