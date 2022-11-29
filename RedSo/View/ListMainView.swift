//
//  ListMainView.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import SnapKit
import Reusable

class ListMainView: UIView {

    //MARK: - UI
    private func createTitleLabel(text: String, _ textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = textColor
        return label
    }
    
    private lazy var titleStackView: UIStackView = {
        let leftTitleLabel = createTitleLabel(text: "Red", .red)
        let rightTitleLabel = createTitleLabel(text: "So", .white)
        let stackView  = UIStackView(arrangedSubviews: [leftTitleLabel, rightTitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = .white
        tableView.register(cellType: BannerCell.self)
        tableView.register(cellType: ProfileCell.self)
        return tableView
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
    private func setLayouts() {
        addSubview(titleStackView)
        titleStackView.snp.makeConstraints{ make in
            make.top.equalTo(56)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualTo(0)
        }
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
