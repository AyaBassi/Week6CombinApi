//
//  ContentView.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var planetViewModel = PlanetViewModel(combineNetworkManager: CombineNetworkManager())
    @State var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                
                List(planetViewModel.fileteredResults){ result in
                    VStack{
                        NavigationLink {
                            SwiftUIBookingPage(result: result, accountNumber: "", numberOfPeople: "")
                        } label: {
                            Text("Name: \(result.name)")
                            Text("Population: \(result.population)" )
                        }
                    }
                }
            }.onAppear{
                planetViewModel.getList(apiUrl: APIEndPoint.planetApi)
            }.refreshable {
                planetViewModel.getList(apiUrl: APIEndPoint.planetApi)
            }
            .searchable(text: $searchText,
                         placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search")
            .onChange(of: searchText) { string in
                print("typed: ",string)
                planetViewModel.searchList(with: string)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel Api") {
                        planetViewModel.cancelApiCall()
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
