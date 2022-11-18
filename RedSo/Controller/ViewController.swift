//
//  ViewController.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Property
    let mainView = MainView()
    
    private let rows: [Row] = [.profile, .banner]
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.identifier)
        return tableView
    }()
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
        setTableView()
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
        switch rows[indexPath.row] {
        case .profile: return configureProfileCell(tableView, cellForRowAt: indexPath)
        case .banner: return configureBannerCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func configureProfileCell(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell()}
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
