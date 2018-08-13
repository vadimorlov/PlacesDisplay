//
//  NetworkManager.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias objectCompletionHandler = ([PlaceUnion]?, Error?) -> Swift.Void

class NetworkManager {
    
    static let shared = NetworkManager()
    
    //MARK: - High Level Requests
    func getPlaces(completionHandler: objectCompletionHandler? = nil) {
        self.sendRequest(for: Endpoint.getPlaces) { places, error in
            print("====== PLACES RESPONSE -> \(String(describing: places)) ======")
            if places != nil {
                completionHandler?(places, nil)
            } else {
                completionHandler?(nil, error)
            }
        }
    }
    
    //MARK: - Send Request
    func sendRequest(for method: String, completionHandler: objectCompletionHandler? = nil) {
        let url = Backend.baseUrl + method
        print("====== REQUEST FOR -> \(url) ======")
        if Connectivity.isConnectedToInternet {
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
                if response.error == nil {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromUpperCamelCase
                    do {
                        let result = try jsonDecoder.decode(Result.self, from: response.data!)
                        let placeUnions = result.placeUnions
                        completionHandler!(placeUnions, nil)
                    } catch {
                        print(error)
                        completionHandler!(nil, error)
                    }
                } else {
                    completionHandler!(nil, response.error)
                }
            }
        } else {
            let error = NSError(domain: "com.vadimorlov.PlacesDisplay", code: 408, userInfo: ["description": "No Internet Connection"])
            completionHandler!(nil, error)
        }
    }
}

//MARK: - Network Service
class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

