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
    
    // instantiate gpa calculator
    let gpaCalc = gpaCalculator()
    
    // function to initiate an update of the gpa
    func updateGPA() {
        // collect grades and credits
        let grades: [courseInfo] = [courseInfo(grade: grade_1.text!, credits: Double(credits_1.text!)!),
                                    courseInfo(grade: grade_2.text!, credits: Double(credits_2.text!)!),
                                    courseInfo(grade: grade_3.text!, credits: Double(credits_3.text!)!),
                                    courseInfo(grade: grade_4.text!, credits: Double(credits_4.text!)!),
                                    courseInfo(grade: grade_5.text!, credits: Double(credits_5.text!)!)]
        
        // update gpa
        result.text = gpaCalc.getGPA(gradeInfo: grades)
    }
    
    // credit steppers
    @IBAction func credit_stepper_1(_ sender: UIStepper) {
        credits_1.text = String(gpaCalc.credits[Int(sender.value)])
        updateGPA()
    }
    
    @IBAction func credit_stepper_2(_ sender: UIStepper) {
        credits_2.text = String(gpaCalc.credits[Int(sender.value)])
        updateGPA()
    }
    
    @IBAction func credit_stepper_3(_ sender: UIStepper) {
        credits_3.text = String(gpaCalc.credits[Int(sender.value)])
        updateGPA()
    }
    
    @IBAction func credit_stepper_4(_ sender: UIStepper) {
        credits_4.text = String(gpaCalc.credits[Int(sender.value)])
        updateGPA()
    }
    
    @IBAction func credit_stepper_5(_ sender: UIStepper) {
        credits_5.text = String(gpaCalc.credits[Int(sender.value)])
        updateGPA()
    }
    
    // grade steppers
    @IBAction func grade_stepper_1(_ sender: UIStepper) {
        grade_1.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    @IBAction func grade_stepper_2(_ sender: UIStepper) {
        grade_2.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    @IBAction func grade_stepper_3(_ sender: UIStepper) {
        grade_3.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    @IBAction func grade_stepper_4(_ sender: UIStepper) {
        grade_4.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    @IBAction func grade_stepper_5(_ sender: UIStepper) {
        grade_5.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

