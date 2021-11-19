import Foundation

private let names = ["Liam", "Olivia", "Noah", "Emma", "Oliver", "Ava", "Elijah", "Charlotte", "William", "Sophia", "James", "Amelia", "Benjamin", "Isabella", "Lucas", "Mia", "Henry", "Evelyn", "Alexander"]

class MainModel: MainModelProtocol {
    func getData(completion: @escaping ([String]) -> ()) {
        var result: [String] = []
        var names = names
        for _ in 1...5 {
            result.append(names.remove(at: Int.random(in: 0...names.count-1)))
        }
        completion(result)
    }
}
