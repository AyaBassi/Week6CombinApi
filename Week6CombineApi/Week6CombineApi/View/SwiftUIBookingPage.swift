//
//  SwiftUIBookingPage.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 09/05/2023.
//

import SwiftUI

struct SwiftUIBookingPage: View {
    
    @State var result : Result
    @State var accountNumber: String
    @State var numberOfPeople: String
    //@StateObject
    var planetViewModel = PlanetViewModel(combineNetworkManager: CombineNetworkManager())
    
    
    var body: some View {
        VStack {
            Text(result.name)
            TextField("Account details", text: $accountNumber)
            TextField("Number of People", text: $numberOfPeople)
            Button("Submit") {
                print(accountNumber)
                guard let numberOfPeople = Int(numberOfPeople) , let accountNumber = Int(accountNumber) else {return}
                if planetViewModel.travelToPlanet(numberOfPeople: Int(numberOfPeople), payment: (paymentMethod: .paypal, amount: 20.0, accountNumber: accountNumber))
                {
                    print("success booking")
                }
            }
        }
    }
}

//struct SwiftUIBookingPage_Previews: PreviewProvider {
//
//    static var previews: some View {
//    }
//}
