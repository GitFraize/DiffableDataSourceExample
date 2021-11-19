import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func reloadData(with data: [String])
}

protocol MainModelProtocol {
    func getData(completion: @escaping ([String]) -> ())
}

class MainPresenter {
    
    private weak var view: MainViewControllerProtocol!
    private let model: MainModelProtocol!
    
    init(view: MainViewControllerProtocol, model: MainModelProtocol) {
        self.view = view
        self.model = model
    }
}

extension MainPresenter: MainPresenterProtocol {
    func updateData() {
        model.getData{ data in
            self.view.reloadData(with: data)
        }
    }
}
