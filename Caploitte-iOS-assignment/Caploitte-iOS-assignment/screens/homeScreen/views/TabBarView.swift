//
//  TabBarView.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-23.
//

import UIKit

@IBDesignable class TabBarView: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 25
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: radii, height: 0.0))
        
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        tabFrame.size.height = 30
        tabFrame.size.width = UIScreen.main.bounds.width - 100
        //tabFrame.origin.y = self.frame.origin.y + self.frame.height - 80
        self.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 1.1)
        self.frame.size.height = 60
        self.frame.size.width = UIScreen.main.bounds.width / 1.5
        self.layer.cornerRadius = 18
        //self.frame = tabFrame
        //self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -20) })
    }
    
}
