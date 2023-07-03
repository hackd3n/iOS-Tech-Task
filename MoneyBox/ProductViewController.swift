//
//  ProductViewController.swift
//  MoneyBox
//
//  Created by Denis Hackett on 28/06/2023.
//

import UIKit
import Networking

class ProductViewController: UIViewController {
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    var product: ProductResponse?
    
    private let navlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Individual Account"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "AccentColor")
        lbl.font = UIFont.systemFont(ofSize: 23)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyBoxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add £10", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor =  UIColor(named: "AccentColor")
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        configureProduct()
        addButton.addTarget(self, action: #selector(addToMoneyBox), for: .touchUpInside)
    }
    
    private func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(valueLabel)
        view.addSubview(moneyBoxLabel)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            moneyBoxLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 8),
            moneyBoxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            addButton.topAnchor.constraint(equalTo: moneyBoxLabel.bottomAnchor, constant: 16),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureProduct() {
        
        guard let product = product else { return }
        
        titleLabel.text = product.product?.friendlyName ?? "Product name not found"
        valueLabel.text = String(format: "Value:  £%0.2f", product.planValue!)
        moneyBoxLabel.text = String(format: "Moneybox: £%0.2f", product.moneybox!)
    }
    
    @objc private func addToMoneyBox() {
        guard let product = product else { return }
        
        let paymentAmount: Int = 10// Fixed amount of £10
        
        // Create a one-off payment request
        let request = OneOffPaymentRequest(amount: Int(paymentAmount), investorProductID: product.id!)
        
        dataProvider.addMoney(request: request) { result in
            switch result {
            case .success(let paymentResponse):
            
                
                print("Money added successfully!")

                // Update the moneybox label text
                DispatchQueue.main.async {
                    self.moneyBoxLabel.text = String(format: "Moneybox: £%0.2f", paymentResponse.moneybox!)
                    self.valueLabel.text = String(format: "Value:  £%0.2f", product.planValue!)
                    
                    //returnback to parent view
                    self.navigationController?.popViewController(animated: true)
                }
                
                
                
                
                
            case .failure(let error):
                print("Failed to add money: \(error.localizedDescription)")
                
                ErrorMessagePopup.show(withTitle: "Failed to add money:", message: error.localizedDescription, inViewController: self) {
                    self.navigationController?.popToRootViewController(animated: true)
                }



            }
        }
    }
    
    
}

