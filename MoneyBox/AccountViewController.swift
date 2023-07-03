//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Denis Hackett on 27/06/2023.
//

import Networking
import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //init account holder details
        var userName: String?
    
    var totalPlanValue = 0.0
    
    private let dataProvider: DataProvider = {
        return DataProvider()
    }()
    
    
    //init array to hold financial products on account
    var products: [ProductResponse] = []

    
    private let holder: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "User Accounts"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(named: "AccentColor")
        lbl.font = UIFont.systemFont(ofSize: 23)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var welcomeText: UILabel = {
        let tv = UILabel()
        let firstName = self.userName // Assuming 'firstName' is declared as an instance variable or property
        tv.text = "Hello, \(firstName ?? "Customer")!"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var totalValueText: UILabel = {
        let tv = UILabel()
        let total = String(self.totalPlanValue ) // Assuming 'firstName' is declared as an instance variable or property
        tv.text = "Total Plan Value: £\(total )"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch the updated data here
        fetchProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Hide the back button - no return to parent view
        navigationItem.setHidesBackButton(true, animated: false)
        
        //call to api
        fetchProducts()
        // setup up take ui and delegate
        setupTableView()
        
        //moved to inside api request to setup up ui with populated data
//        setup()
        
        
    }
    
    // fetching account data
    
    private func fetchProducts() {
        
        dataProvider.fetchProducts { [weak self] result in
            switch result {
            case .success(let accountResponse):
                // Access the totalPlanValue property from the accountResponse
                if let totalPlanVal = accountResponse.totalPlanValue {
                    
                    self!.totalPlanValue = totalPlanVal
                    print("Total Plan Value: \(totalPlanVal)")
                }
                
                // init empty array to store the productResponses
                var productResponses: [ProductResponse] = []
                
                // extract the productResponses
                if let productAccounts = accountResponse.productResponses {
                    for account in productAccounts {
                            productResponses.append(account)
                    }
                } else {
                    print("There are no accounts")
                }
                
                // store product response in the class variable
                self?.products = productResponses
                
                //reload table view with data for change of view
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.updateTotalPlanValueLabel() // update total plan IF total value changes
                }
                
                // Print the number of accounts and their details
//                print("Number of accounts: \(self?.products.count ?? 0)")
//                for productResponse in productResponses {
//                    if let friendlyName = productResponse.product?.friendlyName {
//                        print("Account type: \(friendlyName)")
//                    }
//                    if let planValue = productResponse.planValue {
//                        print("Account value: \(planValue)")
//                    }
//                    if let moneybox = productResponse.moneybox {
//                        print("Account money box: \(moneybox)")
//                    }
//                    // Print other account details as needed
//                }
                
                // Call the setup method after fetching products
                DispatchQueue.main.async {
                    self?.setup()
                }
                
            case .failure(let error):
                // Handle error while fetching products
               // print("Failed to fetch products: \(error.localizedDescription)")
                
                ErrorMessagePopup.show(withTitle: "Error Message", message: error.localizedDescription, inViewController: self!) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }

    private func updateTotalPlanValueLabel() {
        DispatchQueue.main.async {
            let total = String(format: "£%.2f", self.totalPlanValue)
            self.totalValueText.text = "Total Plan Value: \(total)"
        }
    }

    
    //UITABLE setup
    
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //table rows set to number of accounts user holds
       // print("Number of products: \(products.count)")
        return products.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountTableViewCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }



    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        //cell row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //table row selected position - to pass
        let position = indexPath.row
        
        //passing data to productViewController class
        
        let productView = ProductViewController()
        productView.product = products[position]
        navigationController?.pushViewController(productView, animated: true)
    }
    

    
    func setup(){
        
        view.addSubview(holder)
        holder.addSubview(label)
        holder.addSubview(welcomeText)
        holder.addSubview(totalValueText)
        holder.addSubview(tableView)
//        tableView.isHidden = true
        
        NSLayoutConstraint.activate([
            
            //holder view
            holder.topAnchor.constraint(equalTo: view.topAnchor),
            holder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            holder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            holder.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            holder.widthAnchor.constraint(equalTo: view.widthAnchor),
            holder.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            //screen title
            label.topAnchor.constraint(equalTo: holder.topAnchor, constant: 80),
            label.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant:  -16),
            
            //welcom messagg text
            welcomeText.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            welcomeText.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            welcomeText.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -16),
            
            // plan total value mesggage
            totalValueText.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 4),
            totalValueText.leadingAnchor.constraint(equalTo: holder.leadingAnchor, constant: 16),
            totalValueText.trailingAnchor.constraint(equalTo: holder.trailingAnchor, constant: -16),
            
            //table view
            tableView.topAnchor.constraint(equalTo: totalValueText.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: holder.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: holder.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: holder.bottomAnchor)
        ])
        
        
    }
    
    
    
    
}
