//
//  ViewController.swift
//  SuperchargeTV
//
//  Created by Breno Ramos on 14/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

struct Programme:Decodable{
    let title: String
    let end_date: String
    let start_date:String
}

struct Channel:Decodable{
    let id: Int
    let title: String
    let programme:Array<Programme>
}

struct ChannelList:Decodable{
    let channels: [Channel]
}

//use dependency injection later
var channels = ChannelList(channels: [Channel(id:1, title:"", programme: [Programme(title:"", end_date:"", start_date:"")])])

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //
    @IBOutlet weak var channelsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        jsonParse()
    }
    
    fileprivate func tableViewSetup() {
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
    }
    
    fileprivate func jsonParse() {
        //Download data - not working -> says that file doesnt exist
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
            print(channels)
            
            channels = decodedChannels
        }
        catch let err {
            print("error: " + err.localizedDescription)
        }
        
        self.channelsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = channelsTableView.dequeueReusableCell(withIdentifier: "channelCellID")
        cell?.textLabel?.text = channels.channels[indexPath.row].title
        
        print("Row: ",String(indexPath.row), cell?.textLabel?.text)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(indexPath.row + 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

