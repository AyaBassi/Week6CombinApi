//
//  CheckAvailability.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 09/05/2023.
//

import Foundation

class CheckAvailability {
    func checkAvailability(numberOfGuests : Int )-> Bool{
        // check if number of guests are less than or equal to capacity
        let capacity = 20
        return numberOfGuests <= capacity ? true : false
    }
}
