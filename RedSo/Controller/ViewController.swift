//
//  ViewController.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    //MARK: - Property
    let mainView = MainView()
    
    let dataStore = DataStore()
    
    private let rows: [Row] = [.profile, .banner]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorColor = .white
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        return tableView
    }()
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - AutoLayout
    
    func setLayouts() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainView.titleStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
        setTableView()
        setLayouts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

    //MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func configureProfileCell(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell()}
        cell.backgroundColor = .black
        return cell
    }
    
    private func configureBannerCell(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else { return UITableViewCell()}
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController {
    enum Row: Int, CaseIterable{
     case profile = 0, banner
    }
}
