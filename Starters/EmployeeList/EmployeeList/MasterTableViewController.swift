//
//  MasterViewController.swift
//  EmployeeList
//

import UIKit

class MasterTableViewController: UITableViewController, AddEmployeeDelegate {
    
    private var company:Company!
    
    func addEmployee(empID: Int, name: String, payRate: Double)
    {
        let e = Employee(empID: empID, name: name, payRate: payRate, isFounder:false)
        
        company.addEmployee(e)
        saveEmployees(employees: company.getEmployees())
        
        self.tableView.reloadData()
    }
    
    @IBAction func sortSelectionTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex > 0
        {
            sender.setEnabled(false, forSegmentAt: 0)
            company.sortEmployees(sortOrder: sender.selectedSegmentIndex)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        company = Company()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return company.numberOfEmployees
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emp = company.getEmployees()[indexPath.row]
        
        var cell: UITableViewCell
        if emp.isFounder
        {
            let founderCell = tableView.dequeueReusableCell(withIdentifier: "founderCellType", for: indexPath) as! FounderCell
            
            founderCell.founderNameLabel.text = emp.name
            cell = founderCell
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "defaultCellType", for: indexPath)
            
            cell.textLabel!.text = emp.name
        }

        return cell
    }
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        if company.getEmployees()[indexPath.row].isFounder
        {
            return false
        }
        
        return true
     }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
        if editingStyle == .delete {
            // Delete the employee from the company
            let emp = company.getEmployees()[indexPath.row]
            company.removeEmployee(emp)
            saveEmployees(employees: company.getEmployees())

            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
     }

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addEmployeeSegue"
        {
            let destination = segue.destination as! AddEmployeeViewController
            destination.delegate = self
        }
        else if segue.identifier == "showDetailSegue" || segue.identifier == "showDetailSegueForFounder"
        {
            let destination = segue.destination as! DetailViewController
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            let index = indexPath.row
            destination.detailItem = self.company.getEmployees()[index]
        }
    }
    
}

