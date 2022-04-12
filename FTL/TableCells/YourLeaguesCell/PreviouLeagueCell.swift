//
//  PreviouLeagueCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 28/03/22.
//

import UIKit

class PreviouLeagueCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet var titleLBL: UILabel!
    @IBOutlet var titleView: UIView!
    
    @IBOutlet var freqencyLbl: UILabel!
    
    @IBOutlet var rankTitleLbl: UILabel!
    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var rankImg: UIImageView!

    
    @IBOutlet var prizePoolLbl: UILabel!
    @IBOutlet var firstPrizeLbl: UILabel!
    @IBOutlet var winningsLbl: UILabel!
   
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadowOnView(scale: true)
        self.rankImg.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: PreviouLeagueCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: PreviouLeagueCell.cellIdentifier(), bundle: nil)
    }
}
