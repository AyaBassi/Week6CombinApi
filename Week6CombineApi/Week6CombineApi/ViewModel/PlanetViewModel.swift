//
//  PlanetViewModel.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation
import Combine

class PlanetViewModel:ObservableObject {
    
    @Published var results : [Result] = []
    @Published var fileteredResults : [Result] = []
    let combineNetworkManager : CombineNetworkableProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var customError : NetworkErrorEnum?
    
    init(combineNetworkManager: CombineNetworkableProtocol) {
        self.combineNetworkManager = combineNetworkManager
    }
    
    func getList(apiUrl:String) {
        guard let url = URL(string: apiUrl) else { customError = .invalidUrlError
            return}
        combineNetworkManager.getListFromAPI(url: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion  in
                switch completion {
                case  .finished: print("Success")
                case .failure(let error):
                    switch error {
                    case is URLError :      self.customError = .invalidUrlError
                    case is DecodingError:  self.customError = .parsingError
                    default:                self.customError = .dataNotFoundError
                    }
                    print("Opps something went wrong: ",self.customError?.errorDescription ?? "Some error")
                }
            }, receiveValue: { (planetData : PlanetsModel)in
                self.fileteredResults = planetData.results
                self.results = planetData.results
            
                self.fileteredResults = self.fileteredResults.sorted(by: { $0.name < $1.name})
                
                
            })
            .store(in: &cancellable)
    }
    
    func searchList(with string:String){
        if string.isEmpty {
            self.fileteredResults = self.results
        }
        else {
            let filteredList = self.results.filter { result in
                return result.name.lowercased().contains(string.lowercased())
            }
            self.fileteredResults = filteredList
        }
    }
    
    func cancelApiCall(){
        cancellable.first?.cancel()
    }
    
    func travelToPlanet(numberOfPeople:Int,payment: (paymentMethod: PaymentMethodEnum, amount: Double, accountNumber: Int))->Bool{
        
        let facade = BookTravelToPlanetFacade()
        return facade.bookTravel(numberOfPeople: numberOfPeople, payment: payment)
    }
}
