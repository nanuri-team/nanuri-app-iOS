//
//  SearchViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit

class SearchViewController: UIViewController {
    
    var customSearchBar = UISearchBar()
    let searchView = UIView()
    let searchButton = UIButton()
    
    let emptyNotiView: EmptyNotiView = {
        let view = EmptyNotiView()
        return view
    }()
    
    let tableView = UITableView()
    
    var resultOfProductList: [ResultInfo] = []
    
    private let numberOfListLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PBold, size: 13, text: "전체 10개", lineHeight: 15)
        return label
    }()
    
    var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
//    let list: [CategoryItem] = CategoryItem
//    typealias Item = CategoryItem
    let categorylist: [String] = ["ALL", "#생활용품", "#음식", "#주방", "#욕실", "#문구", "#기타"]
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getProduct()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = true
        
        self.title = "검색"
        let backButton = UIBarButtonItem(image: UIImage(named:"back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        /* Search Bar */
        searchView.backgroundColor = .nanuriGray1
        searchView.layer.borderColor = UIColor.nanuriGray3.cgColor
        searchView.layer.borderWidth = 1
        searchView.layer.cornerRadius = 24
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .nanuriGray3
        searchButton.setPreferredSymbolConfiguration(.init(pointSize: 22), forImageIn: .normal)
        searchButton.setTitleColor(.nanuriGray3, for: .normal)
        searchButton.isEnabled = false
        searchView.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.width.height.equalTo(30)
        }
        
        customSearchBar.delegate = self
        searchView.addSubview(customSearchBar)
        customSearchBar.placeholder = "검색어를 입력해주세요."
        customSearchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        customSearchBar.searchTextField.backgroundColor = .clear
        customSearchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        customSearchBar.searchTextField.clearButtonMode = .never
        customSearchBar.searchTextField.font = UIFont.systemFont(ofSize: 15)
        self.customSearchBar.searchBarStyle = .minimal
        customSearchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
        }
       
        // collectionView - category
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//        collectionView.backgroundColor = .nanuriLightGreen
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return nil }
            cell.configure(text: self.categorylist[indexPath.item])
            if indexPath.item == 0 {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.isSelected = true
                cell.cellview.backgroundColor = .nanuriGreen
                cell.categoryName.textColor = .white
            }
            return cell
        })
                
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(categorylist, toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = collectionViewLayout()
        
        // tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = .zero
        tableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 검색 결과가 없을때
        tableView.addSubview(emptyNotiView)
        emptyNotiView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        emptyNotiView.emptyLabel.text = "검색 결과가 없습니다"
        emptyNotiView.emptyDescriptionLabel.text = "다른 카테고리를 선택하거나,\n검색어를 바꾸어주세요."
//        emptyNotiView.emptyImageView.image = UIImage(systemName: "")
        
        // 화면 아무 곳이나 클릭시 키보드 사라지게 하는 코드
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(45), heightDimension: .absolute(28))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(3), heightDimension: .absolute(28))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc func selectMoreButton() {
        print("Continued..")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultOfProductList.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.addSubview(numberOfListLabel)
        numberOfListLabel.snp.makeConstraints { make in
            make.bottom.equalTo(headerView.snp.bottom).offset(-5)
            make.left.equalTo(16)
        }
        
        let moreButton = UIButton()
        moreButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: " 진행 중인 상품", lineHeight: 13), for: .normal)
        moreButton.setImage(UIImage(named: "down_arrow_ic"), for: .normal)
        moreButton.setTitleColor(.nanuriGray4, for: .normal)
        moreButton.semanticContentAttribute = .forceLeftToRight
        headerView.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.bottom.equalTo(headerView.snp.bottom).offset(-5)
            $0.right.equalTo(-16)
        }
        moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let post = resultOfProductList[indexPath.row]
            let identifier = "\(indexPath.row) \(post.uuid)"
            
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            
            cell.selectionStyle = .none
            
            cell.productImage.imageUpload(url: post.image?.replaceImageUrl() ?? "")
            cell.productName.attributedText = .attributeFont(font: .PRegular, size: 17, text: post.title, lineHeight: 20)
            cell.productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: post.writerAddress ?? "", lineHeight: 14)
            cell.productPrice.attributedText = .attributeFont(font: .PBold, size: 16, text: "\(post.unitPrice.toPriceNumberFormmat())원", lineHeight: 19)
            cell.productPrice.textAlignment = .right
            cell.deliveryTagView.setDeliveryType(type: post.tradeType ?? "")
            
            cell.dDayTagView.setDday(dDay: post.waitedUntil?.dDaycalculator() ?? "")
            cell.totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/\(post.maxParticipants)", lineHeight: 14)
            cell.productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(post.numParticipants)", lineHeight: 14)
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.postInfo = resultOfProductList[indexPath.row]
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
    
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return }
        print("--> \(categorylist[indexPath.item])")
        switch indexPath.item {
        case 0:
            getProduct()
        case 1:
            let category = "?category=HOUSEHOLD"
            getProduct(category: category)
        case 2:
            let category = "?category=FOOD"
            getProduct(category: category)
        case 3:
            let category = "?category=KITCHEN"
            getProduct(category: category)
        case 4:
            let category = "?category=BATHROOM"
            getProduct(category: category)
        case 5:
            let category = "?category=STATIONARY"
            getProduct(category: category)
        case 6:
            let category = "?category=ETC"
            getProduct(category: category)
        default:
            ()
        }
    }
    
    func getProduct(category: String? = nil) {
        NetworkService.shared.getProductListRequest(at: category) { productList in
            print("전체 \(productList.results.count)개")
            self.resultOfProductList = []
            for product in productList.results {
                self.resultOfProductList.append(product)
            }
            
            DispatchQueue.main.async {
                if self.resultOfProductList.count == 0 {
                    self.emptyNotiView.isHidden = false
                } else {
                    self.emptyNotiView.isHidden = true
                }
                
                self.numberOfListLabel.text = "전체 \(self.resultOfProductList.count)개"
                
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    // 서치바의 편집을 시작할때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView.layer.borderColor = UIColor.nanuriGreen.cgColor
        searchView.layer.shadowOpacity = 0.15
        searchView.layer.shadowOffset = .zero
        searchButton.tintColor = .nanuriGreen
    }
    
    // 키보드의 Search 버튼을 클릭했을때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchView.layer.borderColor = UIColor.nanuriGray3.cgColor
        searchView.layer.shadowOpacity = 0
        searchButton.tintColor = .nanuriGray3
        
        guard let keyword = searchBar.text else { return }
        print("result -> \(keyword)")
    }
    
    // 서치바의 편집이 끝났을때
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchView.layer.borderColor = UIColor.nanuriGray3.cgColor
        searchView.layer.shadowOpacity = 0
        searchButton.tintColor = .nanuriGray3
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
