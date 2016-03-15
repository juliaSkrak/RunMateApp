//
//  RunHistoryTableViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 3/7/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import MapKit

class RunHistoryTableViewCell: UITableViewCell {  //ok so i really tried to make the runhisotry view cell the same as the previous run view, but thats really unessesary and buggy (views resizing).  Also the benifits of using a tableview is lost when there is only one cell always in view.  TODO:: test how this works with autolayout
    
    var runStatsLabel: UILabel
    var mapView: MKMapView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        mapView = MKMapView.init()
        runStatsLabel = UILabel.init()
        runStatsLabel.backgroundColor = UIColor.purpleColor()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mapView = MKMapView.init(frame: CGRect(x: 0, y: 70, width: frame.width, height: frame.width))
        runStatsLabel = UILabel.init(frame: CGRect(x: 16.0, y: frame.width + 70 , width: frame.width - 32, height: 100))
         
        self.addSubview(mapView)
        self.addSubview(runStatsLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
