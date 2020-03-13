//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class IconFormViewController: PNPFormViewController {
    
    private struct RowIcon {
        static let username = UIImage(systemName: "person.circle")!
        static let email = UIImage(systemName: "envelope.circle")!
        static let password = UIImage(systemName: "lock.circle")!
        static let address = UIImage(systemName: "location.circle")!
    }
    
    let iconForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.iconForm = {
            let usernameConfig = PNPRowConfig(placeholder: "Required", validation: .required)
            let emailConfig = PNPRowConfig(type: .email, placeholder: "example@email.com")
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(type: .password,placeholder: "At least 1 alphabet and 1 number", validation: .matchRegex(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText)
            
            let rmbMeConfig = PNPRowConfig(type: .switch, placeholder: "")
            
            let textFormRows: [PNPRow] = [
                PNPRow(icon: RowIcon.username, config: usernameConfig),
                PNPRow(icon: RowIcon.email, config: emailConfig),
                PNPRow(icon: RowIcon.password, config: passwordConfig),
                PNPRow(icon: RowIcon.address, config: addressConfig),
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
        self.navigationItem.title = "Icon Form"
    }
    
    @objc func submitButtonPressed() {
        self.iconForm.validateRows()
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.scrollView.addSubview(self.iconForm)
        self.iconForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.iconForm.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            self.iconForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.iconForm.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ].forEach({ $0.isActive = true })
        self.iconForm.backgroundColor = .white
        
        self.scrollView.addSubview(self.submitButtonForm)
        self.submitButtonForm.translatesAutoresizingMaskIntoConstraints = false
        [
            self.submitButtonForm.topAnchor.constraint(equalTo: self.iconForm.bottomAnchor, constant: 20),
            self.submitButtonForm.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.submitButtonForm.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.submitButtonForm.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ].forEach({ $0.isActive = true })
        self.submitButtonForm.backgroundColor = .white
    }
}
