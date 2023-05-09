//
//  FakeNetworkManager.swift
//  Week6CombineApiTests
//
//  Created by Payam Karbassi on 08/05/2023.
//

import Foundation
import Combine

@testable import Week6CombineApi

class FakeNetworkManager : CombineNetworkableProtocol {
    func getListFromAPI<T>(url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        
        guard let pathUrl = Bundle (for: FakeNetworkManager.self).url(forResource: url.absoluteString, withExtension: "json")else {
            return Fail(error: NetworkErrorEnum.invalidUrlError).eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: pathUrl)
            print(data.isEmpty)
            
            let results = try JSONDecoder().decode(PlanetsModel.self, from: data)
            
            return Just(results as! T)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkErrorEnum.dataNotFoundError).eraseToAnyPublisher()
        }
    }
}
