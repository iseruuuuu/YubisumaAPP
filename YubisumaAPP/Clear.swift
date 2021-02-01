//
//  Clear.swift
//  YubisumaAPP
//
//  Created by 井関竜太郎 on 2021/01/27.
//

import Foundation


import UIKit

class Clear :UIViewController {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var what: UILabel!
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var elapsedTime: Double = 0.0
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.yellow
        setButtonEnable(start:true, stop:false)
    }
    
    func setButtonEnable(start:Bool,stop:Bool){
        self.button.isEnabled = start
        self.button2.isEnabled = stop
    }
    
    @objc func update() {
        if let startTime = self.startTime {
            let t: Double = Date.timeIntervalSinceReferenceDate - startTime + self.elapsedTime
            let min = Int(t / 60)
            let sec = Int(t) % 60
            let msec = Int(t * 100) % 100
            let mmsec = Int(t * 100 * 100) % 100
            let mmmsec = Int(t * 100 * 100 * 100) % 100
            let mmmmsec = Int(t * 100 * 100 * 100 * 100) % 100
            let mmmmmsec = Int(t * 100 * 100 * 100 * 100 * 100) % 100
            self.time.text = String(format: "%02d:%02d:%02d:%02d:%02d:%02d:%02d", min, sec, msec, mmsec, mmmsec, mmmmsec,mmmmmsec)
            if sec == 10 && msec == 00 && mmsec == 00 && mmmsec == 00 && mmmmsec == 00 && mmmmmsec == 0{
                self.time.text = "10:00:@L6Kv4:00:00:"
            } else {
                self.time.text = String(format: "%02d:%02d:%02d:%02d:%02d:%02d:%02d", min, sec, msec, mmsec, mmmsec, mmmmsec,mmmmmsec)
            }
        }
    }
    
    
    @IBAction func start(_ sender: Any) {
        setButtonEnable(start: false, stop: true)
        self.startTime = Date.timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @IBAction func stop(_ sender: Any) {
        setButtonEnable(start: true, stop: false)
        if let startTime = self.startTime {
            self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime
        }
        self.timer.invalidate()
    }
    
}
