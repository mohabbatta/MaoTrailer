//
//  TVViewController.swift
//  MaoTrailer
//
//  Created by mohab on 12/3/22.
//

import UIKit
import Alamofire

class TVViewController: UIViewController {

    @IBOutlet weak var topRatedCollectionView: UICollectionView!

    let tvTopRatedCellIdenitifer = "TopRatedTVCell"

    let defaultLink = "https://image.tmdb.org/t/p/original"
    let tvTopRatedUrl = "https://api.themoviedb.org/3/tv/top_rated?api_key=04efb4789b6885a2f87e6bc96e26a9a4&language=en-US&page=1"

    var listOfTopRatedTv :TopRatedTvReponse = TopRatedTvReponse(page: 0, results: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopRatedTV()
        topRatedCollectionView.dataSource = self
    }

}

extension TVViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTopRatedTv.results!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tvTopRatedCellIdenitifer, for: indexPath) as! TVTopRatedCollectionViewCell

        let link = defaultLink + (listOfTopRatedTv.results![indexPath.row].poster_path ?? "")
        cell.tvLabel.text = listOfTopRatedTv.results![indexPath.row].name
        cell.tvPosterImageView.downloaded(from: link)
        return cell
    }

    
}
extension TVViewController {

    func getTopRatedTV(){
        AF.request(tvTopRatedUrl).responseDecodable(of: TopRatedTvReponse.self) { response in
            switch response.result{
            case .success(_):
                self.listOfTopRatedTv = response.value!
                DispatchQueue.main.async {
                    self.topRatedCollectionView.reloadData()
                }
            case .failure(_):
                print("failed")

            }
        }

    }
//       func getPopularMovies(){
//        AF.request(popularUrl).responseDecodable(of: PopularMoviesResponse.self) { response in
//            switch response.result{
//            case .success(_):
//                self.listOfPopularMovies = response.value!
//                DispatchQueue.main.async {
//                    self.popularCollectionView.reloadData()
//                }
//            case .failure(_):
//                print("failed")
//
//            }
//        }
//
//    }

}
