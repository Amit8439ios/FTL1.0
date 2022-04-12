//
//  HoldingsCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

class HoldingsCell: UITableViewCell {
    @IBOutlet var titileLbl: UILabel!
    @IBOutlet var investmentLbl: UILabel!
    @IBOutlet var subtitleLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var statusView: UIView!
    @IBOutlet var lineLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: HoldingsCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: HoldingsCell.cellIdentifier(), bundle: nil)
    }
}
