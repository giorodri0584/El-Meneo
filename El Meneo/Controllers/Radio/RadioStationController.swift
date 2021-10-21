//
//  RadioStationViewController.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 6/12/21.
//

import UIKit
import SDWebImage
import LNPopupController

//esto no es radio id 5057937

class RadioStationController: UICollectionViewController {
    let identifier = "RadioStationController"
    private var stations = [String:[Station]]()
    private let cities = ["Santiago", "Santo Domingo"]
    private var featured = [ShowSchedule]()
    
    
    init() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            if(sectionNumber == 0){
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.90), heightDimension: .estimated(250)), subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 16
                //section.contentInsets.leading = 10
                return section
            } else {
            
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)), subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 10
                section.contentInsets.trailing = 10
                section.contentInsets.bottom = 16
                
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
                let kind = UICollectionView.elementKindSectionHeader
                let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: kind, alignment: .topLeading)
                
                section.boundarySupplementaryItems = [headerElement]
                
                return section
            }
        }
        super.init(collectionViewLayout: layout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStations()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StationSectionHeader.identifier)
        collectionView.register(RadioStationCell.self, forCellWithReuseIdentifier: RadioStationCell.identifier)
        collectionView.register(RadioShowCell.self, forCellWithReuseIdentifier: RadioShowCell.identifier)
        
        
    }
    private func fetchFeatured() {
        featured = SampleShowSchedule.shared.getShowSchedules()
    }
    private func fetchStations () {
        StationApiService.shared.fetchStations() { [unowned self] stations, error in
            if let error = error {
                print(error.localizedDescription)
            }
            for city in self.cities {
                self.stations[city] = stations.filter{ $0.ciudad == city}
            }
            self.featured = SampleShowSchedule.shared.getShowSchedules()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                MusicPlayer.shared.loadStationList(stations: stations)
            }
            
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return featured.count
        case 1:
            let city = cities[0]
            return stations[city]?.count ?? 0
        case 2:
            let city = cities[1]
            return stations[city]?.count ?? 0
        default:
            return 0
        }
    }
    
    private func getStation(indexPath: IndexPath) -> Station {
        let city = cities[indexPath.section - 1]
        let tempStations: [Station] = stations[city] ?? []
        return tempStations[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadioShowCell.identifier, for: indexPath) as! RadioShowCell
            cell.radioShow = featured[indexPath.item]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadioStationCell.identifier, for: indexPath) as! RadioStationCell
            let station = self.getStation(indexPath: indexPath)
            cell.stationImageView.sd_setImage(with: station.logoUrl)
            
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StationSectionHeader.identifier, for: indexPath) as! StationSectionHeader
        
        switch indexPath.section {
        case 1:
                header.titleLabel.text = "Santiago"
        case 2:
            header.titleLabel.text = "Santo Domingo"
        default:
            header.titleLabel.text = "Extra Section"
        }
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let station = self.getStation(indexPath: indexPath)
            MusicPlayer.shared.playStation(with: station)
            //present(vc, animated: true, completion: nil)
            (tabBarController as! MainTabBarController).presentPlayerDetailsView()
            AdManager.shared.loadInterstitialAd(controller: self)
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct RadioStationViewController_Preview: PreviewProvider {
  static var previews: some View {
    ForEach(deviceNames, id: \.self) { deviceName in
      UIViewControllerPreview {
        RadioStationController()
      }.previewDevice(PreviewDevice(rawValue: deviceName))
        .previewDisplayName(deviceName)
    }
  }
}
#endif
