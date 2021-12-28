//
//  ItemsModel.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Soul. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class ItemsModel: NSObject, Mappable {
    
    var kind          : NSString = ""
    var id            : NSString = ""
    var etag          : NSString = ""
    var selfLink      : NSString = ""
    var volumeInfo    : VolumeInfoModel!
    
    init(kind: NSString, id: NSString, etag: NSString,selfLink: NSString,volumeInfo: VolumeInfoModel) {
        
        self.kind       = kind
        self.id = id
        self.etag = etag
        self.selfLink = selfLink
        self.volumeInfo = volumeInfo
        
    }
    
    required internal init?(map: Map){ }
    
    internal func mapping(map: Map) {
        
        kind     <- map["kind"]
        id       <- map["id"]
        etag     <- map["etag"]
        selfLink <- map["selfLink"]
        volumeInfo <- map["volumeInfo"]
        
    }
}
