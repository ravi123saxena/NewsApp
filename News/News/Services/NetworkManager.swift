import Foundation

enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

//The Dependency Inversion Principle -  Since NetworkManager is high level class this should not depend on low level functionality

// MARK: - Network Manager
class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    // Open for extension and close for modification, We can add more fetch API handler so make it generic
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, DemoError>) -> Void) {
       
        aPIHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}

protocol APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void)
}

// Single Responsibilty - Since APIHandler is used for API calls it should implemented inside Network Manager class
class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
           
        }.resume()
    }
    
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void)
}

// Single Responsibilty - Since Response is used for getting news data it should implemented inside Network Manager class
class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void) {
        let newsResponse = try? JSONDecoder().decode(type.self, from: data)
        if let newsResponse = newsResponse {
            return completion(.success(newsResponse))
        } else {
            completion(.failure(.DecodingError))
        }

    }
    
}
