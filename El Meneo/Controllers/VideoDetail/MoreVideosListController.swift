//
//  MoreVideosListController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 6/5/21.
//

import UIKit
import SnapKit

class MoreVideosListController: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var videos: [YoutubeVideo]
    var controller: UINavigationController
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        //cv.backgroundColor = .red
        cv.register(YoutubeViewCell.self, forCellWithReuseIdentifier: YoutubeViewCell.identifier)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    required init(videos: [YoutubeVideo], controller: UINavigationController) {
        self.videos = videos
        self.controller = controller
        super.init(frame: .zero)
        addSubview(collectionView)
                collectionView.snp.makeConstraints { make in
                    make.size.equalToSuperview()
                }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YoutubeViewCell.identifier, for: indexPath) as! YoutubeViewCell
        cell.video = videos[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.collectionView.frame.width * 0.56) + 64
        return CGSize(width: self.collectionView.frame.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoDetailController = VideoDetailController()
        videoDetailController.video = videos[indexPath.item]
        videoDetailController.videos = videos
        
        var vcArray = controller.viewControllers
        vcArray.removeLast()
        vcArray.append(videoDetailController)
        controller.setViewControllers(vcArray, animated: false)
    
    }
}
