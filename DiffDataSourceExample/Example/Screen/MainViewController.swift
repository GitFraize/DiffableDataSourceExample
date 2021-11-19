import UIKit

protocol MainPresenterProtocol {
    func updateData()
}

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, String> = {
        let dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView) { table, indexPath, name  in
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = name
            return cell
        }
        return dataSource
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.setTitle("Refresh", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.updateData()
    }
    
    @objc private func refresh() {
        tableView.refreshControl?.endRefreshing()
        presenter.updateData()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            refreshButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            refreshButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            refreshButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func reloadData(with data: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(data, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
