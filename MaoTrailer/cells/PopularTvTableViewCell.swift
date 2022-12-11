//
//  PopularTvTableViewCell.swift
//  MaoTrailer
//
//  Created by mohab on 12/5/22.
//

import UIKit

class PopularTvTableViewCell: UITableViewCell {

    @IBOutlet weak var tvNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        posterImageView.image = nil
    }

}
