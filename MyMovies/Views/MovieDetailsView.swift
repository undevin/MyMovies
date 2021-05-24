//
//  MovieDetailView.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    
    @State private var details = Bundle.main.decode(MovieDetails.self, from: "details.json")
    @State private var credits = Bundle.main.decode(Credits.self, from: "credits.json", keyDecodingStrategy: .convertFromSnakeCase)
    @State private var showingAllCast = false
    @State private var showingAllCrew = false
    
    var displayedCast: [CastMember] {
        if showingAllCast {
            return credits.cast
        } else {
            return Array(credits.cast.prefix(5))
        }
    }
    
    var displayedCrew: [CrewMember] {
        if showingAllCrew {
            return credits.crew
        } else {
            return Array(credits.crew.prefix(5))
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    if let path = movie.backdropPath {
                        WebImage(url: URL(string: "https://image.tmdb.org/t/p/w1280\(path)"))
                            .placeholder { Color.gray .frame(maxHeight: 200) }
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 200)
                    }
                    
                    HStack(spacing: 20) {
                        Text("Revenue: $\(details.revenue)")
                        Text("\(details.runtime) minutes")
                    }
                    .foregroundColor(.white)
                    .font(.caption.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 3) {
                        ForEach(movie.genres) { genre in
                            Text(genre.name)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 2)
                                .background(Color(genre.color))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
                Text(movie.overview)
                    .padding([.horizontal, .bottom])
                
                Group {
                    Text("Cast")
                        .font(.title)
                    ForEach(displayedCast) { person in
                        VStack(alignment: .leading) {
                            Text(person.name)
                                .font(.headline)
                            Text(person.character)
                        }
                        .padding(.bottom, 1)
                    }
                    if showingAllCast == false {
                        Button("Show All") {
                            withAnimation {
                                showingAllCast.toggle()
                            }
                        }
                        .padding(.vertical)
                    }
                    
                    Text("Crew")
                        .font(.title)
                    ForEach(displayedCrew) { person in
                        VStack(alignment: .leading) {
                            Text(person.name)
                                .font(.headline)
                            Text(person.job)
                        }
                        .padding(.bottom, 1)
                    }
                    if showingAllCrew == false {
                        Button("Show All") {
                            withAnimation {
                                showingAllCrew.toggle()
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}//End of Struct

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailsView(movie: Movie.example)
        }
    }
}
