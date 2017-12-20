//
//  ViewController.swift
//  BullsEye
//
//  Created by 江晓东 on 04/11/2017.
//  Copyright © 2017 JxJayden. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue: Int = 0
    var targetValue: Int = 0
    var fullPoint: Int = 100
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        setSliderFace()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNewRound() {
        round += 1
        currentValue = 50
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        updateLabelText()
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
        let transtion = CATransition()
        transtion.type = kCATransitionFade
        transtion.duration = 1
        transtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transtion, forKey: nil)
    }
    
    func updateLabelText() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func setSliderFace() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = fullPoint - difference
        let title: String
        if difference == 0 {
            title = "完美表现"
            points += 100
        } else if difference < 5 {
            title = "太棒了！就差一点点"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "很不错，继续努力！"
        } else {
            title = "差太远了"
        }
        score += points
        let message = "你的数值是：\(currentValue)" + "\n目标数值是：\(targetValue)" + "\n得分是：\(points)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "继续加油", style: .default, handler: {
            action in self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
}

