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
    @IBOutlet var creditStepperCollection: Array<UIStepper>?
    @IBOutlet var gradeStepperCollection: Array<UIStepper>?
    @IBOutlet var creditLabelCollection: Array<UILabel>?
    @IBOutlet var gradeLabelCollection: Array<UILabel>?

    // reset, update buttons
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
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
        guard let creditLabels = creditLabelCollection else { return }
        guard let gradeLabels = gradeLabelCollection else { return }
        
        var grades: [courseInfo] = []
        for i in 0...5 {
            grades.append(courseInfo(grade: gradeLabels[i].text!, credits: Double(creditLabels[i].text!)!))
        }
        
        // update gpa
        result.text = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        
        // update cumulative gpa
        if gpaCalc.cumulative_gpa == 0.0 && gpaCalc.total_hours == 0.0 {
            cumulative_result.text = "---"
        } else {
            cumulative_result.text = String(format: "%.3f", gpaCalc.new_cumulative_gpa)
        }
        
        resetButton.isEnabled = true
    }
    
    /// Author: Lane Moseley
    /// This function updates credits based on stepper value.
    @IBAction func credit_stepper_pressed(_ sender: UIStepper) {
        guard let creditLabels = creditLabelCollection else { return }
        
        for (i, credit_label) in creditLabels.enumerated() {
            if i == sender.tag {
                credit_label.text = String(Int(gpaCalc.credits[Int(sender.value)]))
                updateGPA()
                return
            }
        }
    }
    
    /// Author: Lane Moseley
    /// This function updates grade based on stepper value.
    @IBAction func grade_stepper_pressed(_ sender: UIStepper) {
        guard let gradeLabels = gradeLabelCollection else { return }
        
        for (i, grade_label) in gradeLabels.enumerated() {
            if i == sender.tag {
                grade_label.text = gpaCalc.grades[Int(sender.value)]
                updateGPA()
                return
            }
        }
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
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for credit_stepper in creditSteppers {
            credit_stepper.isEnabled = false
        }
        
        for grade_stepper in gradeSteppers {
            grade_stepper.isEnabled = false
        }
    }
    
    func enableSteppers() {
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for credit_stepper in creditSteppers {
            credit_stepper.isEnabled = true
        }
        
        for grade_stepper in gradeSteppers {
            grade_stepper.isEnabled = true
        }
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
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                (UIAlertAction) in self.reset_fields()
            }))

            self.present(alertController, animated: true, completion: nil)
        } else {
            updateButton.isEnabled = false
        }
    }
    
    /// Author: Lane Moseley
    /// This function will reset the cumulative GPA
    @IBAction func reset_pressed(_ sender: Any) {
        guard let gpa = old_gpa_field.text, let hours = old_hours_field.text else {
            return
        }
        
        if !hours.isEmpty || !gpa.isEmpty {
            reset_fields()
        } else {
            reset_steppers()
        }
    }
    
    func reset_fields() {
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
    
    func reset_steppers() {
        guard let creditLabels = creditLabelCollection else { return }
        guard let gradeLabels = gradeLabelCollection else { return }
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for (i, credit_label) in creditLabels.enumerated() {
            if i == 0 {
                creditLabels[0].text = "4"
            } else {
                credit_label.text = "0"
            }
        }
        
        for (i, grade_label) in gradeLabels.enumerated() {
            if i == 0 {
                gradeLabels[0].text = "A"
            } else {
                grade_label.text = "-"
            }
        }
        
        for (i, credit_stepper) in creditSteppers.enumerated() {
            if i == 0 {
                creditSteppers[0].value = 4
            } else {
                credit_stepper.value = 0
            }
        }
        
        for (i, grade_stepper) in gradeSteppers.enumerated() {
            if i == 0 {
                gradeSteppers[0].value = 0
            } else {
                grade_stepper.value = 1
            }
        }
        
        updateGPA()
        resetButton.isEnabled = false
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
