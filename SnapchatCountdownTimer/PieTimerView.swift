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
    
    //MARK : private vars
    private var totalTimer : Int! {
        didSet {}
    }
    private var countdownTimer : Int! = 0 {
        didSet {}
    }
    
    //MARK : Apple methods
    convenience init(frame pieframe:CGRect, totalTimer:Int) {
        self.init(frame: pieframe)
        self.totalTimer = totalTimer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.createPieChart()
    }
    
    //MARK : private methods
    private func createPieChart() {
        self.setupCircularBackground()
        self.setupOuterRing()
        self.setupInnerPie()
    }
    
    //MARK : circular background
    private var backgroundLayer : CAShapeLayer!
    private func setupCircularBackground() {
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
    private func setupOuterRing() {
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
    
    //MARK : inner pie
    private var innerPieLayer : CAShapeLayer!
    private let startAngle : CGFloat! = CGFloat(-1*M_PI_2)
    private func setupInnerPie() {
        if innerPieLayer == nil {
            innerPieLayer = CAShapeLayer()
            innerPieLayer.frame = self.layer.bounds
            innerPieLayer.strokeColor = nil
            innerPieLayer.fillColor = UIColor.lightGray.cgColor
            
            let centerPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
            let innerPieRadius:CGFloat! = self.bounds.width/2 - (2*outerRingLineWidth)
            
            let initialPointX = centerPoint.x + (innerPieRadius * CGFloat(cos(startAngle)))
            let initialPointY = centerPoint.y + (innerPieRadius * CGFloat(sin(startAngle)))
            
            let innerPiePath = UIBezierPath()
            innerPiePath.move(to: centerPoint)
            innerPiePath.addLine(to: CGPoint(x: initialPointX, y: initialPointY))
            innerPiePath.addArc(withCenter: centerPoint, radius: innerPieRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(M_PI_4), clockwise: true)
            innerPiePath.close()
            
            innerPieLayer.path = innerPiePath.cgPath
            
            self.layer.addSublayer(innerPieLayer)
        }
    }

}
