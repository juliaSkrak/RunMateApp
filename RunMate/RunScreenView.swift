//
//  RunScreenView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import MapKit

protocol runScreenViewDelegate {
    func stopRun(testString: NSString)
}

class RunScreenView: UIView, MKMapViewDelegate{
    var speedLabel: UILabel
    var finishRunButton: UIButton
    var userRouteMapView: MKMapView
    var delegate: runScreenViewDelegate?
    var currentRunStatsView: CurrentRunStatsView
    var endView : UIView
    
    override init(frame: CGRect) {
        
        speedLabel = UILabel.init(frame: CGRect(origin: CGPoint(x: 20, y: 200), size: CGSize(width: 200, height: 30)))
        
        finishRunButton = UIButton.init(frame: CGRect(origin: CGPoint(x:(frame.width / 2) - (76 / 2), y:frame.height - 100), size: CGSize(width: 76, height: 76)))
        var stopImage = UIImage(named: "stopbutton")
        finishRunButton.setImage(stopImage, forState: .Normal)
        userRouteMapView = MKMapView.init(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.4))
        
        currentRunStatsView = CurrentRunStatsView.init(frame: CGRect(x: 0.0, y: frame.height * 0.4, width: frame.width, height: frame.height * 0.35))
        currentRunStatsView.backgroundColor = UIColor.grayColor()
        //currentRunStatsView =
        
        endView = UIView.init(frame: frame)
        endView.backgroundColor = UIColor.whiteColor()
        super.init(frame: frame)
        
        finishRunButton.addTarget(self, action: "stopRun:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(finishRunButton)
        self.addSubview(speedLabel)
        self.addSubview(userRouteMapView)
        self.addSubview(currentRunStatsView)
        self.backgroundColor = UIColor.whiteColor()
        userRouteMapView.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setMapCoordinates(coord: MKCoordinateRegion){
         userRouteMapView.setRegion(coord, animated: false)
    }

    func stopRun(sender:AnyObject){
        print("run stopping")
        self.addSubview(endView)
        delegate?.stopRun("just stawwwp")
    }

    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay.isKindOfClass(MKPolyline) {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.greenColor()
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        }
        
        return nil
    }


}
