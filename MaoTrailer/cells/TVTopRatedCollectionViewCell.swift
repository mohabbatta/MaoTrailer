//
//  TVTopRatedCollectionViewCell.swift
//  MaoTrailer
//
//  Created by mohab on 12/3/22.
//

import UIKit

class TVTopRatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvLabel: UILabel!
    @IBOutlet weak var tvPosterImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        tvPosterImageView.image = nil
    }
}
