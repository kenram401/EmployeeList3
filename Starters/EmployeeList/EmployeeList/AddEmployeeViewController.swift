//
//  AddEmployeeViewController.swift
//  EmployeeList
//

import UIKit

protocol AddEmployeeDelegate
{
	func addEmployee(empID: Int, name: String, payRate: Double)
}

class AddEmployeeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var empIDTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var payRateTextField: UITextField!
    
    var delegate:AddEmployeeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func addEmployeeButtonTapped(_ sender: UIButton)
	{
        let empID = Int(empIDTextField.text!)
        let name = nameTextField.text
        let payRate = Double(payRateTextField.text!)
        
        if empID == nil || name == nil || payRate == nil
        {
            let alert = UIAlertController(title: "Error", message: "Some employee data appears incorrect",
                preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        delegate?.addEmployee(empID: empID!,
                              name: name!,
                              payRate: payRate!)
        
        self.dismiss(animated: true, completion: nil)
	}

	@IBAction func cancelButtonTapped(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
