//
//  ViewController.swift
//  BullsEye
//
//  Created by yara mohamed on 4/9/17.
//  Copyright © 2017 yara mohamediCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var currentValue : Int = 0
    var targetValue : Int = 0
    var totalScore : Int = 0
    var round : Int = 0
    var msg : String = ""
    @IBOutlet var slider : UISlider!
    @IBOutlet var targetScoreLabel : UILabel!
    @IBOutlet var roundLabel : UILabel!
    @IBOutlet var totalScoreLabel : UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        slider.setThumbImage(UIImage(named: "SliderThumb-Normal.png"), for: .normal)
        slider.setThumbImage(UIImage(named: "SliderThumb-Highlighted.png"), for: .highlighted)
        let leftTrackImage = UIImage(named: "SliderTrackLeft")
        slider.setMinimumTrackImage(leftTrackImage?.resizableImage(withCapInsets: .init(top: 10, left: 10, bottom: 10, right: 10)), for: .normal)
        slider.setMinimumTrackImage(leftTrackImage?.resizableImage(withCapInsets: .init(top: 10, left: 10, bottom: 10, right: 10)), for: .highlighted)
        let rightTrackImage = UIImage(named: "SliderTrackRight")
        slider.setMaximumTrackImage(rightTrackImage?.resizableImage(withCapInsets: .init(top: 10, left: 10, bottom: 10, right: 10)), for: .normal)
        slider.setMaximumTrackImage(rightTrackImage?.resizableImage(withCapInsets: .init(top: 10, left: 10, bottom: 10, right: 10)), for: .highlighted)
        startNewRound()

    }


//    @IBAction func info(_ sender: Any)
//    {
//        let message = "Try to reach the target as much as you can then press Hit Me button !!! ... Simple but enjoyable game"
//        let alert = UIAlertController(title: "Bull's Eye", message: message, preferredStyle: .alert)
//        
//        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
//        
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ShowAlert(_ sender: Any)
    {
        let roundScore = calculateScore()
        let message = "You scored \(roundScore) points \n Your value is: \(currentValue) \n Your target is: \(targetValue)"
        let alert = UIAlertController(title: msg, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in self.startNewRound()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

    @IBAction func SliderMoved(_ slider: UISlider)
    {
        currentValue = lroundf(slider.value)
    }
    func update()
    {
        round+=1
        targetScoreLabel.text = String(targetValue)
        roundLabel.text = String(round)
        totalScoreLabel.text = String(totalScore)
        
    }
    
    @IBAction func reset(_ sender: Any)
    {
        round = 0
        totalScore = 0
        startNewRound()
    }

    
    func calculateScore() -> Int
    {
        var bonus : Int = 0
        var diff : Int = 0
        if(targetValue-currentValue==0)
        {
            bonus = 100
            diff = 0
            msg = "perfect!"
            
        }
        else if(abs(targetValue-currentValue)<5)
        {
            bonus = 50
            diff = abs(targetValue-currentValue)
            msg = "You almost had it!"
        }
        else if(abs(targetValue-currentValue)<10)
        {
            bonus = 0
            diff = abs(targetValue-currentValue)
            msg = "Pretty good!"
        }
        else
        {
            bonus = 0
            diff = abs(targetValue-currentValue)
            msg = "Not even close..."
        }
        totalScore+=100+bonus-diff
        return 100+bonus-diff
    }
    func startNewRound()
    {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        update()
    }
}

