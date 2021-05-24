//
//  ContentView.swift
//  MyMovies
//
//  Created by Paul Hudson on 12/05/2021.
//

import Combine
import SwiftUI

struct MovieView: View {
    @State private var searchResults = SearchResults(results: [])
    @State private var request: AnyCancellable?
    
    @StateObject private var search = DebouncedText()
    
    var body: some View {
        NavigationView {
            List {
                Section(header:
                            TextField("Search for a movie...", text: $search.text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.none)
                    ){
                    ForEach(searchResults.results, content: MovieRow.init)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("MyMovies")
            .onChange(of: search.debouncedText, perform: runSearch)
        }
    }
    
    func runSearch(criteria: String) {
        request?.cancel()
        request = URLSession.shared.get(path: "search/movie", queryItems: ["query" : criteria], defaultValue: SearchResults(results: []), completion: { results in
            searchResults = results
        })
    }
}//End of Struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
