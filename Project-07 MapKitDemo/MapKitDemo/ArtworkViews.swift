//
//  ArtworkViews.swift
//  MapKitDemo
//
//  Created by fengdaq on 2019/3/31.
//  Copyright © 2019 feng. All rights reserved.
//

import MapKit

class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let accessoryButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            accessoryButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: .normal)
            rightCalloutAccessoryView = accessoryButton
            if let imageName = artwork.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = artwork.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}


class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            markerTintColor = artwork.markerTintColor
//            glyphText = String(artwork.discipline.first!)
            if let imageName = artwork.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
}
