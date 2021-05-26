//
//  MyMoviesApp.swift
//  MyMovies
//
//  Created by Paul Hudson on 12/05/2021.
//

import SwiftUI

@main
struct MyMoviesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MovieView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}//End of Struct
