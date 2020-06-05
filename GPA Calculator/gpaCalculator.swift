///
/// Author: Lane Moseley
/// Description: This file contains the GPA calculator class.
/// This class does the work of calculating the user's GPA.
///

import Foundation

class gpaCalculator {
    let GRADE_MAP = ["-": -1.0, "A": 4.0, "A-": 3.7, "B+": 3.3, "B": 3.0, "B-": 2.7, "C+": 2.3, "C": 2.0, "C-": 1.7, "D+": 1.3, "D": 1.0, "D-": 0.7, "F": 0.0]

    private var _cumulative_gpa: Double
    private var _new_cumulative_gpa: Double
    private var _semester_hours: Double
    private var _semester_points: Double
    private var _total_hours: Double
    
    init() {
        self._cumulative_gpa = 0.0
        self._new_cumulative_gpa = 0.0
        self._total_hours = 0.0
        self._semester_hours = 0.0
        self._semester_points = 0.0
    }

    /*
     * Setters & Getters
     */
    var cumulative_gpa: Double {
        get { return _cumulative_gpa }
        set { _cumulative_gpa = newValue }
    }
    
    var total_hours: Double {
        get { return _total_hours }
        set { _total_hours = newValue }
    }
    
    /*
     * Class Functions
     */
    func getCumulativeGPA() -> Double {
        updateCumulative()
        return _new_cumulative_gpa
    }
    
    func getGPA(gradeInfo: [courseInfo]) -> Double {
        _semester_points = 0.0
        _semester_hours = 0.0
        
        for i in gradeInfo {
            if i.credits > 0 && GRADE_MAP[i.grade]! > -1 {
                _semester_hours += i.credits
                _semester_points += (i.credits * GRADE_MAP[i.grade]!)
            }
        }
        
        if (_semester_hours == 0.0) { return 0.0 }
        
        self.updateCumulative()
        return _semester_points / _semester_hours
    }
    
    func reset() {
        _cumulative_gpa = 0.0
        _total_hours = 0.0
    }
    
    func updateCumulative() {
        let total_points = ( _total_hours * _cumulative_gpa ) + _semester_points
        let total_hours = _total_hours + _semester_hours
        _new_cumulative_gpa = total_points / total_hours
    }
}
