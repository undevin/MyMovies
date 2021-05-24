//
//  Formatters.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import Foundation

enum Formatters {
    static let movieDecoding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-m-d"
        return formatter
    }()
    
    static let movieDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        return formatter
    }()
}
