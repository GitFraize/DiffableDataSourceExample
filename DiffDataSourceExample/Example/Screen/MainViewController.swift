import UIKit

protocol MainPresenterProtocol {
    func updateData()
}

class MainViewController: UIViewController {

    var presenter: MainPresenterProtocol!
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, String> = {
        let dataSource = UITableViewDiffableDataSource<Int, String>(tableView: contentView.tableView) { table, indexPath, name  in
            let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = name
            return cell
        }
        return dataSource
    }()
    
    private let contentView: MainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        presenter.updateData()
        addTargets()
    }
    
    @objc private func refresh() {
        contentView.tableView.refreshControl?.endRefreshing()
        presenter.updateData()
    }
    
    private func addTargets() {
        contentView.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        contentView.refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
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
