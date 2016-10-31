//
//  PieTimerView.swift
//  SnapchatCountdownTimer
//
//  Created by Virata Yindeeyoungyeon on 10/30/16.
//  Copyright © 2016 Virata. All rights reserved.
//

import UIKit

class PieTimerView: UIView {
    
    //MARK : public
    func startTimer() {
        
    }
    
    func stopTimer() {
        
    }
    
    //MARK : private
    private var totalTimer : Int! {
        didSet {}
    }
    private var countdownTimer : Int! = 0 {
        didSet {}
    }
    
    convenience init(frame pieframe:CGRect, totalTimer:Int) {
        self.init(frame: pieframe)
        self.totalTimer = totalTimer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.createPieChart()
    }
    
    private func createPieChart() {
        self.circularBackground()
        self.outerRing()
    }
    
    //MARK : circular background
    private var backgroundLayer : CAShapeLayer!
    private func circularBackground() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            backgroundLayer.frame = self.layer.bounds
            
            let circularPath = UIBezierPath(ovalIn: self.bounds)
            backgroundLayer.path = circularPath.cgPath
            backgroundLayer.fillColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
            
            self.layer.addSublayer(backgroundLayer)
        }
    }
    
    //MARK : outer ring
    private var outerRingLayer : CAShapeLayer!
    private var outerRingLineWidth : CGFloat! {
        return self.bounds.width/20
    }
    private func outerRing() {
        if outerRingLayer == nil {
            outerRingLayer = CAShapeLayer()
            outerRingLayer.frame = self.layer.bounds
            outerRingLayer.strokeColor = UIColor.white.cgColor
            outerRingLayer.lineWidth = outerRingLineWidth
            outerRingLayer.fillColor = nil
            outerRingLayer.strokeStart = 0
            outerRingLayer.strokeEnd = 1 - 0.2 
            
            let ringPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: outerRingLineWidth, dy: outerRingLineWidth))
            outerRingLayer.path = ringPath.cgPath
            outerRingLayer.transform = CATransform3DMakeRotation(CGFloat(-1*M_PI_2), 0, 0, 1)
            
            self.layer.addSublayer(outerRingLayer)
        }
    }

}
