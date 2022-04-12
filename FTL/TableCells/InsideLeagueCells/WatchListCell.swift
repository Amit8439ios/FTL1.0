//
//  WatchListCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 31/03/22.
//

import UIKit

class WatchListCell: UITableViewCell {
    @IBOutlet var titileLbl: UILabel!
    @IBOutlet var subtitleLbl: UILabel!
    @IBOutlet var priceLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var statusView: UIView!
    @IBOutlet var starBtn: UIButton!
    @IBOutlet var starImg: UIImageView!
    @IBOutlet var lineLbl: UILabel!
    
    var starBtnTap: (()->())={}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: WatchListCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: WatchListCell.cellIdentifier(), bundle: nil)
    }
    
    // MARK: - action methods
    
    @IBAction func starBtnAction(sender: UIButton) {
        self.starBtnTap()
    }
}
