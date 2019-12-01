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
    
    /// Author: Lane Moseley
    /// This is a wrapper class for the _grade variable.
    /// It provides setter and getter functions for _grade.
    var grade: String {
        get { return _grade }
        set { _grade = newValue }
    }

    /// Author: Lane Moseley
    /// This is a wrapper class for the _credits variable.
    /// It provides setter and getter functions for _credits.
    var credits: Double {
        get { return _credits }
        set { _credits = newValue }
    }
    
    /// Author: Lane Moseley
    /// This is the class constructor.
    /// It initializes the class with a grade and credit hours.
    init(grade: String, credits: Double) {
        self._grade = grade
        self._credits = credits
    }
}
