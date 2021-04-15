//
//  UserManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-10.
//

import Foundation

struct UserManager {
    
    private let router = Router<UserAPI>()
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getAccountInfo(completion: @escaping(_ items: AccountCardViewModel?, _ error: String?) -> Void) {
        router.request(.user) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let account = try decoder.decode(AccountInfoModel.self, from: responseData)
                        let accountViewModel = AccountCardViewModel(accountInfo: account)
                        completion(accountViewModel, nil)

                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getToken(code: String, completion: @escaping(_ token: AuthResponse?, _ error: String?) -> Void) {
        router.request(.token(code: code)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let token = try decoder.decode(AuthResponse.self, from: responseData)
                        completion(token, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
}
