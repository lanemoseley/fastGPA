//
//  FastGPA_Tests.swift
//  FastGPA Tests
//
//  Created by Lane Moseley on 6/5/20.
//  Copyright © 2020 Lane Moseley. All rights reserved.
//

import XCTest
@testable import Fast_GPA

class FastGPA_Tests: XCTestCase {
    let NUM_FIELDS = 6
    
    // test the gpa calculations for correctness
    func testSemesterGPA_1() throws {
        let gpaCalc = gpaCalculator()
        let creditLabels = [4.0, 3.0, 3.0, 1.0, 3.0, 4.0]
        let gradeLabels = ["A-", "B", "B", "C+", "A", "B+"]
        
        var grades: [courseInfo] = []
        for i in 0..<NUM_FIELDS {
            grades.append(courseInfo(grade: gradeLabels[i], credits: creditLabels[i]))
        }
        
        let res = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        XCTAssertEqual( res, "3.350" )
    }
    
    func testSemesterGPA_2() throws {
        let gpaCalc = gpaCalculator()
        let creditLabels = [4.0, 3.0, 0.0, 0.0, 3.0, 4.0]
        let gradeLabels = ["A-", "B", "B", "C+", "-", "-"]
        
        var grades: [courseInfo] = []
        for i in 0..<NUM_FIELDS {
            grades.append(courseInfo(grade: gradeLabels[i], credits: creditLabels[i]))
        }
        
        let res = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        XCTAssertEqual( res, "3.400" )
    }
    
    func testSemesterGPA_3() throws {
        let gpaCalc = gpaCalculator()
        let creditLabels = [0.0, 0.0, 4.0, 4.0, 3.0, 4.0]
        let gradeLabels = ["A-", "B", "B", "F", "-", "-"]
        
        var grades: [courseInfo] = []
        for i in 0..<NUM_FIELDS {
            grades.append(courseInfo(grade: gradeLabels[i], credits: creditLabels[i]))
        }
        
        let res = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        
        gpaCalc.cumulative_gpa = 2.7
        gpaCalc.total_hours = 21
        let c_res = String(format: "%.3f", gpaCalc.getCumulativeGPA())
        
        XCTAssertEqual( res, "1.500" )
        XCTAssertEqual( c_res, "2.369" )
        
        let newCreditLabels = [4.0, 4.0, 0.0, 0.0, 3.0, 4.0]
        let newGradeLabels = ["A-", "B", "B", "F", "-", "-"]
        
        grades = []
        for i in 0..<NUM_FIELDS {
            grades.append(courseInfo(grade: newGradeLabels[i], credits: newCreditLabels[i]))
        }
        
        let new_res = String(format: "%.3f", gpaCalc.getGPA(gradeInfo: grades))
        let new_c_res = String(format: "%.3f", gpaCalc.getCumulativeGPA())
        
        XCTAssertEqual( new_res, "3.350" )
        XCTAssertEqual( new_c_res, "2.879" )
    }
}
