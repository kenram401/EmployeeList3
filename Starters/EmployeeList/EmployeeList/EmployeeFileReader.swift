//
//  EmployeeFileReader.swift
//  EmployeeList
//

import Foundation

func getEmployeesFromFile() -> [Employee]
{
    var tempList = loadFoundingEmployees()
    tempList += loadUserAddedEmployees()
    return tempList
}

fileprivate func loadFoundingEmployees() -> [Employee]
{
    let foundersURL: URL = Bundle.main.url(
        forResource: "FoundingEmployees",
        withExtension: "plist")!
    
    // Define a dictionary to hold the data from the plist file
    var dict: [String : Employee]?
    
    // We need to pass the type name of the object that will hold
    // the deserialized data;  build a type alias for
    // Dictionary<String, Employee>
    typealias EmployeeDictionary = [String : Employee]
    
    // Deserialize the plist file into the dictionary
    if let data = try? Data(contentsOf: foundersURL) {
        let decoder = PropertyListDecoder()
        dict = try? decoder.decode(EmployeeDictionary.self, from: data)
    }
    
    // Extract the values from the dictionary (which is an array
    // of the employees)
    var foundersList: [Employee] = Array(dict!.values)
    foundersList = foundersList.map({ $0.isFounder = true; return $0 as Employee })
    return foundersList;
}

fileprivate func loadUserAddedEmployees() -> [Employee]
{
    // Define a dictionary to hold the data from the plist file
    var userAddedEmployeesList: [Employee] = []
    
    do {
        var fileLocation: URL = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                     create: true)
        
        fileLocation = fileLocation.appendingPathComponent("user_added_employees.plist")
        
        // If no use added employees, the file won't exist
        if !FileManager.default.fileExists(atPath: fileLocation.path)
        {
            return userAddedEmployeesList
        }
        
        // We need to pass the type name of the object that will hold
        // the deserialized data;  build a type alias for
        // Array<Employee>
        typealias EmployeeArray = [Employee]
        
        // Deserialize the plist file into the array
        if let data = try? Data(contentsOf: fileLocation) {
            let decoder = PropertyListDecoder()
            userAddedEmployeesList = try! decoder.decode(EmployeeArray.self, from: data)
        }
        
    } catch {
        print("ERROR: Failed to read user_added_employees.plist file")
    }
    
    return userAddedEmployeesList
}

func saveEmployees(employees: [Employee])
{
    let userAddedEmployees = employees.filter({ $0.isFounder != true })
    
    do{
        //get file URL for user added employees
        var fileLocation:URL = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: true)
        fileLocation = fileLocation.appendingPathComponent("user_added_employees.plist")
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        // Deserialize the plist file into the array
        let data = try! encoder.encode(userAddedEmployees)
        try data.write(to: fileLocation)
        
    } catch {
        print("ERROR:  Failed to write user_added_employees.plist file")
    }
}
