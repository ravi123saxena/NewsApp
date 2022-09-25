

import Foundation

// MARK: - Service Handler
// interface segrigation
// LISKOV - subclass should override baseclass . suppose if we have functionality to get data in online and offline mode then we have create databaseHandler and this subclass must override NewsService class to support online and offline mode

protocol NewsViewServiceDelegate: NewsDelegate {
    
}

protocol NewsDelegate {
    func getNews(completion: @escaping(Result<ResultNewsModel, DemoError>) -> Void)
}

// We can add more request for some other functionality for getting data

class NewsViewService: NewsViewServiceDelegate  {
    func getNews(completion: @escaping(Result<ResultNewsModel, DemoError>) -> Void) {
        let base_url = getAPIURI()
        guard let url = URL(string: base_url) else {
            return completion(.failure(.BadURL))
        }
        
        NetworkManager().fetchRequest(type: ResultNewsModel.self, url: url, completion: completion)
    }
    
    func getAPIURI() -> String {
        let isDefaultCountry = UserDefaults.standard.bool(forKey: "isUS")
        let baseurl     = BaseUrl + "?"
        let country     = "q=\(isDefaultCountry ? "us": "canada")&"
        let apiKey      = "apiKey=\(ApiKey)"
        let url         = baseurl + country + apiKey
        
        return url
    }
}
