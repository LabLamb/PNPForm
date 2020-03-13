//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class PlainFormViewController: PNPFormViewController {
    
    private struct RowPlaceholder {
        static let username = "Username"
        static let email = "Email"
        static let password = "Password"
        static let address = "Address"
        static let rememberMe = "Remember me"
    }
    
    let plainForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.plainForm = {
            let usernameConfig = PNPRowConfig(placeholder: "Username", validation: .required)
            let emailConfig = PNPRowConfig(type: .email, placeholder: "Email e.g. example@email.com")
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(type: .password,placeholder: "Password", validation: .matchRegex(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText, placeholder: "Address")
            
            let rmbMeConfig = PNPRowConfig(type: .switch, placeholder: "Remeber Me")
            
            let textFormRows: [PNPRow] = [
                PNPRow(config: usernameConfig),
                PNPRow(config: emailConfig),
                PNPRow(config: passwordConfig),
                PNPRow(config: addressConfig),
                PNPRow(title: "Remember Me", config: rmbMeConfig)
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
        self.navigationItem.title = "Plain Form"
    }
    
    @objc func submitButtonPressed() {
        self.plainForm.validateRows()
        self.resignFirstResponder()
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.scrollView.addSubview(self.plainForm)
        self.plainForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.plainForm.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.plainForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.plainForm.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ].forEach({ $0.isActive = true })
        self.plainForm.backgroundColor = .white
        
        self.scrollView.addSubview(self.submitButtonForm)
        self.submitButtonForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.submitButtonForm.topAnchor.constraint(equalTo: self.plainForm.bottomAnchor, constant: 20),
            self.submitButtonForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.submitButtonForm.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.submitButtonForm.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ].forEach({ $0.isActive = true })
        self.submitButtonForm.backgroundColor = .white
    }
}
