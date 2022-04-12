//
//  PrizebreakupCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

class PrizebreakupCell: UITableViewCell {

    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var winningLbl: UILabel!
    @IBOutlet var lineLbl: UILabel!

    
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
        return String(describing: PrizebreakupCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: PrizebreakupCell.cellIdentifier(), bundle: nil)
    }
}

