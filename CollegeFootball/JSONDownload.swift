//
//  JSONDownload.swift
//  CollegeFootball
//
//  Created by Kaj Schermer Didriksen on 07/10/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import Foundation

class JSONDownload {
    
    var delegate: JSONDownloadDelegate?
    
    enum JSONError: String, Error {
        case NoData = "Error: No Data!"
        case ConvertionFailed = "Error: Convertion from JSON failed!"
    }
    
    init(urlPath: String, delegate: JSONDownloadDelegate) {
        
        self.delegate = delegate
        
        if let endPoint = URL(string: urlPath){
         let request = URLRequest(url: endPoint)
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                do {
                    guard let data = data else {
                        throw JSONError.NoData
                    }
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] else {
                        throw JSONError.ConvertionFailed
                    }
                    DispatchQueue.main.async {
                        if let delegate = self.delegate {
                            delegate.finishedDownloadingJSON(data: json)
                        }
                        
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch let error {
                    print(error.localizedDescription)
                }
            }).resume()
        }
    }
}
