//
//  Copyright © LabLambWorks. All rights reserved.
//

import PNPForm
import UIKit

class IconFormViewController: PNPFormViewController {
    
    private struct RowIcon {
        static let name = UIImage()
        static let email = #imageLiteral(resourceName: "email")
        static let password = #imageLiteral(resourceName: "password")
        static let address = UIImage()
        static let remeberMe = UIImage()
    }
    
    let iconForm: PNPForm
    let submitButtonForm: PNPForm
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.iconForm = {
            let nameConfig = PNPRowConfig(validation: .required)
            let emailConfig = PNPRowConfig(placeholder: "example@email.com", validation: .pattern(.email))
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(validation: .customPattern(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multLineText())
            
            let testConfig = PNPRowConfig(type: .switch)
            
            let textFormRows = [
                IconsRow(icon: RowIcon.name, config: nameConfig),
                IconsRow(icon: RowIcon.email, config: emailConfig),
                IconsRow(icon: RowIcon.password, config: passwordConfig),
                IconsRow(icon: RowIcon.address, config: addressConfig),
                IconsRow(icon: RowIcon.remeberMe, config: testConfig)
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
