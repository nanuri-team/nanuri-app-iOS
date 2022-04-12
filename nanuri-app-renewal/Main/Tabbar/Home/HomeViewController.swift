//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {
    

    let headerScrollView = UIScrollView()
    
    var sampleImageViewArray: [UIImageView] = []
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈"
        
        setUpView()
    }
    
    
    //MARK: - Selector
    
    @objc func selectMoreButton() {
        let allRegionProductTableViewController = AllRegionProductTableViewController()
        allRegionProductTableViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(allRegionProductTableViewController, animated: true)
    }
    
    func setUpEventScrollView() {
        for _ in 0..<3 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "promotion_banner")
            sampleImageViewArray.append(imageView)
        }
        
        for i in 0..<sampleImageViewArray.count {
            headerScrollView.addSubview(sampleImageViewArray[i])
            
            if i == 0 {
                sampleImageViewArray[i].snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.left.equalToSuperview()
                }
            } else {
                if i == sampleImageViewArray.count - 1 {
                    sampleImageViewArray[i].snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.left.equalTo(sampleImageViewArray[i - 1].snp.right)
                        make.right.equalToSuperview()
                    }
                } else {
                    sampleImageViewArray[i].snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.left.equalTo(sampleImageViewArray[i - 1].snp.right)
                    }
                }
            }
        }
    }
    

    func setUpView() {
        self.view.backgroundColor = .white
        
        let headerView = UIView()
        let headerViewHeight = collectionCellHeight + 30 + 40 + 187 + 32
        headerView.frame = CGRect(x: 0, y: 0, width: Int(ratioWidth), height: headerViewHeight)
        
        headerScrollView.delegate = self
        headerScrollView.contentSize = CGSize(width: headerScrollView.frame.width, height: headerScrollView.frame.height)
        headerScrollView.isPagingEnabled = true
        headerView.addSubview(headerScrollView)
        headerScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(187)
        }
        setUpEventScrollView()
        
        let pagerView = UIView()
        pagerView.backgroundColor = .black.withAlphaComponent(0.4)
        pagerView.layer.cornerRadius = 18 / 2
        headerView.addSubview(pagerView)
        pagerView.snp.makeConstraints { make in
            make.bottom.equalTo(headerScrollView.snp.bottom).inset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(42)
            make.height.equalTo(18)
        }
        
        let eventTitleLabel = UILabel()
        eventTitleLabel.attributedText = NSAttributedString(string: "마감 임박 공구!")
        headerView.addSubview(eventTitleLabel)
        eventTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerScrollView.snp.bottom).inset(-32)
            make.right.left.equalToSuperview().inset(16)
        }
        
        let layout = UICollectionViewFlowLayout()
        let eventProductCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventProductCollectionView.delegate = self
        eventProductCollectionView.dataSource = self
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        eventProductCollectionView.register(VerticalProductCollectionViewCell.self, forCellWithReuseIdentifier: VerticalProductCollectionViewCell.cellId)
        headerView.addSubview(eventProductCollectionView)
        eventProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(eventTitleLabel.snp.bottom).inset(-10)
            make.width.equalTo(ratioWidth)
            make.height.equalTo(collectionCellHeight)
        }

        
        let allRegionTableView = UITableView()
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
        allRegionTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        allRegionTableView.tableHeaderView = headerView
        self.view.addSubview(allRegionTableView)
        allRegionTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        

    }

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
                return reuseCell
            } else {
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
                cell.selectionStyle = .none
                
                let allRegionTitleLabel = UILabel()
                allRegionTitleLabel.attributedText = NSAttributedString(string: "전체 지역의 상품")
                cell.contentView.addSubview(allRegionTitleLabel)
                allRegionTitleLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().inset(16)
                    make.top.equalToSuperview()
                }
                
                let moreButton = UIButton()
                moreButton.setAttributedTitle(NSAttributedString(string: "더보기"), for: .normal)
                cell.contentView.addSubview(moreButton)
                moreButton.snp.makeConstraints { make in
                    make.right.equalToSuperview().inset(16)
                    make.top.equalToSuperview()
                }
                moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)
                
                cell.contentView.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                }
                return cell
            }
        } else {
            let identifier = "\(indexPath.row)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            } else {
                let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            let productDetailViewController = ProductDetailViewController()
            productDetailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalProductCollectionViewCell.cellId, for: indexPath) as? VerticalProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}


//MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //
    }
}
