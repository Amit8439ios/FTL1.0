//
//  GradientView.swift
//  FTL
//
//  Created by amit toroi on 21/03/22.
//

import Foundation
import UIKit
@IBDesignable
class GradientView: UIView{
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.003921568627, green: 0.2784313858, blue: 0.4, alpha: 1)
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    
    var startPointX:CGFloat = 0
    var startPointY:CGFloat = 0
    var endPointX:CGFloat = 1
    var endPointY:CGFloat = 1
    
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
