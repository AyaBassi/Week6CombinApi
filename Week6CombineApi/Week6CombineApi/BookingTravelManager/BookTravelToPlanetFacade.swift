//
//  BookTravelToPlanetFacade.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 09/05/2023.
//

import Foundation

class BookTravelToPlanetFacade {
    
    func bookTravel(numberOfPeople:Int,payment:(paymentMethod:PaymentMethodEnum,amount:Double,accountNumber:Int))->Bool{
        
        var isBooked = false
        
        guard CheckAvailability().checkAvailability(numberOfGuests: 20) else {
            print("Not enough space.")
            return isBooked
        }
        
        guard PaymentMethod().processPayment(paymentMethod: payment.paymentMethod).paymentIsAccepted(amount: payment.amount, accountNumber: payment.accountNumber) else {
            print("Payment did not go through")
            return isBooked
        }
        
        print("Travel has been accepted")
        isBooked = true
        return isBooked
    }
}





