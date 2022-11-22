//
//  ProfileCell.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit

class ProfileCell: UITableViewCell {
    static let identifier = "profilecell"
    
    //MARK: - UI
    let label: UILabel = {
        let label = UILabel()
        return label
    }()

    let profilePic: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    //MARK: - Init
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
