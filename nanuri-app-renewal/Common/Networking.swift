//
//  Networking.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/26.
//

import Foundation

import Alamofire

class Networking: NSObject {
    static var sharedObject = Networking()
    
    let sessionManager: Session = {
        let interceptor = Interceptor()
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return Session(configuration: configuration, interceptor: interceptor)
    }()
}

// 사용자 정보
extension Networking {
  
    func getUserInfo(url: String, completion: @escaping (_ response: UserInfo) -> ()) {
        guard let userToken = UserDefaults.standard.string(forKey: "token") else { return }
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "Authorization": "Token \(userToken)"
        ]
//        String(describing: UserDefaults.standard.string(forKey: "token"))
        let url = "https://nanuri.app/api/v1/users/"
//        let url = "http://localhost:8080/api/v1/users/"
        
        let request = setGetRequest(url: url, params: nil, headers: header)
        request.responseDecodable(of: UserInfo.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                completion(response)
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postUserListRequest(url: String,params:[String: Any], completion: @escaping (_ response: UserInfo) -> ()) {
        guard let userToken = UserDefaults.standard.string(forKey: "token") else { return }
        let header: HTTPHeaders = [
            "Authorization": "Token \(userToken)"
        ]
        let request = setPostRequest(url: url, params: params, headers: header)
        request.responseDecodable(of: UserInfo.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                completion(response)
                print(response)
                print("유저정보:\(UserInfo.self)")
            case .failure(let error):
                print(error)
            }
        }
    }
    // patch
    func patchUserDetail(url: String,params:[String: Any], completion: @escaping (_ response: UserInfo) -> ()) {
        guard let userToken = UserDefaults.standard.string(forKey: "token") else { return }
        let header: HTTPHeaders = [
            "Authorization": "Token \(userToken)"
        ]
        let request = setPatchRequest(url: url, params: params, headers: header)
        request.responseDecodable(of: UserInfo.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                completion(response)
                print(response)
                print("유저정보:\(UserInfo.self)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension Networking {
    // 사용자정보
   private func getUserInfo(url: String, completion: @escaping (_ response: UserList) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Token \(Singleton.shared.userToken)"
        ]
        let url = "https://nanuri.app/api/v1/users/"
       let request = setGetRequest(url: url, params: nil, headers: header)
       request.responseDecodable(of: UserList.self) { response in
           switch response.result {
           case .success(_):
               guard let response = response.value else { return }
               completion(response)
               print(response)
           case .failure(let error):
               print(error)
           }
       }
    }
    
    private func postUserListRequest(url: String,params:[String: String], completion: @escaping (_ response: UserInfo) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Token \(Singleton.shared.userToken)"
        ]
        let request = setPostRequest(url: url, params: params, headers: header)
            request.responseDecodable(of: UserInfo.self) { response in
                switch response.result {
                case .success(_):
                    guard let response = response.value else { return }
                    completion(response)
                    print(response)
                case .failure(let error):
                    print(error)
                }
            }
//        let root = AF.request(url, method: .get)
//        root.responseDecodable(of: UserPostResponse.self) { response in
//            switch response.result {
//            case .success(_):
//                guard let result = response.value else { return }
//                completion(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

extension Networking {
  
    /// 상품 리스트 불러오기
    /// - Parameter result: 종료 후 호출 할 Closure
    func getPostsList(result: @escaping (_ response: PostList) -> ()) {
        let url = "\(APIInfo.hostURL)\(APIInfo.api)\(APIInfo.version)\(APIList.posts)"
        
        print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] \(url) 👉 ")
        
        getPostsListRequest(url: url, completion: result)
    }
    
    func postPosts(image: UIImage, parameter: [String: Any], result: @escaping (_ response: ResultInfo) -> ()) {
        let url = "\(APIInfo.hostURL)\(APIInfo.api)\(APIInfo.version)\(APIList.posts)"
    
        let params = parameter
        let imageData = image.jpegData(compressionQuality: 0.7)!
        print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] \(url) 👉 \(params)")
        
        postPostsRequest(image: imageData, url: url, params: params, completion: result)
    }
}

extension Networking {

    private func getPostsListRequest(url: String, completion: @escaping (_ response: PostList) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Token \(Singleton.shared.userToken)"
        ]
        let request = setGetRequest(url: url, params: nil, headers: header)
        request.responseDecodable(of: PostList.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                completion(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func postPostsRequest(image: Data, url: String, params: [String : Any], completion: @escaping (_ response: ResultInfo) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Token \(Singleton.shared.userToken)",
            "Content-Type" : "multipart/form-data"
        ]
        AF.upload(multipartFormData: { multiFormData in
            for (key, value) in params {
                multiFormData.append(Data("\(value)".utf8), withName: key)
            }
            multiFormData.append(image, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: url, headers: header)
            .uploadProgress(queue: .main) { progress in
               print("Upload Progress: \(progress.fractionCompleted)")
            }
            .responseString { response in
            switch response.result {
            case .success(_):
                print("sucess reponse is :\(response)")
            case .failure(_):
                print("fail")
            }
        }
    }
}

extension Networking {
    func setPostRequest(url: String, params: Parameters?, headers: HTTPHeaders) -> DataRequest {
        return sessionManager.request(url, method: .post, parameters: params, headers: headers)
    }
    
    func setGetRequest(url: String, params: Parameters?, headers: HTTPHeaders) -> DataRequest {
        return sessionManager.request(url, method: .get, parameters: params, headers: headers)
    }
    
    func setPatchRequest(url: String, params: Parameters?, headers: HTTPHeaders) -> DataRequest {
        return sessionManager.request(url, method: .patch, parameters: params,  headers: headers)
    }
}
