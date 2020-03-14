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
    
    override init() {
        let sepColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)
        self.iconForm = {
            let usernameConfig = PNPRowConfig(placeholder: "Required", validation: .required)
            let emailConfig = PNPRowConfig(type: .email(), placeholder: "example@email.com")
            
            let passwordPattern = #"[^\w\d]*(([0-9]+.*[A-Za-z]+.*)|[A-Za-z]+.*([0-9]+.*))"# // Must have one number and one alphabet
            let passwordConfig = PNPRowConfig(type: .password(), placeholder: "At least 1 alphabet and 1 number", validation: .matchRegex(passwordPattern))
            
            let addressConfig = PNPRowConfig(type: .multilineText())
            
            let textFormRows: [PNPRow] = [
                PNPRow(icon: RowIcon.username, config: usernameConfig),
                PNPRow(icon: RowIcon.email, config: emailConfig),
                PNPRow(icon: RowIcon.password, config: passwordConfig),
                PNPRow(icon: RowIcon.address, config: addressConfig)
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
        self.navigationItem.title = "Icon Form"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.submitButtonPressed))
    }
    
    @objc func submitButtonPressed() {
        if !self.iconForm.validateRows() {
            let alert = UIAlertController(title: "Error", message: "Some fields are invalid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
    }
}
