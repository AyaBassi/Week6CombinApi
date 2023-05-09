//
//  CombineNetworkManager.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation
import Combine

class CombineNetworkManager :CombineNetworkableProtocol{
    func getListFromAPI<T>(url: URL) -> AnyPublisher<T, Error> where T:Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            //.map{$0.data}
            //.delay(for: .seconds(2.0) , scheduler: DispatchQueue.main)
            .tryMap{(data:Data,response:URLResponse) in
                guard let httpsResponse = response as? HTTPURLResponse, 200...209 ~= httpsResponse.statusCode else {
                    throw NetworkErrorEnum.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
}
