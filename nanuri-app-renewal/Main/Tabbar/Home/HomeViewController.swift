//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {

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
        
        let allRegionTableView = UITableView()
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
        allRegionTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
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
        
        guard let _ = tableView.dequeueReusableCell(withIdentifier: identifier) else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            
            return cell
        }
      
        return UITableViewCell()
    }
    
}
