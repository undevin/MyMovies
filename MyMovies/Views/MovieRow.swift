//
//  MovieRow.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var image: some View {
        Group {
            if let path = movie.posterPath {
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w342\(path)"))
                    .placeholder(Image("Loading").resizable())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 90)
            } else {
                Image("NoPoster")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 90)
            }
        }
    }
    
    var body: some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            HStack {
                image
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title2)
                    
                    HStack {
                        Text("Rating: \(movie.voteAverage, specifier: "%g")/10")
                        Text(movie.formattedReleaseDate)
                    }
                    .font(.subheadline)
                    
                    Text(movie.overview)
                        .lineLimit(2)
                        .font(.body.italic())
                }
            }
        }
    }
}//End of Struct

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieRow(movie: Movie.example)
        }
    }
}
