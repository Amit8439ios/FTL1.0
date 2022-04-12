//
//  HowToPlayVC.swift
//  FTL
//
//  Created by amit toroi on 27/03/22.
//

import UIKit

class HowToPlayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
}


extension String{
    var htmlAttributedString : NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do{
            return try NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch{
            return nil
        }
    }
}
