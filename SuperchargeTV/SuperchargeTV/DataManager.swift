//
//  DataManager.swift
//  SuperchargeTV
//
//  Created by Breno Ramos on 14/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    override init() {
        self.channelsList = ChannelList(channels: [Channel(id:1, title:"", programme: [Programme(title:"", end_date:"", start_date:"")])])
        super.init()
        self.parseData()
    }
    
    var channelsList:ChannelList
    
    func parseData() {
        
        /*Download data - not working -> says that file doesnt exist
          So I downloaded the file and used a localPath*/
        
        //let jsonPath = "https://gist.githubusercontent.com/reden87/0fa57b0f4b3f16efa52b553359c29832/raw/c1730ad581526f3fe75aba1cab64f12fc8e2c66b/SuperTV.json"
        
        let jsonLocalPath = "SuperTV.json"
        
        //let url = URL(fileURLWithPath: jsonPath)
        let localUrl = URL(fileReferenceLiteralResourceName: jsonLocalPath)
        
        do {
            //Download Data
            let jsonData = try Data(contentsOf: localUrl)
            print(jsonData)
            
            //Parse Data
            let decodedChannels = try JSONDecoder().decode(ChannelList.self, from: jsonData)
            print(decodedChannels)
            
            self.channelsList = decodedChannels
        }
        catch let err {
            print("error: " + err.localizedDescription)
        }
    }
}
