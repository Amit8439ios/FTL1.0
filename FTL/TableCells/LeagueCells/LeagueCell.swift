//
//  LeagueCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 24/03/22.
//

import UIKit

class LeagueCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var titleLBL: UILabel!
    @IBOutlet var titleView: UIView!
    
    @IBOutlet var amountLbl: UILabel!
    @IBOutlet var entryBtnView: UIView!
    @IBOutlet var entryBtn: UIButton!
    
    @IBOutlet var prizePoolLbl: UILabel!
    @IBOutlet var firstPrizeLbl: UILabel!
    
    @IBOutlet var progressBar: LinearProgressView!
    @IBOutlet var leftSpotsLbl: UILabel!
    @IBOutlet var totalSpotsLbl: UILabel!

    
    @IBOutlet var statusView: RoundCornerView!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var statuslabelLeadingConstraint: NSLayoutConstraint!
    
    var entryBtnTap: (()->()) = {}
    
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        entryBtnView.backgroundColor = purple
        containerView.dropShadowOnView(scale: true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: LeagueCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: LeagueCell.cellIdentifier(), bundle: nil)
    }
    //MARK: - actionMethods
    @IBAction func entryBtnAction(sender: UIButton){
        entryBtnTap()
    }
}
