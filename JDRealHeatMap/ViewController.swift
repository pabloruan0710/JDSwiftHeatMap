//
//  ViewController.swift
//  JDRealHeatMap
//
//  Created by 郭介騵 on 2017/6/12.
//  Copyright © 2017年 james12345. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var map:JDRealHeatMap?
    var testpointCoor = [CLLocationCoordinate2D(latitude: 27, longitude: 120),CLLocationCoordinate2D(latitude: 25.3, longitude: 119),CLLocationCoordinate2D(latitude: 27, longitude: 120),
        CLLocationCoordinate2D(latitude: 27, longitude: 121)
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addRandomData()
        //map = JDRealHeatMap(frame: self.view.frame, delegate: self, maptype: .RadiusBlurry,BasicColors: [UIColor.yellow,UIColor.red], devideLevel: 1)
        map = JDRealHeatMap(frame: self.view.frame, delegate: self, maptype: .FlatDistinct)
        self.view.addSubview(map!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRandomData()
    {
        for i in 0..<20
        {
            let loti:Double = Double(119) + Double(Float(arc4random()) / Float(UINT32_MAX))
            let lati:Double = Double(25 + arc4random_uniform(4)) + 2 * Double(Float(arc4random()) / Float(UINT32_MAX))
            testpointCoor.append(CLLocationCoordinate2D(latitude: lati, longitude: loti))
        }
    }
}

extension ViewController:MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let heatoverlay = map?.heatmapView(mapView, rendererFor: overlay)
        {
            return heatoverlay
        }
        else
        {
            return MKOverlayRenderer()
        }
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        map?.heatmapViewWillStartRenderingMap(mapView)
    }
}

extension ViewController:JDHeatMapDelegate
{
    func heatmap(HeatPointCount heatmap:JDRealHeatMap) -> Int
    {
        return testpointCoor.count
    }
    
    func heatmap(HeatLevelFor index:Int) -> Int
    {
        return 1 + index
    }
    
    func heatmap(RadiusInKMFor index: Int) -> Double {
        return Double(20 + index * 2)
    }
    
    func heatmap(CoordinateFor index:Int) -> CLLocationCoordinate2D
    {
        return testpointCoor[index]
    }
}
