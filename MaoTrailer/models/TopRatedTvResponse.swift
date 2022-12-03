//
//  TopRatedTvResponse.swift
//  MaoTrailer
//
//  Created by mohab on 12/3/22.
//

import Foundation

class TopRatedTvReponse :Codable{

    let page: Int?
    let results: [TvModel]?

    init( page: Int?, results: [TvModel]?) {
        self.page = page
        self.results = results
    }

}
