//
//  ViewExtension.swift
//  WeSolve
//
//  Created by Abhishek Agarwal on 12/05/19.
//  Copyright © 2019 Abhishek Agarwal. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView Extensions
@IBDesignable
extension UIView {
    
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.both
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(duration: TimeInterval = 0.3, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.both
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    //
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor as? UIColor
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor as? UIColor
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 3
            self.layer.masksToBounds = false
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        }
    }

    func setNormalRoundedShadow(_ color:UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }

    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
        
    func dropShadowOnView(scale: Bool = true) {
        // MARK: - Shade a view
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.1, height: 1.5)
        self.layer.shadowRadius = CGFloat(1.0)
        self.layer.shadowOpacity = 0.24
    }
    
    func shadow(_ color:UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.1, height: 1.0)
    }
    
    func makeViewGradientTransparent() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y:0.0)
        let whiteColor = UIColor.white
        gradient.colors = [whiteColor.withAlphaComponent(0.8).cgColor, whiteColor.withAlphaComponent(1.0), whiteColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.0),NSNumber(value: 0.0),NSNumber(value: 0.8)]
        gradient.frame = self.bounds
        self.layer.mask = gradient
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func setBorder(_ color:UIColor, borderWidth:CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func vibrate() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.02
        animation.repeatCount = 2
        animation.speed = 0.5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2.0, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func shake() {
        self.transform = CGAffineTransform(translationX: 5, y: 5)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func setTapperTriangleShape(_ color:UIColor) {
        // Build a triangular path
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0,y: 0))
        path.addLine(to: CGPoint(x: 40,y: 40))
        path.addLine(to: CGPoint(x: 0,y: 100))
        path.addLine(to: CGPoint(x: 0,y: 0))
        
        // Create a CAShapeLayer with this triangular path
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        
        // Mask the view's layer with this shape
        self.layer.mask = mask
        
        self.backgroundColor = color
        
        // Transform the view for tapper shape
      //  self.transform = CGAffineTransform(rotationAngle: CGFloat(270) * CGFloat(M_PI_2) / 180.0)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(270) * CGFloat(Double.pi) / 2 / 180.0)
    }
    
    func setHorizontalGradientColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        gradientLayer.colors = [UIColor(red: 5.0/255.0, green: 34.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor, UIColor(red: 29.0/255.0, green: 144.0/255.0, blue: 244.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension String {
    func trimWhiteSpace () -> String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
}

class ShadowView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      didLoad()
    }

    func didLoad() {
      self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
      layer.masksToBounds = false
      layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
      layer.shadowOpacity = 1.0
      layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowRadius = 1.5
      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = 1
    }
}
// MARK: - image extension
extension UIImage {
    func resize(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
        let widthRatio  = width / size.width
        let heightRatio = height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
// MARK: - imageView extension to change the image colors

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
//MARK: setting top left and right corner radius
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    @objc func corner(view:UIView){
        view.layer.cornerRadius = view.bounds.height/2
    }

}
@IBDesignable
open class MYGradientView: UIView {
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradient.frame = bounds
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }

    private var gradient: CAGradientLayer?

    @IBInspectable
    public var color1: UIColor? {
        didSet {
            updateColors()
        }
    }

    @IBInspectable
    public var color2: UIColor? {
        didSet {
            updateColors()
        }
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        gradient = createGradient()
        updateColors()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        gradient = createGradient()
        updateColors()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradient?.frame = bounds
    }

    private func updateColors() {
        guard
            let color1 = color1,
            let color2 = color2
        else {
            return
        }

        gradient?.colors = [color1.cgColor, color2.cgColor]
    }
}
extension UIView {
    func insertHorizontalGradient(_ color1: UIColor, _ color2: UIColor) -> MYGradientView {
        let gradientView = MYGradientView(frame: bounds)
        gradientView.color1 = color1
        gradientView.color2 = color2
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.insertSubview(gradientView, at: 0)
        return gradientView
    }
}

extension UIView {
    // giving constrainst to subviews
    func setSubviewOnTheView(_ view: UIView){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

class RoundCornerView: MYGradientView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight], radius: 8)
    }
}
