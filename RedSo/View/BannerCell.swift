//
//  BannerCell.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit

class BannerCell: UITableViewCell {

    static let identifier = "bannerCell"
    
    //MARK: - UI
    
    let banner: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
   //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
