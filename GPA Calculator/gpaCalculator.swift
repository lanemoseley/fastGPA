//
//  gpaCalculator.swift
//  GPA Calculator
//
//  Created by Lane Moseley on 11/26/19.
//  Copyright © 2019 Lane Moseley. All rights reserved.
//

import Foundation

class gpaCalculator {
    // grade range
    let grades = ["A", "NA", "F", "D", "C", "B"]
    
    // credit range
    let credits = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
    
    // grade->credit map
    let gradeMap = ["NA": 0.0, "A": 4.0, "B": 3.0, "C": 2.0, "D": 1.0, "F": 0.0]

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
