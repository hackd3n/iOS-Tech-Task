//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

//    LoginRequest
//    LoginResponse


import UIKit
import Networking


public class LoginViewController: UIViewController {
    
    var loggedIn: Bool = false

    private let holder: UIView = {
        let view = UIView()
        view.backgroundColor =   UIColor(named: "GreyColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Login"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "AccentColor")
        lbl.font = UIFont.systemFont(ofSize: 23)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    private let emailInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()

    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor =  UIColor(named: "AccentColor")
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        
        return btn
    }()
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.addSubview(holder)
        holder.addSubview(label)
        holder.addSubview(emailInputField)
        holder.addSubview(passwordTextField)
        holder.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            holder.topAnchor.constraint(equalTo: view.topAnchor),
            holder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            holder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            holder.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: holder.topAnchor, constant: 80),
            label.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant:  -16),

            emailInputField.topAnchor.constraint(equalTo: holder.topAnchor, constant: 260),
            emailInputField.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            emailInputField.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -16),

            passwordTextField.topAnchor.constraint(equalTo: emailInputField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -16),
            
            loginButton.bottomAnchor.constraint(equalTo: holder.bottomAnchor, constant: -180),
            loginButton.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 26),
            loginButton.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -26),

            holder.widthAnchor.constraint(equalTo: view.widthAnchor),
            holder.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    @objc private func loginButtonTapped() {
        guard let email = emailInputField.text, let password = passwordTextField.text else {
           // showErrorMessage("Please enter your email and password.")
            return
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        let request = dataProvider.login(request: loginRequest) { result in
            switch result {
            case .success(let loginResponse):
                
                //init sessionmanger object for holding bearertoken
                let sessionManager = SessionManager()
                sessionManager.setUserToken(loginResponse.session.bearerToken)

                
                guard let name = loginResponse.user.firstName else {
                    print("Error: user has no first name")
                    return
                }
                
                //Initiate instance of acountViewCotroller
                let accountView = AccountViewController()
                
                
                //assign name variable in accountviewcontroller from loginResponse data
                accountView.userName = name
                
                
                // Navigate to AccountViewController on main thread
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(accountView, animated: true)
                }
                
            case .failure(let error):
                
                // Login failed, show error message

                ErrorMessagePopup.show(withTitle: "Login Failed", message: error.localizedDescription, inViewController: self) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }

}


