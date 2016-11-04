//
//  StateController.swift
//  CollegeFootball
//
//  Created by Kaj Schermer Didriksen on 07/10/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import UIKit


class StateController: JSONDownloadDelegate {
    
    var delegate: StateControllerDelegate?
    
    private(set) var eastPlayers = [Player]()
    private(set) var westPlayers = [Player]()
    
    func addEast(player: Player) {
        eastPlayers.append(player)
    }
    func addWest(player: Player) {
        westPlayers.append(player)
    }
    
    func updateImageEast(player: Int, image: UIImage){
        eastPlayers[player].image = image
    }
    
    func save() {
        
    }
    
    func getData() {
        _ = JSONDownload(urlPath: "http://collegebowl.avatarpro.biz/east", delegate: self)
        
    }
    
    func finishedDownloadingJSON(data: [Any]) {
        for player in data {
            if let player = player as? [String:Any],
                let name = player["name"] as? String,
                let college = player["college"] as? String,
                let imageURL = player["image"] as? String {
                let player = Player(name: name, college: college, imageURL: imageURL)
                addEast(player: player)
            }
        }
        delegate?.dataIsReady()
    }

}
