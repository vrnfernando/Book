//
//  HTTPService.swift
//  book
//
//  Created by Vishwa Fernando on 12/28/21.
//  Copyright © 2021 Vishwa Fernando. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol BookListAPIDelegate: class {
    
    func getList(items: [ItemsModel])
    func getList(_ error: RestClientError)
}

class HTTPService: NSObject {
    
    weak var bookListDelegate    : BookListAPIDelegate?
    
    var baseUrl         : NSString?
    var parameters      : [String : AnyObject]?
    var headers         : HTTPHeaders
    
    init(baseUrl: NSString!) {
        
        self.baseUrl    = baseUrl
        parameters      = [:]
        self.headers    = [
            "Content-Type":"application/json"]
    }
    
    //Get Requests
    func getRequest(_ parameters: [String: AnyObject]?, contextPath: NSString, completionHandler: @escaping (HTTPResponse) -> Void) {
        
        let urlString   = "\(self.baseUrl!)\(contextPath)" as URLConvertible
        
        print("urlString: ",urlString)
        print(self.headers)
        Alamofire.request(urlString, method: .get, parameters: self.parameters!, headers: self.headers).responseJSON { (response) in
            
            var httpResponse: HTTPResponse! = nil
            
            if let errorCode        = response.result.error,
                let errorMessage    = response.result.error?.localizedDescription {
                
                httpResponse                = HTTPResponse(result: nil, error: nil)
                print("alamofire error")
                print("getRequest -> error code: \(errorCode)")
                print("getRequest -> error message: \(errorMessage)")
                
            } else {
                
                do {
                    let jsonResult = try JSON(data: response.data!)
                    print("jsonResult:   \(jsonResult)")
                    if response.response!.statusCode >= 200 && response.response!.statusCode < 300 {    /// check
                        httpResponse        = HTTPResponse(result: jsonResult, error: nil)
                    } else if response.response!.statusCode == 401 {
                        
                    }else{
                        let exception       = RestClientError.init(jsonResult: jsonResult)
                        httpResponse        = HTTPResponse(result: nil, error: exception)
                    }
                    
                } catch {
                    let exception           = RestClientError.jsonParseError(errorCode: "String(jsonParseError.code)", errorMessage: "jsonParseError.msg")
                    httpResponse            = HTTPResponse(result: nil, error: exception)
                }
            }
            completionHandler(httpResponse)
        }
        
        
    }
    
    
}


extension HTTPService: bookListAPIProtocol {
    
    //get books
    func getBooks(){
        
        let contextPath = "/books/v1/volumes?q=flowers&startIndex=0&maxResults=10"
        
        getRequest(nil, contextPath: contextPath as NSString) { (response) in
            
            let responseError = response.responseError
            let responseResult  = response.responseResult
            
            if let error = responseError {
                self.bookListDelegate?.getList(error)
                return
            }
            
            if let json = responseResult {
                if let jsonArray    = json["items"].array {       //access requested data here
                    var booksList       = [ItemsModel]()
                    for jsonObj in jsonArray {
                        if let jsonString   = jsonObj.rawString() {
                            if let book     = Mapper<ItemsModel>().map(JSONString: jsonString) {
                                booksList.append(book)
                            }
                        }
                    }
                    
                    self.bookListDelegate?.getList(items: booksList)
                    return
                } else {
                    let exception               = RestClientError.jsonParseError(errorCode: String("si.jsonParseError.code"), errorMessage: "si.jsonParseError.msg")
                    self.bookListDelegate?.getList(exception)
                    return
                }
            }
            
            print("handle default error here:")
            return
        }
        
    }
    
}
