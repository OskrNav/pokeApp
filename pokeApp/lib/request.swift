//
//  request.swift
//  clashoffan
//
//  Created by Oscar Navidad on 4/5/18.
//  Copyright © 2018 IW. All rights reserved.
//

import Foundation

class Request : NSObject , URLSessionDelegate {
    
    var path:String = ""
    var header:[String:AnyObject] = [:]
    var params:[String:Any] = [:]
    var method : String = "POST"
    
    func buildURl() -> URL{
        let baseUrl = GeneralSettings.BASE_URL
        return URL(string:baseUrl + path)!
    }
    func sendRequest(_ callback: @escaping (JSON) -> Void) {
        
        // create post request
        
        let url = buildURl()
        print("URL = \(url)")
        print(params)
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if !header.isEmpty {
            for (key , value) in header {
                print(value as! String)
                request.addValue(value as! String, forHTTPHeaderField: key)
            }
        }
        if !params.isEmpty{
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request.httpBody = jsonData
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main )
        let task = session.dataTask(with: request) { data, response, error in
            
            if response != nil {
            
            let status = (response as! HTTPURLResponse).statusCode
            print("status \(status)")

            if (status >= 300 && status <= 500) {
                var message = ""
                if status == 401 {
                     message = "no autorizado"
                }else{
                    let block = try! JSON(data:data!)
                    let errorOB = errorObject(data: block["errors"])
                     message = "\(errorOB.errors.first?.detail ?? "" )"
                }
                    let string = "{\"codigoMensaje\":\"\(status)\",\"error\":\"\(message ?? "")\"}"
                    let d:NSData = string.data(using: String.Encoding.utf8)! as NSData
                    DispatchQueue.main.async {
                    try! callback(JSON(data: d as Data))
                    }
                return
             }
            }
            
            
            
            guard let data = data, error == nil else {
                let string = "{\"codigoMensaje\":\"911\",\"error\":\"No se pudo contectar con servidor por favor intentelo de nuevo.\"}"
                let d:NSData = string.data(using: String.Encoding.utf8)! as NSData
                DispatchQueue.main.async {
                    try! callback(JSON(data: d as Data))
                }
                return
            }
             DispatchQueue.main.async {
                //let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                //print(string1)
                try! callback(JSON(data: data))
            }
        }
        task.resume()
    }
}
