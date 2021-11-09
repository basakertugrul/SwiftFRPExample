//
//  ViewController.swift
//  SwiftFRPExample
//
//  Created by Başak Ertuğrul on 9.11.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let emailValid = emailTextField.rx.text.map { text in
            return self.isValidEmail(text!)
        }
//        .bind(to: self.signUpButton.rx.isEnabled)
    
        let passwordValid = passwordTextField.rx.text.map { text in
            
            return self.isValidPassword(passwordStr: text!)
        }
//        .bind(to: self.signUpButton.rx.isEnabled)

        Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
        .bind(to: self.signUpButton.rx.isEnabled)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(passwordStr: String) -> Bool {
        return passwordStr.count >= 6
    }

}

