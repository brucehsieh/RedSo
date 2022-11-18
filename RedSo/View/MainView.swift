//
//  MainView.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import SnapKit

class MainView: UIView {

    //MARK: - UI
    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Red"
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        return label
    }()
    
    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "So"
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = .red
        label.backgroundColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView  = UIStackView(arrangedSubviews: [leftTitleLabel, rightTitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Autolayout
    func setLayouts() {
        addSubview(titleStackView)
        titleStackView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(56)
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview()
        }
    }
}
