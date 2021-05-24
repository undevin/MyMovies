//
//  Credits.swift
//  MyMovies
//
//  Created by Devin on 5/23/21.
//

import Foundation

struct Credits: Decodable {
    let cast: [CastMember]
    let crew: [CrewMember]
}//End of Struct

struct CastMember: Decodable, Identifiable {
    var id: String { creditId }
    let creditId: String
    let name: String
    let character: String
    let profilePath: String?
}//End of Struct

struct CrewMember: Decodable, Identifiable {
    var id: String { creditId }
    let creditId: String
    let name: String
    let job: String
    let profilePath: String?
}//End of Struct
