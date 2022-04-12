//
//  SuperLeagueCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 25/03/22.
//

import UIKit

class SuperLeagueCell: UITableViewCell {
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
    
    

    
    @IBOutlet var leagueStatusView: RoundCornerView!
    @IBOutlet var leagueStatusLbl: UILabel!
    @IBOutlet var leagueStatusImg: UIImageView!
    @IBOutlet var leagueStatuslabelLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var statusView: RoundCornerView!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var statusImg: UIImageView!
    @IBOutlet var statuslabelLeadingConstraint: NSLayoutConstraint!
    var entryBtnTap: (()->()) = {}
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressBar.trackColor = gold
        progressBar.setHorizontalGradientColor()
        containerView.backgroundColor = purple
        entryBtnView.backgroundColor = gold
        containerView.dropShadowOnView(scale: true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - cell creation and identification methods
    
    class func cellIdentifier() -> String {
        return String(describing: SuperLeagueCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: SuperLeagueCell.cellIdentifier(), bundle: nil)
    }
    
    //MARK: - actionMethods
    @IBAction func entryBtnAction(sender: UIButton){
        entryBtnTap()
    }
}

