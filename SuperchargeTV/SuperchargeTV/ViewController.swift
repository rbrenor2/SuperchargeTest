//
//  ViewController.swift
//  SuperchargeTV
//
//  Created by Breno Ramos on 14/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

struct Programme:Decodable{
    let title: String?
    let end_date: String?
    let start_date:String?
}

struct Channel:Decodable{
    let id: Int?
    let title: String?
    let programme:Array<Programme>?
}

struct ChannelList:Decodable{
    let channels: [Channel]?
}

class ViewController: UIViewController {
    
    var channels: ChannelList = ChannelList(channels: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonParse()
    }
    
    fileprivate func jsonParse() {
        //Download data - not working -> file doesnt exist
        //let jsonPath = "https://gist.githubusercontent.com/reden87/0fa57b0f4b3f16efa52b553359c29832/raw/c1730ad581526f3fe75aba1cab64f12fc8e2c66b/SuperTV.json"
        let jsonLocalPath = "SuperTV.json"
        
        //let url = URL(fileURLWithPath: jsonPath)
        let localUrl = URL(fileReferenceLiteralResourceName: jsonLocalPath)
        
        do {
            //Download Data
            let jsonData = try Data(contentsOf: localUrl)
            print(jsonData)
            
            //Parse Data
            let channels = try JSONDecoder().decode(ChannelList.self, from: jsonData)
            print(channels)
            
            self.channels = channels
        }
         catch let err {
            print("error: " + err.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

