//
//  CombineNetworkableProtocol.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation
import Combine

protocol CombineNetworkableProtocol{
    func getListFromAPI<T>(url:URL) -> AnyPublisher<T,Error> where T : Decodable
}
