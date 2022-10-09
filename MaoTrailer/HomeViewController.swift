//
//  HomeViewController.swift
//  MaoTrailer
//
//  Created by mohab on 9/19/22.
//

import UIKit
import Alamofire
import SwiftyJSON

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class HomeViewController: UIViewController {
    var names = ["mohab", "ahmed", "ali", "mohamed"]
    var listOfNowMovies: NowMoviesResponse = NowMoviesResponse(date: NowDates(max: "22", min: "22"), page: 0, results: [])

    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var nowCollectionView: UICollectionView!

    let nowCollectionIdentefier = "NowMoviesCell"
    let PopularCollectionIdentefier = "popularCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        nowCollectionView.dataSource = self
        popularCollectionView.dataSource = self

    }
    let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=04efb4789b6885a2f87e6bc96e26a9a4&language=en-US&page=1"


    func getInfo(){
        print("start getting data")
        AF.request(url).responseDecodable(of: NowMoviesResponse.self) { response in
            switch response.result{
            case .success(_):
                self.listOfNowMovies = response.value!
                DispatchQueue.main.async {
                    self.nowCollectionView.reloadData()
                }
                print(response.value?.results as Any)
            case .failure(_):
                print("failed")

            }
        }

    }
//    @IBAction func getData(_ sender: Any) {
//        print("start getting data")
//        AF.request(url).responseDecodable(of: NowMoviesResponse.self) { response in
//            switch response.result{
//            case .success(_):
//                print(response.value?.results as Any)
//            case .failure(_):
//                print("failed")
//
//            }
//        }
//
////        AF.request(url,method: .get).responseJSON { (response) in
////            switch response.result {
////            case .success(_):
////                guard let data = response.data else {return}
////
////                do{
////                    let cats = try JSONDecoder().decode(NowMoviesResponse.self, from: data)
////
////                    print(cats.page!, cats.results?[0].original_language! as Any, cats.dates?.minimum! as Any)
////                }catch{
////                    print(error.localizedDescription)
////                }
////            case .failure(_):
////                print(response.error as Any)
////
////            }
////        }
//
//        }
    }



extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.nowCollectionView {
            return listOfNowMovies.results!.count
        } else {
            return names.count

        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.nowCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: nowCollectionIdentefier, for: indexPath) as! NowMoviesCollectionViewCell

            let defaultLink = "https://image.tmdb.org/t/p/original"
            let link = defaultLink + (listOfNowMovies.results![indexPath.row].poster_path ?? "")
            cell.lable.text = listOfNowMovies.results![indexPath.row].title
            cell.imageView.downloaded(from: link)

            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionIdentefier, for: indexPath) as! PopularMoviesCollectionCell

            cell.movieTitleLabel.text = names[indexPath.row]

            return cell
        }

    }
}

