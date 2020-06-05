///
/// Author: Lane Moseley
/// Description: This file contains the courseInfo class.
/// This class holds the student's grade and the credit hours
/// for a single course.
///

import Foundation

class courseInfo {
    private var _grade: String
    private var _credits: Double
    
    init(grade: String, credits: Double) {
        self._grade = grade
        self._credits = credits
    }
    
    var grade: String {
        get { return _grade }
        set { _grade = newValue }
    }

    var credits: Double {
        get { return _credits }
        set { _credits = newValue }
    }
}
