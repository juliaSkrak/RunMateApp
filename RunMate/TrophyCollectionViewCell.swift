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
    
    
    override init(frame: CGRect) {
        trophyImg = UIImageView.init(frame: frame)

        super.init(frame: frame)
        self.addSubview(trophyImg)
        //print("gottttum")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setImage(trophyInformation:TrophyInformation){
        var image = UIImage.init()
        if (trophyInformation.imageName != nil && trophyInformation.imageName != "") {
            image = UIImage.init(named: trophyInformation.imageName)!
            
        } else {
            image = UIImage.init(named: self.addTrophyImageName(trophyInformation))!
        }
        
        trophyImg.image = image
        print("printing image from \(trophyInformation.imageName)")
        
        print(trophyInformation.completed!)
        if(trophyInformation.completed! != 1){
            trophyImg.alpha = 0.5
        } else {
            trophyImg.alpha = 1
        }
    }
    
    func addTrophyImageName(trophInfo: TrophyInformation) -> String {
        let trophyImageName = "trophyImg" + String(arc4random_uniform(10) + 1)
        trophInfo.imageName = trophyImageName
       // image = UIImage.init(named: trophInfo.imageName)!
        trophInfo.saveInBackground()
        return trophyImageName
    }
    
}
