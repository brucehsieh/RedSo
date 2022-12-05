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
    var rowHeights:[Int:CGFloat] = [:] //declaration of Dictionary
    var height: CGFloat = 0
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
                    self.results = res.results
                    self.refreshControl.endRefreshing()
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
            profileCell.profileImageView.getImage(result.avatar)
            print("profile")
            return profileCell
            
        case "banner":
            print("Calculating height..........................")
            let bannerCell = tableView.dequeueReusableCell(for: indexPath, cellType: BannerCell.self)
            bannerCell.bannerImageView.getImage(result.url) { image in
                guard let image = image else { return }
                let viewWidth = self.view.frame.width
                let ratio = image.size.height / image.size.width
                let height = viewWidth * ratio
                print("height: ", height)
                bannerCell.bannerImageView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                    make.height.equalTo(height)
                }
                tableView.beginUpdates()
                self.rowHeights[indexPath.row] = height
                tableView.endUpdates()
//                self.height = height
//                tableView.reloadData()
            }
            return bannerCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let result = results[indexPath.row]
        if let height = self.rowHeights[indexPath.row] {
            print("INdex: \(indexPath.row) : height \(height)")
            return height
        } else {
            print("INdex: \(indexPath.row) : auto height \(UITableView.automaticDimension)")
            return UITableView.automaticDimension
        }
        
//        switch result.type {
//        case "emplyee":
//            return UITableView.automaticDimension
//        case "banner":
//            return height
//        default:
//            return UITableView.automaticDimension
//        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.rowHeights[indexPath.row]{
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Index path row: \(indexPath.row)")
        print("ROWHEIGHTS DICT: \(self.rowHeights)")
    }
}

extension ListViewController: UITableViewDelegate{
    
}

extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let contentYOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        print("contentYOffset: \(contentYOffset)")
        if contentYOffset > contentHeight - height {
            API.getData(team: "elastic", page: 1) { res, err in
                DispatchQueue.main.async {
                    if let err = err {
                        print(err)
                        return
                    }
                    if let res = res {
                        self.results += res.results
                    }
                }
//
            }
        }
        
        print(scrollView.contentOffset.y)
    }}
