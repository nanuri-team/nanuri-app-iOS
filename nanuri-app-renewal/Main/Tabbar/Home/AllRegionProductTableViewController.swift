//
//  AllRegionProductTableViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/07.
//

import UIKit

class AllRegionProductTableViewController: UITableViewController {
    
    var postsListArray: [ResultInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "전체 지역 상품"
        self.tableView.dataSource = self

        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        
        self.getPostsList()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getPostsList() {
        Networking.sharedObject.getPostsList { response in
            self.postsListArray = response.results
            self.tableView.reloadData()
        } 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = postsListArray[indexPath.row]
        
        let identifier = "\(indexPath.row) \(post.uuid)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            cell.productImage.imageUpload(url: post.image?.replaceImageUrl() ?? "")
            cell.productName.attributedText = .attributeFont(font: .PRegular, size: 17, text: post.title, lineHeight: 20)
            cell.productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: post.writerAddress ?? "", lineHeight: 14)
            cell.productPrice.attributedText = .attributeFont(font: .PBold, size: 16, text: "\(post.unitPrice.toPriceNumberFormmat())원", lineHeight: 19)
            cell.productPrice.textAlignment = .right
            cell.deliveryTagView.setDeliveryType(type: post.tradeType)
            
            cell.dDayTagView.setDday(dDay: post.waitedUntil?.dDaycalculator() ?? "")
            cell.totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/\(post.maxParticipants)", lineHeight: 14)
            cell.productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(post.numParticipants)", lineHeight: 14)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.postInfo = postsListArray[indexPath.row]
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
