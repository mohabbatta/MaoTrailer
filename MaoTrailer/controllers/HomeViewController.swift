//
//  HomeViewController.swift
//  MaoTrailer
//
//  Created by mohab on 9/19/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HomeViewController: UIViewController {
    var listOfNowMovies: NowMoviesResponse = NowMoviesResponse(date: NowDates(max: "22", min: "22"), page: 0, results: [])
    var listOfPopularMovies :PopularMoviesResponse = PopularMoviesResponse(page: 0, results: [])

    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var nowCollectionView: UICollectionView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!

    let nowCollectionIdentefier = "NowMoviesCell"
    let PopularCollectionIdentefier = "popularCollectionCell"
    let SliderCollectionIdentefier = "sliderCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNowMovies()
        getPopularMovies()
        nowCollectionView.dataSource = self
        popularCollectionView.dataSource = self
        sliderCollectionView.dataSource = self
        }
    }



extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.nowCollectionView {
            return listOfNowMovies.results!.count
        }else if collectionView == self.sliderCollectionView{
            return 2
        }
        else {
            return listOfPopularMovies.results!.count

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.nowCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nowCollectionIdentefier, for: indexPath) as! NowMoviesCollectionViewCell

            let url = URL(string: ApiPaths.imagePath + (listOfNowMovies.results![indexPath.row].poster_path ?? ""))
            cell.imageView.kf.setImage(with: url)
            cell.lable.text = listOfNowMovies.results![indexPath.row].title
            return cell
        } else if collectionView == self.sliderCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionIdentefier, for: indexPath) as! SliderCollectionViewCell
            cell.sliderImageView.image = UIImage(named: "slider")
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionIdentefier, for: indexPath) as! PopularMoviesCollectionCell

            let url = URL(string: ApiPaths.imagePath + (listOfPopularMovies.results![indexPath.row].poster_path ?? ""))
            cell.movieTitleLabel.text = listOfPopularMovies.results![indexPath.row].title
            cell.posterImageView.kf.setImage(with: url)
            return cell
        }

    }
}

extension HomeViewController {

    func getNowMovies(){
        AF.request(ApiPaths.nowUrl).responseDecodable(of: NowMoviesResponse.self) { response in
            switch response.result{
            case .success(_):
                self.listOfNowMovies = response.value!
                DispatchQueue.main.async {
                    self.nowCollectionView.reloadData()
                }
            case .failure(_):
                print("failed")

            }
        }

    }
       func getPopularMovies(){
           AF.request(ApiPaths.popularUrl).responseDecodable(of: PopularMoviesResponse.self) { response in
            switch response.result{
            case .success(_):
                self.listOfPopularMovies = response.value!
                DispatchQueue.main.async {
                    self.popularCollectionView.reloadData()
                }
            case .failure(_):
                print("failed")

            }
        }

    }

}
