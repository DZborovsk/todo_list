//
//  TodoTableViewCell.swift
//  ToDo List
//
//  Created by Danyil Zborovskyi on 6/22/19.
//  Copyright © 2019 BlueWolf Development. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var checkmarkLabel: UILabel!
    @IBOutlet weak var todoTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
