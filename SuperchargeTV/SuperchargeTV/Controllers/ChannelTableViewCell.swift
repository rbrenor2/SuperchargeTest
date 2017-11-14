//
//  ChannelTableViewCell.swift
//  SuperchargeTV
//
//  Created by Breno Ramos on 14/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var programmeCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        programmeCollectionView.delegate = self
        programmeCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = "programmeCellID"
        let cell = programmeCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProgrammeCollectionViewCell
        
        let channel: Channel = channels.channels[indexPath.row]
        let programme: Programme = channel.programme[indexPath.row]
        
        cell.titleLabel.text = programme.title
        
        //Couldn't get .dateFormatter to recognize the format
        //cell.timeLabel.text = decodeDate(startTime: programme.start_date, endTime: programme.end_date)
        
        return cell
    }
    
    //Decode start and end times of the programs
    func decodeDate(startTime:String, endTime:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        
        let startDate = dateFormatter.date(from: startTime)
        let endDate = dateFormatter.date(from: endTime)
        
        print(startDate)
        print(endDate)
        
        return (startDate?.description)!
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
