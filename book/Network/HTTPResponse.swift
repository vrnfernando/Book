//
//  HTTPResponse.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Vishwa Fernando. All rights reserved.
//

import Foundation
import UIKit

class HTTPResponse: NSObject {
    
    var responseStatus  : Bool  = true
    var responseResult  : JSON?
    var responseError   : RestClientError?
    
    init(status: Bool, result: JSON? = nil, error: RestClientError? = nil) {
        self.responseStatus     = status
        self.responseResult     = result
        self.responseError      = error
    }
    
    init(result: JSON? = nil, error: RestClientError? = nil) {
        self.responseResult     = result
        self.responseError      = error
    }
}
