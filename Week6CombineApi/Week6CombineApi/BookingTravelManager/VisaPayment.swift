//
//  VisaPayment.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 09/05/2023.
//

import Foundation

class VisaPayment : ProcessPaymentProtocol{
    func paymentIsAccepted(amount: Double, accountNumber: Int) -> Bool {
        print("VisaPayment being proccessed...")
        var paymentShouldIsAccepted = false
        var bankBalance = 1000.0
        if bankBalance - amount >= 0 {
            bankBalance = bankBalance - amount
            paymentShouldIsAccepted = true
        }else {
            paymentShouldIsAccepted = false
        }
        return paymentShouldIsAccepted
    }
}
