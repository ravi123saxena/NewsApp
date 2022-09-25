

import Foundation

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
        var base_url = getAPIURI()
        guard let url = URL(string: base_url) else {
            return completion(.failure(.BadURL))
        }
        
        NetworkManager().fetchRequest(type: ResultNewsModel.self, url: url, completion: completion)
    }
    
    func getAPIURI() -> String {
        let isDefaultCountry = UserDefaults.standard.bool(forKey: "isUS")
        var uri = ""
        if(isDefaultCountry) {
            uri = "https://newsapi.org/v2/everything?q=us&from=2022-08-24&sortBy=publishedAt&apiKey=f77c99c5cb3d4cccacf53cb0e9d75861"
        }
        else {
            uri = "https://newsapi.org/v2/everything?q=Canada&from=2022-08-24&sortBy=publishedAt&apiKey=f77c99c5cb3d4cccacf53cb0e9d75861"
        }
        return uri
    }
}
