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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataManager = DataManager()
    @IBOutlet weak var channelsTableView: UITableView!
    var channels = ChannelList(channels: [Channel(id:1, title:"", programme: [Programme(title:"", end_date:"", start_date:"")])])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        jsonParse()
    }
    
    fileprivate func tableViewSetup() {
        channelsTableView.backgroundColor = .black
        channelsTableView.delegate        = self
        channelsTableView.dataSource      = self
    }
    
    fileprivate func jsonParse() {
        self.channels = self.dataManager.channelsList
        self.channelsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = channelsTableView.dequeueReusableCell(withIdentifier: "channelCellID")
        cell?.textLabel?.text      = self.channels.channels[indexPath.row].title
        cell?.tag                  = indexPath.row
        cell?.backgroundColor      = .black
        cell?.textLabel?.textColor = .lightGray
        
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

