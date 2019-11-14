//
//  ViewController.swift
//  StreamNASA
//
//  Created by Eduard Sinyakov on 11/13/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	var searchResponse: SearchResponse? = nil
	let networkService = NetworkService()
	var refreshControl = UIRefreshControl()
	var descriptionText = String()
	var descriptionImage = UIImage()
	var jsonDescriptionText = String()
    var urlToShared = String()

    var dvcImage = UIImage()


	override func viewDidLoad() {
		super.viewDidLoad()

		setupVC()
        setupRefresh()

	}
	override func viewDidAppear(_ animated: Bool) {
		networkService.request(urlString: urlString) { [weak self] (news) in
			switch news {

			case .success(let searchResponse):
				self?.searchResponse = searchResponse
				self?.collectionView.reloadData()
			 print(self?.searchResponse?.collection.items.count)
			 //print(self?.searchResponse?.collection.links.count)

			case .failure(let error):
				print("Ошибка \(error)")
			}
		}
	}

	func setupVC() {
		   collectionView.delegate = self
		   collectionView.dataSource = self



	   }

	   func setupRefresh() {
		   refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		   refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
		   collectionView.addSubview(refreshControl) // not required when using UITableViewController
	   }

	   @objc func refresh(sender:AnyObject) {
			  collectionView.reloadData()
			   refreshControl.endRefreshing()
		  }
}

// MARK: - UICollectionViewDelegate & DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


//searchResponse?.collection.items.count

		return searchResponse?.collection.items.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! NasaCell




		//let value = searchResponse?.collection.items[indexPath.row]
		//let prepareUrlToImage = value?.links?[indexPath.row]
		let urlToImage = ""
		//prepareUrlToImage?.href
		guard searchResponse?.collection.items[indexPath.row].data[indexPath.row].media_type == "image" else {return cell}
		guard let a = searchResponse?.collection.items[indexPath.row] else {return cell}
		print(a)

		guard a.data[indexPath.row].title != nil else {
			return cell
		}
		//guard let b = a.data[indexPath.row].title else {return cell}
		print(a.data[indexPath.row].title)
		//guard a.data[indexPath.row].title != nil else {return cell}
		//guard let b = a.data[indexPath.row].title else {return cell}
		//print(b)



		//cell.cellLabel.text = newTitle

	//print(newTitle)


		guard let url = URL(string: urlToImage ?? noImageAvaliable) else { return cell }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print(error)
                return
            }

            guard let data = data else {return}

            DispatchQueue.main.async {
                cell.cellImage.image = UIImage(data: data)
            }

        }

        task.resume()

        return cell
		
    }


    // MARK: - collectionView didSelectItemAt indexPath

  /*  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NasaCell
		let toData = searchResponse?.collection.items[indexPath.row]
		let toLinks = searchResponse?.collection.links[indexPath.row]
		let prepareTitle = toData?.data[indexPath.row]
		let prepareUrlToImage = toLinks?.href


		cell.cellLabel.text = prepareTitle?.title ?? "Description is empty 😱"
        cell.urlStringToShare = prepareUrlToImage ?? noImageAvaliable
        dvcImage = cell.cellImage.image ?? UIImage(named: "noImage")!
		jsonDescriptionText = cell.cellLabel.text ?? "Text is not avaliable"
        urlToShared = cell.urlStringToShare
        print(urlToShared)
        performSegue(withIdentifier: toDescription, sender: self)

    } */


  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDescription {
            let dvc = segue.destination as! DescriptionVC
            dvc.descriptionText = jsonDescriptionText
            dvc.descriptionImage = dvcImage
            print(urlToShared)
            dvc.urlStringToShared = urlToShared

        }
    } */
}
