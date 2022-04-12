//
//  OrdersCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 04/04/22.
//

import UIKit

class OrdersCell: UITableViewCell {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    @IBOutlet var flowImg: UIImageView!
    @IBOutlet var lineLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: OrdersCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: OrdersCell.cellIdentifier(), bundle: nil)
    }
}
