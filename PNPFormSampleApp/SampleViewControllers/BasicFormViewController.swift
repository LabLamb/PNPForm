//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class BasicFormViewController: PNPFormViewController {
    
    private struct RowLabel {
        static let username = "Username"
        static let email = "Email"
        static let password = "Password"
        static let address = "Address"
        static let rememberMe = "Remember me"
    }
    
    let simpleForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.simpleForm = {
            let usernameConfig = PNPRowConfig(placeholder: "Required", validation: .required)
            let emailConfig = PNPRowConfig(type: .email, placeholder: "example@email.com")
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(type: .password,placeholder: "At least 1 alphabet and 1 number", validation: .matchRegex(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText)
            
            let rmbMeConfig = PNPRowConfig(type: .switch, placeholder: String(true))
            
            let textFormRows: [PNPRow] = [
                PNPRow(title: RowLabel.username, config: usernameConfig),
                PNPRow(title: RowLabel.email, config: emailConfig),
                PNPRow(title: RowLabel.password, config: passwordConfig),
                PNPRow(title: RowLabel.address, config: addressConfig),
                PNPRow(title: RowLabel.rememberMe, config: rmbMeConfig)
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
        self.navigationItem.title = "Basic Form"
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
