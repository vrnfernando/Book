//
//  BookListModel.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class BooksModel: NSObject, Mappable {
    
    var kind          : NSString = ""
    var totalItems    : NSNumber = 0
    var items         : [ItemsModel] = []
    
    init(kind: NSString, totalItems: NSNumber, items: [ItemsModel]) {
        
        self.kind       = kind
        self.totalItems = totalItems
        self.items      = items
        
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        kind           <- map["kind"]
        totalItems     <- map["totalItems"]
        items          <- map["items"]
        
    }
}

