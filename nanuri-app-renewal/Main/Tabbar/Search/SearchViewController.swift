//
//  SearchViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit

class SearchViewController: UIViewController {
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    
    var filterButtonArray: [FilterButton] = []
    var filterCount = 6 + 1
    lazy var customSearchBar = UISearchBar()
    lazy var yellowBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewSetUp()
        self.title = "검색"
        let backButton = UIBarButtonItem(image: UIImage(named:"back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        // filter button
        for i in 0..<filterCount {
            let filterButton = FilterButton(filterType: i)
            filterButton.tag = i
            filterButton.isSelected = false
            filterButton.addTarget(self, action: #selector(selectFilterButton), for: .touchUpInside)
            filterButtonArray.append(filterButton)
        }
        
        setUpsearchView()
        
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectFilterButton(sender: UIButton) {
        print(sender.tag)
        for i in 0..<filterButtonArray.count {
            filterButtonArray[i].isSelected = false
        }
        
        filterButtonArray[sender.tag].isSelected = true
    }
    
    func viewSetUp() {
        self.view.addSubview(yellowBox)
        
        yellowBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
    }
    func setUpsearchView() {
        //self.view.backgroundColor = .white
        /* Search Bar */
        self.view.addSubview(customSearchBar)
        self.customSearchBar.searchBarStyle = .minimal
        customSearchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(348)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
        customSearchBar.placeholder = "검색어를 입력해주세요."
       
        
        
        
        
        let searchTableView = UITableView()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.separatorInset = .zero
        searchTableView.separatorStyle = .none
        searchTableView.sectionHeaderTopPadding = .zero
        searchTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(10)

            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        // 임시 주석 - 카테고리 뷰
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
        
        let filterScrollView = UIScrollView()
        filterScrollView.contentSize = CGSize(width: filterScrollView.frame.width, height: filterScrollView.frame.height)
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.clipsToBounds = true
        headerView.addSubview(filterScrollView)
        filterScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
            make.width.equalToSuperview()
            make.height.equalTo(35)
        }
        
        for i in 0..<filterButtonArray.count {
            filterScrollView.addSubview(filterButtonArray[i])
            if i != 0 {
                // 마지막 버튼일 때
                if i == filterButtonArray.count - 1 {
                    filterButtonArray[i].snp.makeConstraints { make in
                        make.left.equalTo(filterButtonArray[i - 1].snp.right).inset(-6)
                        make.right.equalToSuperview()
                    }
                } else { // 나머지 버튼
                    filterButtonArray[i].snp.makeConstraints { make in
                        make.left.equalTo(filterButtonArray[i - 1].snp.right).inset(-6)
                    }
                }
            } else { // 첫번째 버튼일 때
                filterButtonArray[i].snp.makeConstraints { make in
                    make.left.equalToSuperview().inset(16)
                }
            }
        }
       
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
    
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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


// 미리보기 기능 - Swift UI 빌려온 것

//#if DEBUG
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    
//func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//}
//@available(iOS 13.0.0, *)
//func makeUIViewController(context: Context) -> UIViewController{
//    SearchViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ViewControllerRepresentable()
//                .ignoresSafeArea()
//                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//        }
//        
//    }
//} #endif
