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
    
    func getUserNicNameResquest(parameters: [String: String], completion: @escaping (UserResult) -> Void) {
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Token \(loadedToken.token)"
                ]
                let session = URLSession(configuration: configuration)
                
                let url = baseURL
                guard var urlComponents = URLComponents(string: url) else { return }
                
                let queryItems = parameters.map { (key: String, value: String) in
                    return URLQueryItem(name: key, value: value)
                }
                urlComponents.queryItems = queryItems
                
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
                        let userResult = try decoder.decode(UserResult.self, from: data)
                        completion(userResult)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func patchUserInfoRequest(parameters: [String: Any], imageData: Data? = nil, filename: String? = nil, mimeType: String? = nil, completionHandler: @escaping (UserInfo) -> Void) {
        
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Token \(loadedToken.token)"
                ]
                
                let url = baseURL + loadedToken.uuid
                guard let urlComponents = URLComponents(string: url) else { return }
                guard let requestURL = urlComponents.url else { return }
                var request = URLRequest(url: requestURL)
                
                // boundary 설정
                let boundary = "Boundary-\(UUID().uuidString)"
                
                request.httpMethod = "PATCH"
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
                // data
                var uploadData = Data()
                let imgDataKey = "profile"
                let boundaryPrefix = "--\(boundary)\r\n"
                
                for (key, value) in parameters {
                    uploadData.append(boundaryPrefix.data(using: .utf8)!)
                    uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    uploadData.append("\(value)\r\n".data(using: .utf8)!)
                }
                
                // image를 첨부하지 않아도 작동할 수 있도록 if let을 통해 images 여부 확인
                if let imageData = imageData {
                    uploadData.append(boundaryPrefix.data(using: .utf8)!)
                    uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename ?? "profileImage.jpeg")\"\r\n".data(using: .utf8)!)
                    uploadData.append("Content-Type: \(mimeType ?? "image/jpeg")\r\n\r\n".data(using: .utf8)!)
                    uploadData.append(imageData)
                    uploadData.append("\r\n".data(using: .utf8)!)
                    uploadData.append("--\(boundary)--".data(using: .utf8)!)
                }
                
                let defaultSession = URLSession(configuration: configuration)
                
                defaultSession.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode)  else {
                              print("Error: HTTP request failed \n --> response: \(response)")
                              return
                          }
                    
                    guard let data = data else { return }
                    
                    do {
                        let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                        completionHandler(userInfo)
                        
                    } catch let error as NSError {
                        print("Error occur: error calling PATCH - \(error)")
                    }
                }.resume()
            }
        }
    }
    
    func patchUserIsActiveRequest(parameters: [String: Any]) {
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                let configuration = URLSessionConfiguration.default
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Token \(loadedToken.token)"
                ]
                
                let url = baseURL + loadedToken.uuid
                guard let urlComponents = URLComponents(string: url) else { return }
                guard let requestURL = urlComponents.url else { return }
                var request = URLRequest(url: requestURL)
                
                request.httpMethod = "PATCH"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                // data
                let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                request.httpBody = jsonData
                
                let defaultSession = URLSession(configuration: configuration)
                
                defaultSession.dataTask(with: request) { data, response, error in
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200..<300).contains(httpResponse.statusCode)  else {
                              print("Error: HTTP request failed \n --> response: \(response)")
                              return
                          }
                    
                    guard let data = data else { return }
                    
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                        print("로그아웃 완료 \(json["is_active"])")
                    } catch let error as NSError {
                        print("Error occur: error calling PATCH - \(error)")
                    }
                }.resume()
            }
        }
    }
}

