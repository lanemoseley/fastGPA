//
//  ViewController.swift
//  GPA Calculator
//
//  Created by Lane Moseley on 11/26/19.
//  Copyright © 2019 Lane Moseley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // credit cells
    @IBOutlet weak var credits_1: UILabel!
    @IBOutlet weak var credits_2: UILabel!
    @IBOutlet weak var credits_3: UILabel!
    @IBOutlet weak var credits_4: UILabel!
    @IBOutlet weak var credits_5: UILabel!
    
    // grade cells
    @IBOutlet weak var grade_1: UILabel!
    @IBOutlet weak var grade_2: UILabel!
    @IBOutlet weak var grade_3: UILabel!
    @IBOutlet weak var grade_4: UILabel!
    @IBOutlet weak var grade_5: UILabel!
    
    // resulting gpa cell
    @IBOutlet weak var result: UILabel!
    
    // grade options
    let grades = ["A", "B", "C", "D", "F"]
    let credits = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
    
    // credit steppers
    @IBAction func credit_stepper_1(_ sender: UIStepper) {
        credits_1.text = String(credits[Int(sender.value)])
    }
    
    @IBAction func credit_stepper_2(_ sender: UIStepper) {
        credits_2.text = String(credits[Int(sender.value)])
    }
    
    @IBAction func credit_stepper_3(_ sender: UIStepper) {
        credits_3.text = String(credits[Int(sender.value)])
    }
    
    @IBAction func credit_stepper_4(_ sender: UIStepper) {
        credits_4.text = String(credits[Int(sender.value)])
    }
    
    @IBAction func credit_stepper_5(_ sender: UIStepper) {
        credits_5.text = String(credits[Int(sender.value)])
    }
    
    // grade steppers
    @IBAction func grade_stepper_1(_ sender: UIStepper) {
        grade_1.text = grades[Int(sender.value)]
    }
    
    @IBAction func grade_stepper_2(_ sender: UIStepper) {
        grade_2.text = grades[Int(sender.value)]
    }
    
    @IBAction func grade_stepper_3(_ sender: UIStepper) {
        grade_3.text = grades[Int(sender.value)]
    }
    
    @IBAction func grade_stepper_4(_ sender: UIStepper) {
        grade_4.text = grades[Int(sender.value)]
    }
    
    @IBAction func grade_stepper_5(_ sender: UIStepper) {
        grade_5.text = grades[Int(sender.value)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

