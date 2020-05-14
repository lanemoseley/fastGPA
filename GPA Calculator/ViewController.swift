///
/// Author: Lane Moseley
/// Language\Compiler: Swift 5.1
///
/// Description: This is a GPA Calculator app developed for iOS.  It allows the user to
/// add grades and credit hours for up to six classes and see the resulting GPA.
///
/// Known Bugs: No bugs known at this time.
///

import UIKit

class ViewController: UIViewController {
    // buttons
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var credit_stepper_1: UIStepper!
    @IBOutlet weak var credit_stepper_2: UIStepper!
    @IBOutlet weak var credit_stepper_3: UIStepper!
    @IBOutlet weak var credit_stepper_4: UIStepper!
    @IBOutlet weak var credit_stepper_5: UIStepper!
    @IBOutlet weak var credit_stepper_6: UIStepper!
    @IBOutlet weak var grade_stepper_1: UIStepper!
    @IBOutlet weak var grade_stepper_2: UIStepper!
    @IBOutlet weak var grade_stepper_3: UIStepper!
    @IBOutlet weak var grade_stepper_4: UIStepper!
    @IBOutlet weak var grade_stepper_5: UIStepper!
    @IBOutlet weak var grade_stepper_6: UIStepper!
    
    
    // credit cells
    @IBOutlet weak var credits_1: UILabel!
    @IBOutlet weak var credits_2: UILabel!
    @IBOutlet weak var credits_3: UILabel!
    @IBOutlet weak var credits_4: UILabel!
    @IBOutlet weak var credits_5: UILabel!
    @IBOutlet weak var credits_6: UILabel!
    
    // grade cells
    @IBOutlet weak var grade_1: UILabel!
    @IBOutlet weak var grade_2: UILabel!
    @IBOutlet weak var grade_3: UILabel!
    @IBOutlet weak var grade_4: UILabel!
    @IBOutlet weak var grade_5: UILabel!
    @IBOutlet weak var grade_6: UILabel!
    
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
                                    courseInfo(grade: grade_5.text!, credits: Double(credits_5.text!)!),
                                    courseInfo(grade: grade_6.text!, credits: Double(credits_6.text!)!)]
        
        // update gpa
        result.text = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        
        // update cumulative gpa
        if gpaCalc.cumulative_gpa == 0.0 && gpaCalc.total_hours == 0.0 {
            cumulative_result.text = "---"
        } else {
            cumulative_result.text = String(format: "%.3f", gpaCalc.new_cumulative_gpa)
        }
    }
    
    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_1(_ sender: UIStepper) {
        credits_1.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }

    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_2(_ sender: UIStepper) {
        credits_2.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_3(_ sender: UIStepper) {
        credits_3.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_4(_ sender: UIStepper) {
        credits_4.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_5(_ sender: UIStepper) {
        credits_5.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }

    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_6(_ sender: UIStepper) {
        credits_6.text = String(Int(gpaCalc.credits[Int(sender.value)]))
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_1(_ sender: UIStepper) {
        grade_1.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }

    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_2(_ sender: UIStepper) {
        grade_2.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_3(_ sender: UIStepper) {
        grade_3.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_4(_ sender: UIStepper) {
        grade_4.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_5(_ sender: UIStepper) {
        grade_5.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_6(_ sender: UIStepper) {
        grade_6.text = gpaCalc.grades[Int(sender.value)]
        updateGPA()
    }
    
    // viewDidLoad ////
    override func viewDidLoad() {
        super.viewDidLoad()

        // add targets to monitor text fields
        old_hours_field.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        old_gpa_field.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        
        // add "done" to decimal pad keyboard
        old_hours_field.addDoneButtonToKeyboard(myAction: #selector(self.old_hours_field.resignFirstResponder))
        old_gpa_field.addDoneButtonToKeyboard(myAction: #selector(self.old_gpa_field.resignFirstResponder))
        
        // move UITextFields up when keyboard shows
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// This function will move the UITextFields up when the keyboard shows
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
            
            // disable the steppers
            disableSteppers()
        }
    }
    
    /// This function will move the UITextFields back to their original location when the keyboard hides
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            
            // enable the steppers
            enableSteppers()
        }
    }
    
    func disableSteppers() {
        credit_stepper_1.isEnabled = false
        credit_stepper_2.isEnabled = false
        credit_stepper_3.isEnabled = false
        credit_stepper_4.isEnabled = false
        credit_stepper_5.isEnabled = false
        credit_stepper_6.isEnabled = false
        
        grade_stepper_1.isEnabled = false
        grade_stepper_2.isEnabled = false
        grade_stepper_3.isEnabled = false
        grade_stepper_4.isEnabled = false
        grade_stepper_5.isEnabled = false
        grade_stepper_6.isEnabled = false
    }
    
    func enableSteppers() {
        credit_stepper_1.isEnabled = true
        credit_stepper_2.isEnabled = true
        credit_stepper_3.isEnabled = true
        credit_stepper_4.isEnabled = true
        credit_stepper_5.isEnabled = true
        credit_stepper_6.isEnabled = true
        
        grade_stepper_1.isEnabled = true
        grade_stepper_2.isEnabled = true
        grade_stepper_3.isEnabled = true
        grade_stepper_4.isEnabled = true
        grade_stepper_5.isEnabled = true
        grade_stepper_6.isEnabled = true
    }
    
    func dismissKeyboard() {
        // dismiss the keyboard if it is up
        old_gpa_field.resignFirstResponder()
        old_hours_field.resignFirstResponder()
    }
    
    /// Author: Lane Moseley
    /// This function will initiate an update of the cumulative GPA
    @IBAction func update_pressed(_ sender: Any) {
        var success = false
        dismissKeyboard()
        resetButton.isEnabled = true
        
        // get and validate input
        if let gpa = Double(old_gpa_field.text!) {
            if let hours = Double(old_hours_field.text!) {
                if gpa >= 0.0 && gpa <= 4.0 && hours >= 0.0 && hours <= 5000.0 {
                    gpaCalc.cumulative_gpa = gpa
                    gpaCalc.total_hours = hours
                    updateGPA()
                    
                    success = true
                }
            }
        }
        
        // if input is invalid, display an error message
        if !success {
            let alertController = UIAlertController(title: "Whoops!", message:
                "Input is out of range or invalid.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Author: Lane Moseley
    /// This function will reset the cumulative GPA
    @IBAction func reset_pressed(_ sender: Any) {
        dismissKeyboard()
        
        // reset the text fields
        old_gpa_field.text = nil
        old_hours_field.text = nil
        updateButton.isEnabled = false
        resetButton.isEnabled = false
        
        // set the values to zero
        gpaCalc.cumulative_gpa = 0.0
        gpaCalc.total_hours = 0.0
        
        // update the grades
        updateGPA()
    }
    
    /// Author: Lane Moseley
    /// This function will enable buttons once both text fields have been edited, else disable them
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        guard let gpa = old_gpa_field.text, let hours = old_hours_field.text else {
            return
        }

        if !hours.isEmpty && !gpa.isEmpty {
            updateButton.isEnabled = true
        } else {
            updateButton.isEnabled = false
        }
        
        if !hours.isEmpty || !gpa.isEmpty {
            resetButton.isEnabled = true
        } else {
            if cumulative_result.text == "---" {
                resetButton.isEnabled = false
            }
        }
    }
}


extension UITextField {
    func addDoneButtonToKeyboard(myAction:Selector?) {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = UIBarStyle.default

        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

        doneToolbar.items = [done]
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
}
