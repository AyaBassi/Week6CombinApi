//
//  PlanetsModel.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import Foundation

//struct PlanetsModelSuitableForUI: Decodable ,Identifiable{
//    var id = UUID()
//    let results : [Result]
//}


struct PlanetsModel: Decodable {
    let results : [Result]
}

struct Result: Decodable {
    let name:String
    let population:String
}

struct ResultForUI: Decodable,Identifiable {
    let id:UUID
    let name:String
    let population:String
}
