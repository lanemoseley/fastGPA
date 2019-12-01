///
/// Author: Lane Moseley
/// Description: This file contains the GPA calculator class.
/// This class does the work of calculating the user's GPA.
///

import Foundation

class gpaCalculator {
    // grade range
    let grades = ["A", "NA", "F", "D-", "D", "D+", "C-", "C", "C+", "B-", "B", "B+"]
    
    // credit range
    let credits = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
    
    // grade->credit map
    let gradeMap = ["NA": 0.0, "A": 4.0, "A-": 3.7, "B+": 3.3, "B": 3.0, "B-": 2.7, "C+": 2.3, "C": 2.0, "C-": 1.7, "D+": 1.3, "D": 1.0, "D-": 0.7, "F": 0.0]

    
    /// Author: Lane Moseley
    /// This function calculates GPA based on the user's performance
    /// in one or more classes.
    /// - Parameter gradeInfo: an array of course grades and credits
    func getGPA(gradeInfo: [courseInfo]) -> String {
        var gpa = 0.0
        var totalCredits = 0.0
        
        for i in gradeInfo {
            if (i.credits != 0.0 && i.grade != "NA") {
                totalCredits += Double(i.credits)
                gpa += (i.credits * gradeMap[i.grade]!)
            }
        }
        
        if (totalCredits == 0) { return String(format: "%.3f", totalCredits)}
        
        gpa /= totalCredits
        
        // return gpa string with 3 decimal places
        return String(format: "%.3f", gpa)
    }
}
