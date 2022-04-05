//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {
    
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈"
        
        setUpView()
    }
    

    func setUpView() {
        self.view.backgroundColor = .white
        
        let testTag = DDayTagView(dDay: "10")
        self.view.addSubview(testTag)
        testTag.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(50)
        }
        
        let layout = UICollectionViewFlowLayout()
        let eventProductCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventProductCollectionView.frame = CGRect(x: 0, y: 0, width: Int(ratioWidth), height: collectionCellHeight)
        eventProductCollectionView.delegate = self
        eventProductCollectionView.dataSource = self
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        eventProductCollectionView.register(VerticalProductCollectionViewCell.self, forCellWithReuseIdentifier: VerticalProductCollectionViewCell.cellId)


        
        let allRegionTableView = UITableView()
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
        allRegionTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        allRegionTableView.tableHeaderView = eventProductCollectionView
        self.view.addSubview(allRegionTableView)
        allRegionTableView.snp.makeConstraints { make in
            make.top.equalTo(testTag.snp.bottom).inset(-50)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        

    }

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            
            return cell
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
}
