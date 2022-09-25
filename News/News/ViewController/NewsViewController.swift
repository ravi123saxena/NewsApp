//
//  ViewController.swift
//  News
//
//  Created by Zensar on 24/09/22.
//

import UIKit

class NewsViewController: UIViewController, NewsViewModelProtocol {
   
    @IBOutlet weak var countrylabel: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var toggle: UISwitch!
    let refreshControl = UIRefreshControl()
    private var viewModel = NewsViewModel()
    var newsData : [NewsModel]!
    var indicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        if(countrylabel.text == "US") {
            toggle.isOn = false
        }
        viewModel.delegate = self
        self.startActivityIndicator()
        viewModel.fetchNews()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table.addSubview(refreshControl)
    }
    
    @IBAction func SwitchButtonPressed(_ sender: Any) {
        self.startActivityIndicator()
        if ((sender as AnyObject).isOn == true) {
            self.countrylabel.text = "CANADA"
            UserDefaults.standard.set(false, forKey: "isUS")
            viewModel.fetchNews()
        }
        else {
            self.countrylabel.text = "US"
            UserDefaults.standard.set(true, forKey: "isUS")
            viewModel.fetchNews()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.fetchNews()
    }
    
    func startActivityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 40, 40))
        indicator.style = .large
        indicator.center = self.view.center
        indicator.backgroundColor = .white
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
    }
    
    func stopActivityIndicator() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func getResult(result: [NewsModel]) {
        refreshControl.endRefreshing()
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 100
        self.newsData = result
        table.reloadData()
        self.stopActivityIndicator()
    }
}

extension NewsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let news = self.newsData[indexPath.row]
        if let url = URL(string: news.urlToImage ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.newsIcon.image = image
                            //cell.newsIcon.layer.masksToBounds = true
                            //cell.newsIcon.layer.cornerRadius = cell.newsIcon.frame.width / 2
                        }
                    }
                }
            }
        }
        cell.newsTitle.text = news.author
        cell.newsSubTitle.text = news.title
        cell.newsDatePublished.text = news.publishedAt
        
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = self.newsData[indexPath.row]
        let vc : NewsDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.auther = news.author
        vc.publishdate = news.publishedAt
        self.navigationController?.pushViewController(vc,animated:true)
    }
    
}

