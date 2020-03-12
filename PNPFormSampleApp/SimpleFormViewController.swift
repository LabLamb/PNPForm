//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class SimpleFormViewController: PNPFormViewController {
    
    private struct RowLabelName {
        static let name = "Name"
        static let email = "Email"
        static let password = "Password"
        static let address = "Address"
    }
    
    let simpleForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.simpleForm = {
            let nameConfig = PNPRowConfig(validation: .required)
            let emailConfig = PNPRowConfig(validation: .pattern(.email))
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(validation: .customPattern(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText)
            
            let testConfig = PNPRowConfig(type: .switch)
            
            let textFormRows = [
                TextLabelRow(title: RowLabelName.name, config: nameConfig),
                TextLabelRow(title: RowLabelName.email, config: emailConfig),
                TextLabelRow(title: RowLabelName.password, config: passwordConfig),
                TextLabelRow(title: RowLabelName.address, config: addressConfig),
                TextLabelRow(title: "Test", config: testConfig)
            ]
            
            return PNPForm(rows: textFormRows, separatorColor: sepColor)
        }()

        let submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        
        self.submitButtonForm = {
            return PNPForm(rows: [submitButton], separatorColor: sepColor)
        }()
        
        super.init()
        
        submitButton.addTarget(self, action: #selector(self.submitButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Simple Form"
    }
    
    @objc func submitButtonPressed() {
        self.simpleForm.validateRows()
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.scrollView.addSubview(self.simpleForm)
        self.simpleForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.simpleForm.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.simpleForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.simpleForm.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ].forEach({ $0.isActive = true })
        self.simpleForm.backgroundColor = .white
        
        self.scrollView.addSubview(self.submitButtonForm)
        self.submitButtonForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.submitButtonForm.topAnchor.constraint(equalTo: self.simpleForm.bottomAnchor, constant: 20),
            self.submitButtonForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.submitButtonForm.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.submitButtonForm.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ].forEach({ $0.isActive = true })
        self.submitButtonForm.backgroundColor = .white
    }
}
