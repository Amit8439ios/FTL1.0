//
//  WinningHistoryCell.swift
//  FTL
//
//  Created by amit toroi on 25/03/22.
//

import UIKit

class WinningHistoryCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var transactionName: UILabel!
    @IBOutlet var transactionDate: UILabel!
    @IBOutlet var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = img.bounds.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
