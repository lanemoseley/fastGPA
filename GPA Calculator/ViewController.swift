///
/// Program Name: Semester Project, Swift
/// Author: Lane Moseley
/// Class: CSC 461, Programming Languages, M-01, Fall, 2019
/// Language\Compiler: Swift 5.1
///
/// Description: This is a GPA Calculator app developed for iOS.  It allows the user to
/// add grades and credit hours for up to five classes and see the resulting GPA.
///
/// Known Bugs: No bugs known at this time.
///

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
    
    // past gpa info
    @IBOutlet weak var old_gpa_field: UITextField!
    @IBOutlet weak var old_hours_field: UITextField!
    
    // resulting gpa cells
    @IBOutlet weak var cumulative_result: UILabel!
    @IBOutlet weak var result: UILabel!
    
    // instantiate gpa calculator
    let gpaCalc = gpaCalculator()
        
    /// Author: Lane Moseley
    /// This function will initiate an update of the resultant GPA
    func updateGPA() {
        // collect grades and credits
        let grades: [courseInfo] = [courseInfo(grade: grade_1.text!, credits: Double(credits_1.text!)!),
                                    courseInfo(grade: grade_2.text!, credits: Double(credits_2.text!)!),
                                    courseInfo(grade: grade_3.text!, credits: Double(credits_3.text!)!),
                                    courseInfo(grade: grade_4.text!, credits: Double(credits_4.text!)!),
                                    courseInfo(grade: grade_5.text!, credits: Double(credits_5.text!)!)]
        
        // update gpa
        result.text = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        
        // update cumulative gpa
        cumulative_result.text = String(format: "%.3f", gpaCalc.new_cumulative_gpa)
    }
    
    // credit steppers ////
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
    
    // grade steppers ////
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

    // viewDidLoad ////
    override func viewDidLoad() {
        super.viewDidLoad()
        old_hours_field.delegate = self
        old_gpa_field.delegate = self
    }
    
    /// Author: Lane Moseley
    /// This function will initiate an update of the cumulative GPA
    @IBAction func update_pressed(_ sender: Any) {
        if (Double(old_gpa_field.text!) == nil || Double(old_hours_field.text!) == nil) { return }
        
        gpaCalc.cumulative_gpa = Double(old_gpa_field.text!)!
        gpaCalc.total_hours = Double(old_hours_field.text!)!
        
        updateGPA()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
