//
//  ProfileCell.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import Reusable
import SnapKit

class ProfileCell: UITableViewCell, Reusable {
    
    //MARK: - UI
    // 要改三個 label
    private static func createProfileLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }
    
    let nameLabel = createProfileLabel(text: "name")
    let positionLabel = createProfileLabel(text: "position")
    let expertiseLabel = createProfileLabel(text: "expertise")
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - AutoLayout
    private func setLayouts() {
        let labelStackView = UIStackView(arrangedSubviews: [
            nameLabel, positionLabel, expertiseLabel
        ])
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        let mainStackView = UIStackView(arrangedSubviews: [
            profileImageView, labelStackView
        ])
        mainStackView.spacing = 8
        mainStackView.alignment = .center
        contentView.addSubview(mainStackView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        mainStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(8)
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Init
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
        self.backgroundColor = .black
        profileImageView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
