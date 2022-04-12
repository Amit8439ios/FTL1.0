//
//  LeaderBoardCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 30/03/22.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var playerLbl: UILabel!
    @IBOutlet var portfolioLbl: UILabel!
    @IBOutlet var playerImg: UIImageView!
    @IBOutlet var lineLbl: UILabel!
    @IBOutlet var playerLeadingConstraint: NSLayoutConstraint!

    
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
        return String(describing: LeaderBoardCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: LeaderBoardCell.cellIdentifier(), bundle: nil)
    }
}

