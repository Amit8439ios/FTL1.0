//
//  RulesCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 30/03/22.
//

import UIKit

class RulesCell: UITableViewCell {
    @IBOutlet var titileLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - cell creation and identification methods

    class func cellIdentifier() -> String {
        return String(describing: RulesCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: RulesCell.cellIdentifier(), bundle: nil)
    }
}
