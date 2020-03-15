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
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.simpleForm = {
            let usernameConfig = PNPRowConfig(placeholder: "Required", validation: .required)
            let emailConfig = PNPRowConfig(type: .email(), placeholder: "example@email.com")
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(type: .password(), placeholder: "At least 1 alphabet and 1 number", validation: .matchRegex(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .time())
            
            let textFormRows: [PNPRow] = [
                PNPRow(title: RowLabel.username, config: usernameConfig),
                PNPRow(title: RowLabel.email, config: emailConfig),
                PNPRow(title: RowLabel.password, config: passwordConfig),
                PNPRow(title: RowLabel.address, config: addressConfig)
            ]
            
            return PNPForm(rows: textFormRows, separatorColor: sepColor)
        }()
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Basic Form"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.submitButtonPressed))
    }
    
    @objc func submitButtonPressed() {
        if !self.simpleForm.validateRows() {
            let alert = UIAlertController(title: "Error", message: "Some fields are invalid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
    }
}
