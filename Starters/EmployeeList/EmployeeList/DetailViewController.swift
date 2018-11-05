//
//  DetailViewController.swift
//  EmployeeList
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var empIDLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var payRateLabel: UILabel!
    @IBOutlet weak var isFounderLabel: UILabel!
    
    var detailItem:Employee?

    func configureView() {
        // Update the user interface for the detail item.
        
        if detailItem != nil
        {
            empIDLabel.text = String(detailItem!.empID)
            nameLabel.text = detailItem!.name
            payRateLabel.text = String(format: "$%.2f/hour", detailItem!.payRate)
            
            if detailItem!.isFounder
            {
                isFounderLabel.text = "Founder"
            }
            else
            {
                isFounderLabel.text = "Employee"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.navigationItem.title = "Employee Info"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

