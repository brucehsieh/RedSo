//
//  ListViewController.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/18.
//

import UIKit
import SnapKit
import Reusable

class ListViewController: UIViewController {
    
    //MARK: - Property
    private let mainView = ListMainView()
    
    private let rows: [Row] = [.profile, .banner]
    
    private var results: [CatalogResponse.Result] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    private var refreshControl: UIRefreshControl!
    
    //MARK: - Function
    private func setTableView() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        mainView.tableView.addSubview(refreshControl)
    }
    
    @objc func updateData() {
        API.getData(team: "elastic", page: 0) { res, err in
            DispatchQueue.main.async {
                if let err = err {
                    print(err)
                    return
                }
                if let res = res {
                    self.mainView.tableView.reloadData()
                    self.refreshControl!.endRefreshing()
                }
            }
        }
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getCatalogResults()
        configureRefreshControl()
    }
    
    private func getCatalogResults() {
        API.getData(team: "elastic", page: 0) { res, err in
            DispatchQueue.main.async {
                if let err = err {
                    print(err)
                    return
                }
                if let res = res {
                    self.results += res.results
                }
            }
        }
    }
}

//MARK: - TableViewDataSource
extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        switch result.type {
        case "employee":
            let profileCell = tableView.dequeueReusableCell(for: indexPath, cellType: ProfileCell.self)
            profileCell.nameLabel.text = result.name
            profileCell.positionLabel.text = result.position
            if let expertise = result.expertise {
                profileCell.expertiseLabel.text = expertise.joined(separator: ", ")
            }
            if let url = URL(string: result.avatar!) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            profileCell.profileImageView.image = image
                        }
                    }
                }.resume()
            }
            return profileCell
            
        case "banner":
            let bannerCell = tableView.dequeueReusableCell(for: indexPath, cellType: BannerCell.self)
            if let url = URL(string: result.url!) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            bannerCell.bannerImageView.image = image
                            print("width:" + "\(image?.size.width)" + "height:" + "\(image?.size.height)")
                        }
                    }
                }.resume()
            }
            return bannerCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ListViewController: UITableViewDelegate{
    
}

extension ListViewController {
    enum Row: Int, CaseIterable{
        case profile = 0, banner
    }
}
