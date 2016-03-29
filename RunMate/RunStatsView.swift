//
//  RunStatsView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import MapKit



protocol runStatsDelegate {
    func closeWindow(testString: NSString)
}

class RunStatsView: UIView, MKMapViewDelegate { //can be used as a popup over runview or in a scrollview with a lot of them as like a total run history
    
    var locationView: UILabel
    var exitButton:UIButton
    var runCongratutationsLabel:UILabel
    var runStatsLabel: UILabel
    var mapView: MKMapView
    var lineSegments: [MKPolyline]
    var coordinateArray: [CLLocationCoordinate2D]
    

    
    var delegate: runStatsDelegate?
    
    override init(frame: CGRect) {
        locationView = UILabel.init(frame: frame)
    
        exitButton = UIButton.init(type: UIButtonType.RoundedRect)
        exitButton.frame = CGRect(x: frame.origin.x + 10, y: frame.size.height - 100, width: frame.size.width-20, height: 30)
        exitButton.setTitle("close window", forState: UIControlState.Normal)
        exitButton.backgroundColor = UIColor.blackColor()
        
        mapView = MKMapView.init(frame: CGRect(x: 0, y: 70, width: frame.width, height: frame.width))
        
        runCongratutationsLabel = UILabel.init(frame:CGRect(x: 16, y: 16, width: frame.width-32, height: 64))
       
        runStatsLabel = UILabel.init(frame: CGRect(x: 16.0, y: frame.width + 70 , width: frame.width - 32, height: 100))
        
        runStatsLabel.backgroundColor = UIColor.purpleColor()
        
        lineSegments = [MKPolyline]()
        
        coordinateArray = [CLLocationCoordinate2D]()
        
    
        
        super.init(frame: frame)
        
        self.addSubview(locationView)
        self.addSubview(runCongratutationsLabel)
        self.addSubview(mapView)
        self.addSubview(runStatsLabel)
        self.backgroundColor = UIColor.orangeColor()
        self.setStats([], runNum: 23, distance: 10.3)
        mapView.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, setButton:Bool){
        //print("convienient!!")
        self.init(frame: frame)
        if setButton {
            self.addSubview(exitButton)
            exitButton.addTarget(self, action: "closeStatsWindow:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func closeStatsWindow(sender:AnyObject){
        delegate?.closeWindow("heyooo")
    }
    
    func setStats(var locations:[RunLocation], runNum: NSNumber, distance:NSNumber){
        self.mapView.removeOverlays(lineSegments)
        let onesPlace = runNum.integerValue % 10
        switch(onesPlace){
            case 1:
                runCongratutationsLabel.text = "Congratulations on your \(runNum)st run!!!"
            case 2:
                runCongratutationsLabel.text = "Congratulations on your \(runNum)nd run!!!"
            case 3:
                runCongratutationsLabel.text = "Congratulations on your \(runNum)rd run!!!"
            default:
                runCongratutationsLabel.text = "Congratulations on your \(runNum)th run!!!"
        }
        runStatsLabel.text = "You ran \(distance.doubleValue / 1609.34) meters!"
        
        locations = locations.sort({Double($0.timestamp) < Double($1.timestamp)})
        
        for location in locations {
            print(location.timestamp)
        }
        
        if let initialLoc = locations.first{
            var minLat = initialLoc.latitude.doubleValue
            var minLng = initialLoc.longitude.doubleValue
            var maxLat = minLat
            var maxLng = minLng
            
            
             print(coordinateArray)
            for location in locations {
                coordinateArray.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude)))
                minLat = min(minLat, location.latitude.doubleValue)
                minLng = min(minLng, location.longitude.doubleValue)
                maxLat = max(maxLat, location.latitude.doubleValue)
                maxLng = max(maxLng, location.longitude.doubleValue)
               
            }
        
            var coord = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
                    longitude: (minLng + maxLng)/2),
                span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.1,
                longitudeDelta: (maxLng - minLng)*1.1))
            mapView.setRegion(coord, animated: true)
            
            self.drawMyLine()
            print(lineSegments)
            mapView.addOverlays(lineSegments)
        }
    }
    
    func drawMyLine(){
        print(coordinateArray)
        for i in 1...coordinateArray.count-1{
            let pointA = coordinateArray[i-1]
            let pointB = coordinateArray[i]
            
            var lineBetween = [MKMapPointForCoordinate(pointA), MKMapPointForCoordinate(pointB)]
           // var myPoint = UnsafeMutablePointer<MKMapPoint>()
            //myPoint = &lineBetween.first
            let segment = MKPolyline(points: &lineBetween, count: 2)
            lineSegments.append(segment)
        }
    }
    
    

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay.isKindOfClass(MKPolyline) {
            // draw the track
            let polyLine = overlay
            let polyLineRenderer = MKPolylineRenderer(overlay: polyLine)
            polyLineRenderer.strokeColor = UIColor.blueColor()
            polyLineRenderer.lineWidth = 2.0
            
            return polyLineRenderer
        }
        
        return nil
    }

}
