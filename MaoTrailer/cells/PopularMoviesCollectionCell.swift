//
//  PopularMoviesCollectionCell.swift
//  MaoTrailer
//
//  Created by mohab on 10/4/22.
//

import UIKit

class PopularMoviesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

}
