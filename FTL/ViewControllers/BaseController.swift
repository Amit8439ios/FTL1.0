//
//  BaseController.swift
//  FTL
//
//  Created by Varun Kumar Raghav on 31/03/22.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - dissmissing Keyboard on tapping the view
extension BaseController {
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
