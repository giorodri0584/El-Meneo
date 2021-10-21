//
//  PodcastViewController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 10/13/21.
//

import UIKit
import SnapKit
import SDWebImage

class PodcastViewController: UIViewController {
    private var podcasts = [Podcast]()
    var coordinator: PodcastCoordinator?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/2)), subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PodcastCell.self, forCellWithReuseIdentifier: PodcastCell.identifier)
        setupViews()
        loadPodcasts()
    }
    
    private func loadPodcasts() {
        self.podcasts = SamplePodcasts.shared.fetchPodcasts()
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class PodcastCell: UICollectionViewCell {
    static let identifier = "PodcastCell"
    var podcast: Podcast? {
        didSet {
            if let podcast = podcast {
                log.debug(podcast.title)
                featureImageView.sd_setImage(with: podcast.imageOriginalURL)
            }
        }
    }
    let featureImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gobierno")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        return iv
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = " EL Gobierno de la manana"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews() {
        addSubview(featureImageView)
        //addSubview(nameLabel)
        
        featureImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(featureImageView.snp_bottomMargin).offset(8)
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PodcastViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCell.identifier, for: indexPath) as! PodcastCell
        cell.podcast = podcasts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.navigatePodcastDetail(postcast: podcasts[indexPath.item])
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
@available(iOS 13.0, *)
struct PodcastViewController_Preview: PreviewProvider {
  static var previews: some View {
    ForEach(deviceNames, id: \.self) { deviceName in
      UIViewControllerPreview {
          PodcastViewController()
      }.previewDevice(PreviewDevice(rawValue: deviceName))
        .previewDisplayName(deviceName)
    }
  }
}
#endif

