//
//  NetworkErrorEnum.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation

enum NetworkErrorEnum :Error ,Equatable{
    static func == (lhs: NetworkErrorEnum, rhs: NetworkErrorEnum) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
    
    case dataNotFoundError
    case parsingError
    case invalidUrlError
    case responseError
}

extension NetworkErrorEnum: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .dataNotFoundError:
            return NSLocalizedString("dataNotFoundError:", comment: "dataNotFoundError")
        case .parsingError:
            return NSLocalizedString("Failed to parse API", comment: "NetworkErrorEnum.parsingError")
        case .invalidUrlError:
            return NSLocalizedString("Invalid URL", comment: "NetworkErrorEnum.invalidUrlError")
        case .responseError:
            return NSLocalizedString("Response Error", comment: "responseError")
        }
    }
}
