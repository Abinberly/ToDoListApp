//
//  ToDoListTableViewCell.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    var cellModel: ToDoListTableViewCellModel! {
        didSet {
            configureCell()
        }
    }
    @IBOutlet weak var lblTasks: UILabel?
    @IBOutlet weak var vwPriorityIndicator: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell() {
        lblTasks?.text = cellModel.getTasksName()
        vwPriorityIndicator?.backgroundColor = cellModel.getCellColor()
    }

}
