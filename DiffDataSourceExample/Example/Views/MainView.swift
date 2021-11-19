import UIKit

class MainView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let refreshButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.setTitle("Refresh", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .lightGray
        addSubview(tableView)
        addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            refreshButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            refreshButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            refreshButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            refreshButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
        ])
        
        tableView.refreshControl = UIRefreshControl()
    }
}
