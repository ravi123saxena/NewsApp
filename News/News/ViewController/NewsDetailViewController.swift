//
//  NewsDetailViewController.swift
//  News
//
//  Created by Zensar on 25/09/22.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var autherTitle: UILabel!
    var auther: String? = ""
    var publishdate: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.autherTitle?.text = auther
        self.publishDate?.text = publishdate?.UTCToLongLocal()
    }
    

}
