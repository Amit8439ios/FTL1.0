//
//  RulesVC.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 29/03/22.
//

import UIKit

class RulesVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    var datacount = 10
    
    //MARK: - lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialMethod()
    }
    //MARK: - initial setup Methods
    func initialMethod() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(RulesCell.createCellNib(), forCellReuseIdentifier: RulesCell.cellIdentifier())
    }
    
}
// MARK: - tableView Delegate and datasource
extension RulesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datacount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: RulesCell.cellIdentifier()) as? RulesCell else { return UITableViewCell() }
        return cell
    }
    
}
