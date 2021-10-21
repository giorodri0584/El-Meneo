//
//  ViewController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/25/21.
//

import UIKit

class VideosController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    fileprivate var videos = [YoutubeVideo]()
    fileprivate var timer: Timer?
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Video"
        searchController.searchBar.delegate = self
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .always
        //navigationItem.title = "El Meneo"
        navigationItem.searchController = searchController
        collectionView.backgroundColor = .systemBackground
        collectionView.register(YoutubeViewCell.self, forCellWithReuseIdentifier: YoutubeViewCell.identifier)
        
        fetchYoutubeVideos()
    }
    
    fileprivate func filterVideos(searchTerm: String) {
        YoutubeVideosApiService.shared.searchVideos(searchTerm: searchTerm) { videos in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filterVideos(searchTerm: searchText)
        })
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterVideos(searchTerm: "")
    }
    fileprivate func fetchYoutubeVideos() {
        YoutubeVideosApiService.shared.fetchYoutubeVideos { videos, error in
            if let error = error {
                print("Error fetching videos: ", error)
            }
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YoutubeViewCell.identifier, for: indexPath) as! YoutubeViewCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.bounds.width * 0.56) + 64
        return CGSize(width: view.bounds.width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoDetailController = VideoDetailController()
        videoDetailController.video = videos[indexPath.item]
        videoDetailController.videos = videos
        navigationController?.pushViewController(videoDetailController, animated: true)
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

