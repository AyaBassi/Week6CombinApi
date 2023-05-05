//
//  ContentView.swift
//  Week6CombineApi
//
//  Created by Payam Karbassi on 05/05/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = PlanetViewModel(combineNetworkManager: CombineNetworkManager())
    @State var searchText = ""
    var body: some View {
        NavigationStack {
            VStack {
                
                List(viewModel.results.filter({
                    searchText.isEmpty ? true : $0.name.contains(searchText)
                })){ result in
                    VStack{
                        Text("Name: \(result.name)")
                        Text("Population: \(result.population)" )
                    }
                }
            }.onAppear{
                viewModel.getList(apiUrl: APIEndPoint.planetApi)
            }
        .padding()
        }.searchable(text: $searchText, placement:.toolbar, prompt: "Search")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
