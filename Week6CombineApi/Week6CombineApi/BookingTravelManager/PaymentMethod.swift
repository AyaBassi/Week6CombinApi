//
//  PaymentMethod.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 09/05/2023.
//

import Foundation

enum PaymentMethodEnum{
    case visa
    case paypal
}

class PaymentMethod {
    func processPayment(paymentMethod:PaymentMethodEnum) -> ProcessPaymentProtocol{
        switch paymentMethod {
        case .visa:
            return VisaPayment()
        case .paypal:
            return PaypalPayment()
        }
    }
}

protocol ProcessPaymentProtocol{
    func paymentIsAccepted(amount:Double, accountNumber:Int)->Bool
}
