//
//  ViewController.swift
//  Mikolaj_Bochenek_iOS_Lab1_PAM
//
//  Created by Student on 20/03/2021.
//  Copyright © 2021 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var _randomValue = 0
    private var _roundCounter = 1
    private var _totalPoints = 0
    
    @IBOutlet weak var randomValueLabel: UILabel!
    @IBOutlet weak var roundCounterLabel: UILabel!
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func checkEvent(_ sender: UIButton) {
        let points = calculatePoints(sliderValue: slider.value)
        if (_roundCounter < 10) {
            showContinueGameAlert(points: points)
        }
        else {
            showEndGameAlert(points: points)
        }
    }
    
    @IBAction func resetEvent(_ sender: UIButton) {
        reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundStart()
    }
    
    func roundStart() {
        _randomValue = Int.random(in: 1...100)
        randomValueLabel.text = String(_randomValue)
        roundCounterLabel.text = String(_roundCounter)
        totalPointsLabel.text = String(_totalPoints)
    }
    
    func calculatePoints(sliderValue: Float) -> Int {
        return (100 - abs(_randomValue - Int(sliderValue)))
    }
    
    func showContinueGameAlert(points: Int) {
        let alert = UIAlertController(title: "Aktualny wynik", message: "Uzyskane punkty w tej rundzie: " + String(points), preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Graj", style: .default, handler: { action in self.play(points: points) })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showEndGameAlert(points: Int) {
        let alert = UIAlertController(title: "Końcowy wynik", message: "Wszystkie uzyskane punkty: " + String(_totalPoints + points), preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Reset", style: .default, handler: { action in self.reset() })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func play(points: Int) {
        _totalPoints = _totalPoints + points
        _roundCounter += 1
        roundStart()
    }
    
    func reset() {
        _totalPoints = 0
        _roundCounter = 1
        roundStart()
    }
}
