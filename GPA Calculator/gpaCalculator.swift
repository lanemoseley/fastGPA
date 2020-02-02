///
/// Author: Lane Moseley
/// Description: This file contains the GPA calculator class.
/// This class does the work of calculating the user's GPA.
///

import Foundation

class gpaCalculator {
    // grade range
    let grades = ["A", "-", "F", "D-", "D", "D+", "C-", "C", "C+", "B-", "B", "B+", "A-"]
    
    // credit range
    let credits = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
    
    // grade->credit map
    let gradeMap = ["-": 0.0, "A": 4.0, "A-": 3.7, "B+": 3.3, "B": 3.0, "B-": 2.7, "C+": 2.3, "C": 2.0, "C-": 1.7, "D+": 1.3, "D": 1.0, "D-": 0.7, "F": 0.0]

    private var _cumulative_gpa: Double
    private var _total_hours: Double
    private var _new_cumulative_gpa: Double
    
    /// Author: Lane Moseley
    /// This is the class constructor.
    /// It initializes the class with a cumulative GPA and total credit hours.
    init(cumulative_gpa: Double = 0.0, total_hours: Double = 0.0) {
        self._cumulative_gpa = cumulative_gpa
        self._total_hours = total_hours
        self._new_cumulative_gpa = cumulative_gpa
    }
    
    /// Author: Lane Moseley
    /// This is a wrapper class for the _cumulative_gpa variable.
    /// It provides setter and getter functions for _cumulative_gpa.
    var cumulative_gpa: Double {
        get { return _cumulative_gpa }
        set { _cumulative_gpa = newValue }
    }

    
    /// Author: Lane Moseley
    /// This is a wrapper class for the _total_hours variable.
    /// It provides setter and getter functions for _total_hours.
    var total_hours: Double {
        get { return _total_hours }
        set { _total_hours = newValue }
    }

    
    /// Author: Lane Moseley
    /// This is a wrapper class for the _cumulative_gpa variable.
    /// It provides setter and getter functions for _cumulative_gpa.
    var new_cumulative_gpa: Double {
        get { return _new_cumulative_gpa }
        set { _new_cumulative_gpa = newValue }
    }
    
        
    /// Author: Lane Moseley
    /// This function calculates GPA based on the user's performance
    /// in one or more classes.
    /// - Parameter gradeInfo: an array of course grades and credits
    func getGPA(gradeInfo: [courseInfo]) -> Double {
        var gpa = 0.0
        var totalCredits = 0.0
        
        for i in gradeInfo {
            if (i.credits != 0 && i.grade != "---") {
                totalCredits += i.credits
                gpa += (i.credits * gradeMap[i.grade]!)
            }
        }
        
        if (totalCredits == 0.0) { return 0.0}
        
        self.updateCumulative(points: gpa, credits: totalCredits)
        gpa /= Double(totalCredits)
        
        // return gpa string with 3 decimal places
        return gpa
    }
    
    
    /// Author: Lane Moseley
    /// This function will update the new cumulative gpa.
    /// - Parameter points: Double, new grade points
    /// - Parameter credits: Int, new credits
    func updateCumulative(points: Double, credits: Double) {
        let totalPoints = ( _total_hours * _cumulative_gpa ) + points
        let totalHours = _total_hours + credits
        
        _new_cumulative_gpa = totalPoints / totalHours
    }
}
