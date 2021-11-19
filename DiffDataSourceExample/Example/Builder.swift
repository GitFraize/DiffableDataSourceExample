import Foundation

protocol BuilderProtocol {
    func buildMainScreen() -> MainViewController
}

class Builder: BuilderProtocol {
    
    static let shared: BuilderProtocol = Builder()
    
    private init() {}
    
    func buildMainScreen() -> MainViewController {
        let view = MainViewController()
        let model = MainModel()
        let presenter = MainPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
