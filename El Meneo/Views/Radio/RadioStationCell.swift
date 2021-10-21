//
//  RadioStationCell.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 6/12/21.
//

import UIKit
import SnapKit

class RadioStationCell: UICollectionViewCell {
    static let identifier = "RadioStationCell"
    let logoViewHolder: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5.0

        view.backgroundColor = UIColor(named: "surface")
        // Set masksToBounds to false, otherwise the shadow
        // will be clipped and will not appear outside of
        // the view’s frame
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    let stationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //backgroundColor = .systemBlue
        addSubview(logoViewHolder)
        logoViewHolder.addSubview(stationImageView)
        
        logoViewHolder.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stationImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
