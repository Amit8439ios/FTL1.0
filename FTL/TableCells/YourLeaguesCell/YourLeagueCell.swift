//
//  YourLeagueCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 25/03/22.
//

import UIKit

class YourLeagueCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet var titleLBL: UILabel!
    @IBOutlet var titleView: UIView!
    
    @IBOutlet var freqencyLbl: UILabel!
    @IBOutlet var rankTitleLbl: UILabel!
    @IBOutlet var rankLbl: UILabel!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var prizePoolLbl: UILabel!
    @IBOutlet var firstPrizeLbl: UILabel!

    
    @IBOutlet var statusView: RoundCornerView!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var statuslabelLeadingConstraint: NSLayoutConstraint!
    
    var playBtnTap: (()->()) = {}
    
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadowOnView(scale: true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: YourLeagueCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: YourLeagueCell.cellIdentifier(), bundle: nil)
    }
    
    // MARK: - action methods
    @IBAction func playBtnAction(sender: UIButton) {
        self.playBtnTap()
    }
}
