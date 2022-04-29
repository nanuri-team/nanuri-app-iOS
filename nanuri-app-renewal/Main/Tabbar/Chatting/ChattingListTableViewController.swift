//
//  ChattingTableViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class ChattingListTableViewController: UITableViewController {
    
    var chatDummyPostList: [ResultInfo] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "채팅"

        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        
        getDummyPost()
    }
    
    func getDummyPost() {
        Networking.sharedObject.getPostsList { response in
            self.chatDummyPostList = []
            for i in 0..<3 {
                self.chatDummyPostList.append(response.results[i])
            }
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
        return chatDummyPostList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatDummyPost = chatDummyPostList[indexPath.row]
        let identifier = "\(indexPath.row) \(chatDummyPost.uuid)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = ChattingListTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            cell.productImageView.imageUpload(url: chatDummyPost.image ?? "")
            cell.productName.attributedText = .attributeFont(font: .PBold, size: 13, text: chatDummyPost.title, lineHeight: 15)
            cell.deliveryTag.setDeliveryType(type: DeliveryType.parcel)
            cell.chatPeopleLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(chatDummyPost.numParticipants)", lineHeight: 14)
            cell.productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: chatDummyPost.writerAddress ?? "", lineHeight: 14)


            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chattingViewController = ChattingViewController()
        chattingViewController.roomName = chatDummyPostList[indexPath.row].uuid
        chattingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chattingViewController, animated: true)
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
