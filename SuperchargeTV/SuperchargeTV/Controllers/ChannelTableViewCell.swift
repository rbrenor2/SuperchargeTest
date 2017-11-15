//
//  ChannelTableViewCell.swift
//  SuperchargeTV
//
//  Created by Breno Ramos on 14/11/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var programmeCollectionView: UICollectionView!
    
    let dataManager = DataManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        programmeCollectionView.delegate   = self
        programmeCollectionView.dataSource = self
        
        //
        self.programmeCollectionView.backgroundColor = .darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dataManager.channelsList.channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = "programmeCellID"
        let cell = programmeCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProgrammeCollectionViewCell
        
        //set layout colors
        cell.backgroundColor = .darkGray
        cell.timeLabel.textColor = .white
        cell.titleLabel.textColor = .white
        
        //set the separator bar color
        let colorArray  = [UIColor.red, UIColor.white, UIColor.green, UIColor.yellow, UIColor.brown, UIColor.cyan, UIColor.blue]
        let randomIndex = Int(arc4random_uniform(UInt32(colorArray.count)))
        
        cell.separatorBar.backgroundColor = colorArray[randomIndex]
        
        //set titles
        let channel   = dataManager.channelsList.channels[self.tag]
        let programme = channel.programme[indexPath.row]
    
        cell.titleLabel.text = programme.title
    
        //set time label
        cell.timeLabel.text = decodeDate(startTime: programme.start_date, endTime: programme.end_date)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let channel = dataManager.channelsList.channels[self.tag]
        
        if channel.programme[indexPath.row] == nil{
            return CGSize(width: 366, height: 83)
        }else{
            let programme = channel.programme[indexPath.row]
            let duration  = getDuration(startTime: programme.start_date, endTime: programme.end_date)
            let newWidth  = 363 + CGFloat(duration/30)
            
            //duration for cell width
            let newSize = CGSize(width: newWidth, height: 83)
            
            return newSize
        }
    }
    
    //Decode start and end times of the programs
    func decodeDate(startTime:String, endTime:String) -> String {
        
        //set date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //get the hour:minute components
        let calendar        = Calendar.current
        let startDate       = dateFormatter.date(from: startTime)
        let componentsStart = calendar.dateComponents([.hour, .minute], from: startDate!)
        let hour            = componentsStart.hour
        let minute          = componentsStart.minute
        
        //getting time interval to adjust cells width
        let startString = String(hour!) + ":" + String(minute!)
        print(startString)
        
        return startString
    }
    
    func getDuration(startTime:String, endTime:String) -> Float {
        //set date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //get duration of programme
        let startDate = dateFormatter.date(from: startTime)
        let endDate   = dateFormatter.date(from: endTime)
        let duration  = endDate?.timeIntervalSince(startDate!)
        
        return Float(duration!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
