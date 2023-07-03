import UIKit
import Networking

class AccountTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyColor")
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let arrowImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.right")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let accountTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moneyBoxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
        
        selectionStyle = .none
    }
    
    private func setupCell() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(accountTypeLabel)
        containerView.addSubview(planValueLabel)
        containerView.addSubview(moneyBoxLabel)
        containerView.addSubview(arrowImage)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            arrowImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -36),
            arrowImage.widthAnchor.constraint(equalToConstant: 20),
            arrowImage.heightAnchor.constraint(equalToConstant: 20),
            
            accountTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            accountTypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            accountTypeLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: -8),
            
            planValueLabel.topAnchor.constraint(equalTo: accountTypeLabel.bottomAnchor, constant: 4),
            planValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            planValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            moneyBoxLabel.topAnchor.constraint(equalTo: planValueLabel.bottomAnchor, constant: 4),
            moneyBoxLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            moneyBoxLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            moneyBoxLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        ])
    }
    
    func configure(with product: ProductResponse) {
        accountTypeLabel.text = product.product?.friendlyName ?? "Product name not found"
        planValueLabel.text = String(format: "Plan Value: £%.02f", product.planValue!)
        moneyBoxLabel.text = String(format: "Money Box:  £%0.2f", product.moneybox!)
    }

}
