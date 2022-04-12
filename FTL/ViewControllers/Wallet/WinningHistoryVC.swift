//
//  WinningHistoryVC.swift
//  FTL
//
//  Created by amit toroi on 25/03/22.
//

import UIKit

class WinningHistoryVC: UIViewController, UITableViewDelegate {

    @IBOutlet var winningHistoryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        winningHistoryTable.register(UINib(nibName: "WinningHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        winningHistoryTable.delegate = self
        winningHistoryTable.dataSource = self
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension WinningHistoryVC:UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = winningHistoryTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WinningHistoryCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
