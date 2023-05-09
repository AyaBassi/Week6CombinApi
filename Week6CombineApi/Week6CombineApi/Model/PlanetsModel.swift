//
//  PlanetsModel.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation

struct PlanetsModel: Decodable {
    let results : [Result]
}

struct Result: Decodable
//,Identifiable
{
    //let id = UUID()
    let name:String
    let population:String
}

extension Result :Identifiable{
    var id: UUID {
        return UUID()
    }
}

