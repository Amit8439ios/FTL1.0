//
//  HeaderTitleCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 25/03/22.
//

import UIKit

class HeaderTitleCell: UITableViewCell {

    @IBOutlet var titleLbl: UILabel!
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - cell creation and identification methods

    class func cellIdentifier() -> String {
        return String(describing: HeaderTitleCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: HeaderTitleCell.cellIdentifier(), bundle: nil)
    }
}

