//
//  BannerCell.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import Reusable

class BannerCell: UITableViewCell, Reusable {
    
    //MARK: - UI
    
    let bannerImageView: CatchImageView = {
        let image = CatchImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
   //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
    }
}
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
}
