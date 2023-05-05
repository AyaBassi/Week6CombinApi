//
//  PlanetViewModel.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation
import Combine

class PlanetViewModel:ObservableObject {
    
    @Published var results : [ResultForUI] = []
    
    let combineNetworkManager : CombineNetworkableProtocol
    
    private var cancellable = Set<AnyCancellable>()
    var customError = NetworkErrorEnum.dataNotFoundError
    init(combineNetworkManager: CombineNetworkableProtocol) {
        self.combineNetworkManager = combineNetworkManager
    }
    
    func getList(apiUrl:String){
        guard let url = URL(string: apiUrl) else {return}
        combineNetworkManager.getListFromAPI(url: url, type: PlanetsModel.self)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    
                case  .finished:print("Success")
                case .failure(let error ):
                    print(error.localizedDescription)
                    switch error {
                    case is URLError :
                        self.customError = .invalidUrlError
                    case is DecodingError:
                        self.customError = .parsingError
                    default:
                        self.customError = .dataNotFoundError
                    }
                    
                }
            }, receiveValue: { planetData in
                print(planetData)
                
                self.results = planetData.results.map({ result in
                    ResultForUI(id: UUID(), name: result.name, population: result.population)
                })
            })
            .store(in: &cancellable)
    }
    
    
    
}
