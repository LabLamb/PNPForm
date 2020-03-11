//
//  Copyright © 2020 LabLambWorks. All rights reserved.
//

import UIKit
open class PNPFormViewController: UIViewController {
    public let scrollView: UIScrollView
    
    public init() {
        self.scrollView = UIScrollView()
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidDisappeared), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.setupLayout()
    }
    
    @objc private func keyboardDidAppear(noti: NSNotification) {
        guard let info = noti.userInfo else { return }
        let rect: CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let kbHeight = rect.size.height
        self.scrollView.contentInset.bottom = kbHeight - (self.tabBarController?.tabBar.frame.height ?? 0)
        self.scrollView.verticalScrollIndicatorInsets.bottom = kbHeight
    }
    
    @objc private func keyboardDidDisappeared() {
        self.scrollView.contentInset.bottom = 0
        self.scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    open func setupLayout() {
        self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha:1.0)
        
        self.scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        self.scrollView.isDirectionalLockEnabled = true
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        [
            self.scrollView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ].forEach({ $0.isActive = true })
    }
}
