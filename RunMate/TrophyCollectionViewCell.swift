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
      // if(trophyInformation.iOSImageName != "trophyImg1"){
        let image = UIImage.init(named: trophyInformation.imageName)
        
        trophyImg.image = image
        print("printing image from \(trophyInformation.imageName)")
        
        print(trophyInformation.completed!)
        if(trophyInformation.completed! != 1){
            trophyImg.alpha = 0.5
        } else {
            trophyImg.alpha = 1
        }
    }
           
}
