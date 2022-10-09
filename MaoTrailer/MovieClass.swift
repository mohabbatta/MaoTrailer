//
//  MovieClass.swift
//  MaoTrailer
//
//  Created by mohab on 9/25/22.
//

import Foundation
import SwiftyJSON

class MovieClass {

    let totalResults: Int?
    let page: Int?

    init(totalResults: Int?, page: Int?) {
        self.totalResults = totalResults
        self.page = page
    }

    init(_ json: JSON) {
        self.totalResults = json["total_results"].intValue
        self.page = json["page"].intValue
    }
    
}
