//
//  SearchViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var customSearchBar = UISearchBar()
    lazy var yellowBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewSetUp()
        setUpView()
//        self.customSearchBar.searchBarStyle = .minimal
        // Do any additional setup after loading the view.
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbarController = TabBarController()
        tabbarController.modalTransitionStyle = .crossDissolve
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: false, completion: nil)
        
        
    }
    
    func viewSetUp() {
        self.view.addSubview(yellowBox)
        
        yellowBox.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
    }
    func setUpView() {
        //self.view.backgroundColor = .white
        /* Search Bar */
        self.view.addSubview(customSearchBar)
        self.customSearchBar.searchBarStyle = .minimal
        customSearchBar.snp.makeConstraints { make in
            make.width.equalTo(348)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
        customSearchBar.placeholder = "검색어를 입력해주세요."
        
        /* category stack view*/
        let categoryBtn = UIStackView()
        
        let testTag = DDayTagView(dDay: "10")
        self.view.addSubview(testTag)
        testTag.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(50)
        }
        
        let allRegionTableView = UITableView()
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
        allRegionTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(allRegionTableView)
        allRegionTableView.snp.makeConstraints { make in
            make.top.equalTo(customSearchBar.snp.bottom).offset(10)
            make.top.equalTo(testTag.snp.bottom).inset(-50)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        guard let _ = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            
            return cell
        }
      
        return UITableViewCell()
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
