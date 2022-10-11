//
//  NowMoviesResponse.swift
//  MaoTrailer
//
//  Created by mohab on 9/25/22.
//

import Foundation

class NowMoviesResponse :Codable{

    let dates: NowDates?
    let page: Int?
    let results: [Movie]?

    init(date: NowDates?, page: Int?, results: [Movie]?) {
        self.dates = date
        self.page = page
        self.results = results
    }

}


class NowDates :Codable {
    let maximum: String?
    let minimum: String?

    init(max: String?, min: String?) {
        self.maximum = max
        self.minimum = min
    }
}

