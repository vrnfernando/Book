//
//  ViewController.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var httpService:HTTPService!
    var itemsList: [ItemsModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Network Request - Book List Request (GET)
        httpService = HTTPService(baseUrl: "https://www.googleapis.com" as NSString)
        httpService.getBooks()
        httpService.bookListDelegate = self
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
        tableView.isPagingEnabled = true
        
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell     = self.tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell
        
        cell?.lb_title.text = itemsList[indexPath.row].volumeInfo.title as String
        
        var _description = itemsList[indexPath.row].volumeInfo._description as String
        cell?.tv_description.text = _description != "" ? _description : "No Description Available!"
        
        //load image from network url
        let imgUrl = itemsList[indexPath.row].volumeInfo.imageLinks.thumbnail
        cell?.fetchImage(urlString: imgUrl)
        return cell!
    }
}




extension ViewController : BookListAPIDelegate  {
    
    func getList(items: [ItemsModel]) {
        print(items)
        itemsList = items
        tableView.reloadData()
    }
    
    func getList(_ error: RestClientError) {
        self.showAlert(alertText: "Somthing went wrong!", alertMessage: error.description)
    }
    
}
