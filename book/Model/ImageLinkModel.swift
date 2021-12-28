//
//  ImageLinkModel.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class ImageLinkModel: NSObject, Mappable {
    
    var smallThumbnail   : NSString = ""
    var thumbnail        : NSString = ""
    
    init(smallThumbnail: NSString, thumbnail: NSString ) {
        
        self.smallThumbnail = smallThumbnail
        self.thumbnail      = thumbnail
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        smallThumbnail   <- map["smallThumbnail"]
        thumbnail        <- map["thumbnail"]
    }
}
