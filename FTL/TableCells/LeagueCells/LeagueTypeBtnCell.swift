//
//  LeagueTypeBtnCell.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

class LeagueTypeBtnCell: UICollectionViewCell {
    @IBOutlet var leagueBtn: UIButton!
    @IBOutlet var leagueTitleLbl: UILabel!
    
    var btnTapped: (()->()) = {}
    
    // MARK: - cell life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - cell creation and identification methods
    class func cellIdentifier() -> String {
        return String(describing: LeagueTypeBtnCell.self)
    }
    class func createCellNib() -> UINib {
        return UINib(nibName: LeagueTypeBtnCell.cellIdentifier(), bundle: nil)
    }
    
    //MARK: - Action Methods
    @IBAction func leagueBtnAction(sender: UIButton){
        self.btnTapped()
    }
}

