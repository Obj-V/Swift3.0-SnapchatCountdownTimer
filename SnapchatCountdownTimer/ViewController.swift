//
//  ViewController.swift
//  SnapchatCountdownTimer
//
//  Created by Virata Yindeeyoungyeon on 10/30/16.
//  Copyright © 2016 Virata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pieWidth = self.view.bounds.width/2
        let pieX = self.view.bounds.width/4
        let pieY = self.view.center.y - self.view.bounds.width/4
        
        let pieTimerFrame = CGRect(x: pieX, y: pieY, width: pieWidth, height: pieWidth)
        var pieTimer = PieTimerView(frame: pieTimerFrame, totalTimer: 50)
        
        self.view.addSubview(pieTimer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

