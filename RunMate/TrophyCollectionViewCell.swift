//
//  TrophyCollectionViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 2/9/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class TrophyCollectionViewCell: UICollectionViewCell {
    
    var trophyImg: UIImageView
    var tropTest: UILabel
    
    override init(frame: CGRect) {
        trophyImg = UIImageView.init(frame: frame)
        tropTest = UILabel.init(frame: frame)//CGRect(x: 0, y: 0, width: 50, height: 10))//x:frame.x, y:frame.y, width: 50, height: 30))
        super.init(frame: frame)
        self.addSubview(trophyImg)
        self.addSubview(tropTest)
        //print("gottttum")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImage(trophyInformation:TrophyInformation){
      // if(trophyInformation.iOSImageName != "trophyImg1"){
        let image = UIImage.init(named: trophyInformation.iOSImageName)
        
        trophyImg.image = image
        print("printing image from \(trophyInformation.iOSImageName)")
       
        self.backgroundColor = UIColor.purpleColor()
       
        self.tropTest.text = "hello world"
        
        print(self.tropTest.text)
         }
           
}
