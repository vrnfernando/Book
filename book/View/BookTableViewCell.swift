//
//  BookTableViewCell.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var tv_description: UITextView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tv_description.isEditable = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        self.view.layer.cornerRadius = 10.0
        self.view.layer.shadowColor = UIColor.gray.cgColor
        self.view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.view.layer.shadowRadius = 6.0
        self.view.layer.shadowOpacity = 0.7
    }
    
    func fetchImage(urlString: NSString){
        let url = URL(string: urlString as String)!
        downloadImage(from: url)
    }
    
    func downloadImage(from url: URL) {
        
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.img_view.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}





