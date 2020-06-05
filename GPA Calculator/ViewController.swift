///
/// Author: Lane Moseley
/// Language\Compiler: Swift 5.1
/// Description: This is a GPA Calculator app developed for iOS.  It allows the user to
/// add grades and credit hours for up to six classes and see the resulting GPA.
///

import UIKit

class ViewController: UIViewController {
    /*
     * Constants
     */
    let NUM_FIELDS = 6
    let GRADES = ["A", "-", "F", "D-", "D", "D+", "C-", "C", "C+", "B-", "B", "B+", "A-"] /* grade range */
    let CREDITS = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0] /* credit range */
    
    /*
     * GPA Calculator Instance
     */
    let gpaCalc = gpaCalculator()
    
    /*
     * UI Outlets
     */
    @IBOutlet var creditStepperCollection: Array<UIStepper>?
    @IBOutlet var gradeStepperCollection: Array<UIStepper>?
    @IBOutlet var creditLabelCollection: Array<UILabel>?
    @IBOutlet var gradeLabelCollection: Array<UILabel>?
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var old_gpa_field: UITextField!
    @IBOutlet weak var old_hours_field: UITextField!
    @IBOutlet weak var cumulative_result: UILabel!
    @IBOutlet weak var result: UILabel!
        
    
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
    
    @IBAction func credit_stepper_pressed(_ sender: UIStepper) {
        guard let creditLabels = creditLabelCollection else { return }
        
        for (i, credit_label) in creditLabels.enumerated() {
            if i == sender.tag {
                credit_label.text = String(Int(CREDITS[Int(sender.value)]))
                updateGPA()
                updateCumulativeGPA()
                resetButton.isEnabled = true
                return
            }
        }
    }
    
    func disableSteppers() {
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for i in 0..<NUM_FIELDS {
            creditSteppers[i].isEnabled = false
            gradeSteppers[i].isEnabled = false
        }
    }
    
    func dismissKeyboard() {
        // dismiss the keyboard if it is up
        old_gpa_field.resignFirstResponder()
        old_hours_field.resignFirstResponder()
    }
    
    func enableSteppers() {
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for i in 0..<NUM_FIELDS {
            creditSteppers[i].isEnabled = true
            gradeSteppers[i].isEnabled = true
        }
    }
    
    @IBAction func grade_stepper_pressed(_ sender: UIStepper) {
        guard let gradeLabels = gradeLabelCollection else { return }
        
        for (i, grade_label) in gradeLabels.enumerated() {
            if i == sender.tag {
                grade_label.text = GRADES[Int(sender.value)]
                updateGPA()
                updateCumulativeGPA()
                resetButton.isEnabled = true
                return
            }
        }
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            
            // enable the steppers
            enableSteppers()
        }
    }
    
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
    
    func reset_fields() {
        dismissKeyboard()
        old_gpa_field.text = nil
        old_hours_field.text = nil
        cumulative_result.text = "---"
        updateButton.isEnabled = false
        resetButton.isEnabled = false
        reset_gpa()
    }
    
    func reset_gpa() {
        gpaCalc.reset()
        updateGPA()
        updateCumulativeGPA()
        resetButton.isEnabled = true
    }
    
    @IBAction func reset_pressed(_ sender: Any) {
        guard let gpa = old_gpa_field.text, let hours = old_hours_field.text else {
            return
        }
        
        if cumulative_result.text == "---" && gpa.isEmpty && hours.isEmpty {
            reset_steppers()
        } else {
            reset_fields()
        }
    }
    
    func reset_steppers() {
        guard let creditLabels = creditLabelCollection else { return }
        guard let gradeLabels = gradeLabelCollection else { return }
        guard let creditSteppers = creditStepperCollection else { return }
        guard let gradeSteppers = gradeStepperCollection else { return }
        
        for i in 0..<NUM_FIELDS {
            if i == 0 {
                creditLabels[i].text = "4"
                gradeLabels[i].text = "A"
                creditSteppers[i].value = 4
                gradeSteppers[i].value = 0
            } else {
                creditLabels[i].text = "0"
                gradeLabels[i].text = "-"
                creditSteppers[i].value = 0
                gradeSteppers[i].value = 1
            }
        }
        
        updateGPA()
        updateCumulativeGPA()
        resetButton.isEnabled = false
    }
    
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
    
    func updateCumulativeGPA() {
        guard let gpa = Double(old_gpa_field.text!), let hours = Double(old_hours_field.text!) else {
            return
        }
        
        if gpa >= 0.0 && gpa <= 4.0 && hours >= 0.0 && hours <= 5000.0 /*Arbitrary upper limit*/ {
            gpaCalc.cumulative_gpa = gpa
            gpaCalc.total_hours = hours
            cumulative_result.text = String(format: "%.3f", gpaCalc.getCumulativeGPA())
            updateButton.isEnabled = false
            return
        } else {
            let alertController = UIAlertController(title: "Whoops!", message: "Input is out of range or invalid.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                (UIAlertAction) in self.reset_fields()
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func updateGPA() {
        guard let creditLabels = creditLabelCollection else { return }
        guard let gradeLabels = gradeLabelCollection else { return }
        
        var grades: [courseInfo] = []
        for i in 0..<NUM_FIELDS {
            grades.append(courseInfo(grade: gradeLabels[i].text!, credits: Double(creditLabels[i].text!)!))
        }
        
        result.text = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
    }
    
    @IBAction func update_pressed(_ sender: Any) {
        dismissKeyboard()
        resetButton.isEnabled = true
        updateCumulativeGPA()
    }
}

/*
 * Extensions
 */
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
