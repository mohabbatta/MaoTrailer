//
//  TvModel.swift
//  MaoTrailer
//
//  Created by mohab on 12/3/22.
//

import Foundation

class TvModel :Codable{
    let poster_path: String?
    let backdrop_path: String?
    let name: String?
    let original_language: String?
    //original_language

    init(imagePath: String?, name: String?, originalLanguage: String?,backdrop_path: String?) {
        self.poster_path = imagePath
        self.backdrop_path = backdrop_path
        self.name = name
        self.original_language = originalLanguage
    }
}
