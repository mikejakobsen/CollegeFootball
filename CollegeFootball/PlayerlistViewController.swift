//
//  PlayerlistViewController.swift
//  CollegeFootball
//
//  Created by Kaj Schermer Didriksen on 07/10/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import UIKit

class PlayerlistViewController: UITableViewController, StateControllerDelegate {
    
    var stateController: StateController?

    override func viewDidLoad() {
        
    }
    
    
    func dataIsReady() {
            tableView.reloadData()
    }
    
}

extension PlayerlistViewController {
    
    // all my code for tableview delegate and data
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let stateController = stateController {
            return stateController.eastPlayers.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        
        if let player = stateController?.eastPlayers[indexPath.row] {
            
            cell.textLabel?.text = player.name
            cell.detailTextLabel?.text = player.college
            
            // images has to be downloaded so we check if it is downloaded
            // already. So we donwload async or display the already downloaded image
            
            // closure code so I remember the cell from the scope
            
            if player.image == nil {
                // we need to download the image
                if let imageURL = URL(string: player.imageURL) {
                    URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, URLResponse, error) in
                        
                        if error == nil {
                            if let data = data {
                                let image = UIImage(data: data)
                                if let image = image {
                                    // GUI has to be called on the main thread
                                    // since we are on a different thread we execute
                                    // the code via the main thread
                                    DispatchQueue.main.async {
                                        cell.imageView?.image = image
                                        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
                                    }
                                    // now update the array in the statecontroller
                                    self.stateController?.updateImageEast(player: indexPath.row, image: image)
                                }
                            }
                        }
                        
                    }).resume()
                }
            } else {
                // we have the image already
                cell.imageView?.image = player.image
            }
            
            
        }
        return cell
    }
    
}
