//
//  ConvertViewController.swift
//  Programatic Views
//
//  Created by David on 12/27/16.
//  Copyright © 2016 dmsmith. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController, UITextFieldDelegate {
    private let UNKNOWN_VALUE = "???"
    private let DECIMAL = "."
    private var fahrenheitValue: Double? {
        // Property Observer - can trigger to call method in event of change
        didSet {
            updateCelciusLabel()
        }
    }
    
    private var celciusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    private let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    private let day = UIColor.lightGray
    private let night = UIColor.darkGray
    
    @IBOutlet weak var celciusTextLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    
    @IBAction func dismissKeypad(_ sender: Any) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldChanged(_ textField: UITextField) {
        if let fText = textField.text, let value = Double(fText) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let hour = NSCalendar.current.component(.hour, from: NSDate.init() as Date)
        view.backgroundColor = getBackgroundColor(hour: hour)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateCelciusLabel() -> Void {
        if let cValue = celciusValue {
            celciusTextLabel.text = numberFormatter.string(from: NSNumber.init(value: cValue))
        } else {
            celciusTextLabel.text = UNKNOWN_VALUE
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let initialTextWithDecimal = textField.text?.range(of: DECIMAL)
        let replacementTextWithDecimal = string.range(of: DECIMAL)
        let replacementTextWithAlphabet = string.rangeOfCharacter(from: NSCharacterSet.letters)
        if initialTextWithDecimal != nil && replacementTextWithDecimal != nil {
            return false
        }
        if replacementTextWithAlphabet != nil {
            return false
        }
        return true
    }
    
    private func getBackgroundColor(hour: Int) -> UIColor {
        switch hour {
        case 6...18:
            return day
        default:
            return night
        }
    }
}
