//
//  StationSectionHeader.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 7/17/21.
//

import Foundation
import UIKit

class StationSectionHeader: UICollectionReusableView {
    static let identifier = "StationSectionHeader"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Santo Domingo"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

