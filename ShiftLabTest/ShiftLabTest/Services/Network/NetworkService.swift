import Foundation

protocol NetworkServiceProtocol {
    func fetchContests(completion: @escaping (Result<[MainScreenModel], Error>) -> Void)
}

final class NetworkService {
    
    func convertToDate(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        var result = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: dateString) {
            result = date
        }
        return result
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func fetchContests(completion: @escaping (Result<[MainScreenModel], Error>) -> Void) {
        guard let url = URL(string: "https://kontests.net/api/v1/all") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let contests = try JSONDecoder().decode([ContestDTO].self, from: data)
                DispatchQueue.main.async {
                    let models = contests.map { contest in
                        MainScreenModel(name: contest.name, url: contest.url, startTime: self.convertToDate(from: contest.startTime), endTime: self.convertToDate(from: contest.endTime))
                    }
                    
                    completion(.success(models))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
