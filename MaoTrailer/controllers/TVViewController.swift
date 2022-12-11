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
    @IBOutlet weak var popularTvTabelView: UITableView!

    let tvTopRatedCellIdenitifer = "TopRatedTVCell"
    let popularTvCellIdenitifer = "PopularTVCell"

    let defaultLink = "https://image.tmdb.org/t/p/original"
    let tvTopRatedUrl = "https://api.themoviedb.org/3/tv/top_rated?api_key=04efb4789b6885a2f87e6bc96e26a9a4&language=en-US&page=1"
    let tvPopularUrl = "https://api.themoviedb.org/3/tv/popular?api_key=04efb4789b6885a2f87e6bc96e26a9a4&language=en-US&page=1"

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

        let link = defaultLink + (listOfTopRatedTv.results![indexPath.row].poster_path ?? "")
        cell.tvLabel.text = listOfTopRatedTv.results![indexPath.row].name
        cell.tvPosterImageView.downloaded(from: link)
        return cell
    }

    
}

extension TVViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPopularTv.results!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: popularTvCellIdenitifer, for: indexPath) as! PopularTvTableViewCell

        let link = defaultLink + (listOfPopularTv.results![indexPath.row].backdrop_path ?? "")

        cell.tvNameLabel.text = listOfPopularTv.results![indexPath.row].name

        cell.posterImageView.downloaded(from: link);
                return cell
    }

//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
//
//        return
//    }

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
       func getPopularTV(){
        AF.request(tvPopularUrl).responseDecodable(of: TopRatedTvReponse.self) { response in
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
