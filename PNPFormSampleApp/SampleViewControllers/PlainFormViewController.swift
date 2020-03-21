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
    
    lazy var plainForm: PNPForm = {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        let usernameConfig = PNPRowConfig(placeholder: "Username", validation: .required)
        let emailConfig = PNPRowConfig(type: .email(), placeholder: "Email e.g. example@email.com")
        
        let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
        let passwordConfig = PNPRowConfig(type: .password(), placeholder: "Password", validation: .matchRegex(regex: passwordPattern))
        
        let addressConfig = PNPRowConfig(type: .multilineText(), placeholder: "Address")
        
        let textFormRows: [PNPRow] = [
            PNPRow(config: usernameConfig),
            PNPRow(config: emailConfig),
            PNPRow(config: passwordConfig),
            PNPRow(config: addressConfig)
        ]
        
        return PNPForm(rows: textFormRows, separatorColor: sepColor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Plain Form"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.submitButtonPressed))
    }
    
    @objc func submitButtonPressed() {
        if !self.plainForm.validateRows() {
            let alert = UIAlertController(title: "Error", message: "Some fields are invalid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.scrollView.addSubview(self.plainForm)
        self.plainForm.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.plainForm.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.plainForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.plainForm.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        self.plainForm.backgroundColor = .white
    }
}
