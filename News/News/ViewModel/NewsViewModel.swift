//
//  NewsViewModel.swift
//  News
//
//  Created by Zensar on 24/09/22.
//

import Foundation

protocol NewsViewModelProtocol {
    func getResult(result: [NewsModel])
}
class NewsViewModel {
    let serviceHandler: NewsViewServiceDelegate
    var delegate: NewsViewModelProtocol?

    init(serviceHandler: NewsViewServiceDelegate = NewsViewService()) {
        self.serviceHandler = serviceHandler
    }
   
    func fetchNews() {
        serviceHandler.getNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.delegate?.getResult(result: news.articles)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
}



