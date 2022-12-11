//
//  TVViewController.swift
//  MaoTrailer
//
//  Created by mohab on 12/3/22.
//

import UIKit
import Alamofire
import Kingfisher


class TVViewController: UIViewController {

    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var popularTvTabelView: UITableView!

    let tvTopRatedCellIdenitifer = "TopRatedTVCell"
    let popularTvCellIdenitifer = "PopularTVCell"

    var listOfTopRatedTv :TopRatedTvReponse = TopRatedTvReponse(page: 0, results: [])
    var listOfPopularTv :TopRatedTvReponse = TopRatedTvReponse(page: 0, results: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        getTopRatedTV()
        getPopularTV()
        self.popularTvTabelView.rowHeight = 180
        topRatedCollectionView.dataSource = self
        popularTvTabelView.dataSource = self
    }

}

extension TVViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfTopRatedTv.results!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tvTopRatedCellIdenitifer, for: indexPath) as! TVTopRatedCollectionViewCell
        let url = URL(string: ApiPaths.imagePath + (listOfTopRatedTv.results![indexPath.row].poster_path ?? ""))
        cell.tvPosterImageView.kf.setImage(with: url)
        cell.tvLabel.text = listOfTopRatedTv.results![indexPath.row].name
        return cell
    }

    
}

extension TVViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPopularTv.results!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: popularTvCellIdenitifer, for: indexPath) as! PopularTvTableViewCell
        let url = URL(string: ApiPaths.imagePath + (listOfPopularTv.results![indexPath.row].backdrop_path ?? ""))
        cell.tvNameLabel.text = listOfPopularTv.results![indexPath.row].name
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
}


extension TVViewController {

    func getTopRatedTV(){
        AF.request(ApiPaths.tvTopRatedUrl).responseDecodable(of: TopRatedTvReponse.self) { response in
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
       func getPopularTV(){
           AF.request(ApiPaths.tvPopularUrl).responseDecodable(of: TopRatedTvReponse.self) { response in
            switch response.result{
            case .success(_):
                self.listOfPopularTv = response.value!
                DispatchQueue.main.async {
                    self.popularTvTabelView.reloadData()
                }
            case .failure(_):
                print("failed")

            }
        }

    }

}
