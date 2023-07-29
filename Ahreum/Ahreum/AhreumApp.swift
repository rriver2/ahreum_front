//
//  AhreumApp.swift
//  Ahreum
//
//  Created by Gaeun Lee on 2023/07/28.
//

import SwiftUI

@main
struct AhreumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    let key = UserDefaultManager.UserDefaultKey.userId.rawValue
//                    if let id = UserDefaults.standard.object(forKey: key) as? String {
//                        UserDefaultManager.shared.id = id
//                    } else {
                        let id = Utils.getDeviceUUID()
                        UserDefaults.standard.set(id, forKey: key)
                        // 호출 보내기
                        let postData = PostData(user_id: id)
                        APIManager().sendPostRequest(data: postData, url: "http://digooo.shop:5000/user-api") { result in
                            switch result {
                            case .success(let data):
                                if let responseString = String(data: data, encoding: .utf8) {
                                    print("Response: \(responseString)")
                                }
                                // Handle successful response here.
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                                // Handle error here.
                            }
                        }
//                    }
                }
        }
    }
}

struct PostData: Codable {
    let user_id: String
}

struct PostData1: Codable {
    let user_id: String
    let keyword: String
}

struct PostData2: Codable {
    let user_id: String
    let video_id: String
}

class APIManager {
    func sendPostRequest1(data: PostData1, url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
            }
        }.resume()
    }
    func sendPostRequest2(data: PostData2, url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
            }
        }.resume()
    }
    
    func sendPostRequest(data: PostData, url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
            }
        }.resume()
    }
}
