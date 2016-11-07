//
//  PieTimerView.swift
//  SnapchatCountdownTimer
//
//  Created by Virata Yindeeyoungyeon on 10/30/16.
//  Copyright © 2016 Virata. All rights reserved.
//

import UIKit

class PieTimerView: UIView {
    
    //MARK : Timer
    //Note that you can use a media time callback instead of this nstimer/timer. 
    private var timer: Timer?
    func startTimer(outerRingDuration:Int!, innerPieDuration:Int!) {
        ringTotalTime = outerRingDuration
        pieTotalTime = innerPieDuration
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    @objc func updateTimer() {
        pieCountdownTime = pieCountdownTime + 1
        ringCountdownTime =  ringCountdownTime + 1
    }
    
    //MARK : private vars
    private var ringTotalTime : Int!
    private var ringCountdownTime : Int! = 0 {
        didSet {
            if ringCountdownTime > ringTotalTime {
                ringCountdownTime = 0
                outerRingLayer.strokeEnd = 1
            } else {
                let progressRing = Float(ringCountdownTime) / Float(ringTotalTime)
                outerRingLayer.strokeEnd = CGFloat(1 - progressRing)
            }
        }
    }
    
    private var pieTotalTime : Int!
    private var pieCountdownTime : Int! = 0 {
        didSet {
            if pieCountdownTime == pieTotalTime {
                stopTimer()
            }
            
            let endRadiusAngle = CGFloat(2*M_PI) * CGFloat(pieCountdownTime) / CGFloat(pieTotalTime) + startAngle
            innerPieLayer.path = self.innerPiePath(startAngle: startAngle, endAngle: endRadiusAngle)
        }
    }
    
    //MARK : Apple methods
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
            outerRingLayer.strokeEnd = 1
            
            let ringPath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: outerRingLineWidth, dy: outerRingLineWidth)).reversing()
            outerRingLayer.path = ringPath.cgPath
            outerRingLayer.transform = CATransform3DMakeRotation(CGFloat(-1*M_PI_2), 0, 0, 1)

            self.layer.addSublayer(outerRingLayer)
        }
    }
    
    //MARK : inner pie
    private var innerPieLayer : CAShapeLayer!
    private let startAngle : CGFloat! = CGFloat(-1*M_PI_2)
    private var endAngle : CGFloat! = CGFloat(-1*M_PI_2)
    private func setupInnerPie() {
        if innerPieLayer == nil {
            innerPieLayer = CAShapeLayer()
            innerPieLayer.frame = self.layer.bounds
            innerPieLayer.strokeColor = nil
            innerPieLayer.fillColor = UIColor.lightGray.cgColor
            innerPieLayer.path = self.innerPiePath(startAngle: startAngle, endAngle: endAngle)
            
            self.layer.addSublayer(innerPieLayer)
        }
    }
    
    private func innerPiePath(startAngle:CGFloat, endAngle:CGFloat) -> CGPath {
        if startAngle == endAngle {
            return UIBezierPath(ovalIn:self.bounds.insetBy(dx: 2*outerRingLineWidth, dy: 2*outerRingLineWidth)).cgPath
        }
        
        let centerPoint = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let innerPieRadius:CGFloat! = self.bounds.width/2 - (2*outerRingLineWidth)
        
        let initialPointX = centerPoint.x + (innerPieRadius * CGFloat(cos(startAngle)))
        let initialPointY = centerPoint.y + (innerPieRadius * CGFloat(sin(startAngle)))
        
        let innerPiePath = UIBezierPath()
        innerPiePath.move(to: centerPoint)
        innerPiePath.addLine(to: CGPoint(x: initialPointX, y: initialPointY))
        innerPiePath.addArc(withCenter: centerPoint, radius: innerPieRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        innerPiePath.close()
        
        return innerPiePath.cgPath
    }

}
