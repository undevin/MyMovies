//
//  ContentView.swift
//  MyMovies
//
//  Created by Paul Hudson on 12/05/2021.
//

import SwiftUI

struct MovieView: View {
    @State private var searchResults = Bundle.main.decode(SearchResults.self, from: "results.json", keyDecodingStrategy: .convertFromSnakeCase)
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(searchResults.results, content: MovieRow.init)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("MyMovies")
        }
    }
}//End of Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
