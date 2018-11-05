//
//  Employee.swift
//  EmployeeList
//

import Foundation

class Employee : Codable {
    
    private enum CodingKeys: String, CodingKey {
        case empID = "EmpID"
        case name = "Name"
        case payRate = "PayRate"
        case picturePath = "PicturePath"
        
    }
        
    var empID: Int
    var name: String
    var payRate: Double
    var isFounder: Bool = false
    var picturePath: String? = nil

    init(empID: Int, name: String, payRate: Double, isFounder: Bool)
    {
        self.empID = empID
        self.name = name
        self.payRate = payRate
        self.isFounder = isFounder
    }
    
    convenience init()
    {
        self.init(empID: 0, name: "", payRate: 0.0, isFounder: false)
    }
    
    class func newEmployee(empID: Int, name: String, payRate: Double, isFounder: Bool) -> Employee
    {
        return Employee(empID: empID, name: name, payRate: payRate, isFounder: isFounder)
    }
}
