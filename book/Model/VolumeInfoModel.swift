//
//  VolumeInfoModel.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class VolumeInfoModel: NSObject, Mappable {
    
    var title          : NSString = ""
    var _description   : NSString  = ""
    var imageLinks     : ImageLinkModel!

    
    init(title: NSString, _description: NSString, imageLinks: ImageLinkModel) {
        
        self.title       = title
        self._description = _description
        self.imageLinks = imageLinks

    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        title        <- map["title"]
        _description <- map["description"]
        imageLinks   <- map["imageLinks"]

    }
}
