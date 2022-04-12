//
//  TransactionHistoryVC.swift
//  FTL
//
//  Created by amit toroi on 25/03/22.
//

import UIKit

class TransactionHistoryVC: UIViewController {

    @IBOutlet var transactionHistoryTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

         transactionHistoryTable.register(UINib(nibName: "TransactionHistoryCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        transactionHistoryTable.delegate = self
        transactionHistoryTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension TransactionHistoryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = transactionHistoryTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionHistoryCell
        return cell
    }
    
    
}
