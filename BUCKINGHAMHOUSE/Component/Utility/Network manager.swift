//
//  Network manager.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 04/08/23.
//

import Foundation
import Alamofire


class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    func makeAPICall(urlString: String, parameters: [String: Any] = [:], headers: [String: String] = [:], method: String = "GET", encoding: ParameterEncoding = JSONEncoding.default, completion:@escaping ([String: Any]?) -> Void) {
        Alamofire.request(urlString, method: HTTPMethod(rawValue: method)!, parameters: parameters, encoding: encoding, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                completion(json)
            } else {
                completion(nil)
            }
        }
    }
}
