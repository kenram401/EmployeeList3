//
//  Company.swift
//  EmployeeList
//

import Foundation
import UIKit

func == (left: Employee, right: Employee) -> Bool
{
    return left.empID == right.empID
}

class Company
{
    private var employees: [Employee]
    
    init()
    {
        self.employees = getEmployeesFromFile()
    }
       
    func getEmployees() -> [Employee]
    {
        return employees
    }
    
    var numberOfEmployees: Int
    {
        return employees.count
    }

    func addEmployee(_ emp:Employee)
    {
        employees.append(emp)
    }
    
    func removeEmployee(_ emp:Employee)
    {
        if emp.isFounder
        {
            return
        }
        
        for index in 0..<employees.count
        {
            if emp == employees[index]
            {
                employees.remove(at: index)
                break
            }
        }
    }
    
    func sortEmployees(sortOrder: Int)
    {
        if sortOrder == 0
        {
            
        }
        else if sortOrder == 1
        {
            employees = employees.sorted(by: { $0.empID <= $1.empID })
        }
        else if sortOrder == 2
        {
            employees = employees.sorted(by: { $0.name.uppercased() <= $1.name.uppercased() })
        }
        else if sortOrder == 3
        {
            employees = employees.sorted(by: { $0.payRate <= $1.payRate })
        }
    }
}
