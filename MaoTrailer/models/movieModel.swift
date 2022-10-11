//
//  movieModel.swift
//  MaoTrailer
//
//  Created by mohab on 10/11/22.
//

import Foundation

class Movie :Codable{
    let poster_path: String?
    let title: String?
    let original_language: String?
    //original_language

    init(imagePath: String?, title: String?, originalLanguage: String?) {
        self.poster_path = imagePath
        self.title = title
        self.original_language = originalLanguage
    }
}
