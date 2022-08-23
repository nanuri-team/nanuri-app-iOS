//
//  NetworkService.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/22.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = APIInfo.hostURL + APIInfo.api + APIInfo.version + APIList.user
    
    private init() { }
    
    func getUserInfoRequest(completion: @escaping (UserInfo) -> Void) {
        
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Token \(loadedToken.token)"
                ]
                let session = URLSession(configuration: configuration)
                let url = baseURL + loadedToken.uuid
                guard let urlComponents = URLComponents(string: url) else { return }
                guard let requestURL = urlComponents.url else { return }
                var request = URLRequest(url: requestURL)
                request.httpMethod = "GET"
                
                let task = session.dataTask(with: requestURL) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode) else {
                              print("--> response: \(response)")
                              return
                          }
                    guard let data = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        let userInfo = try decoder.decode(UserInfo.self, from: data)
                        completion(userInfo)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func patchUserInfoRequest() {
        
    }
}

