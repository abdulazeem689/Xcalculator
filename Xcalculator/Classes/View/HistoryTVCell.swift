//
//  HistoryTVCell.swift
//  Xcalculator
//
//  Created by Abdul Azeem on 08/09/20.
//  Copyright © 2020 Mindfire. All rights reserved.
//

import UIKit

class HistoryTVCell: UITableViewCell {

    @IBOutlet var expressionLbl: UILabel!
    @IBOutlet var resLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
