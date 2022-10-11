//
//  popularMoviesResponse.swift
//  MaoTrailer
//
//  Created by mohab on 10/11/22.
//

import Foundation
class PopularMoviesResponse :Codable{

    let page: Int?
    let results: [Movie]?

    init( page: Int?, results: [Movie]?) {
        self.page = page
        self.results = results
    }

}


