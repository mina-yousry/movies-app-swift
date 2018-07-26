//
//  CurvedUIImageView.swift
//  MoviesApp
//
//  Created by Mina  on 7/25/18.
//  Copyright © 2018 Mina . All rights reserved.
//

import UIKit

// this is a class to make curved UIImageView
@IBDesignable
class CurvedUIImageView: UIImageView {
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    //setting the shape of the mask to be applied on the image
    func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath
    {
        let arrowPath = UIBezierPath()
        
        arrowPath.move(to: CGPoint(x:0, y:0))
        
        arrowPath.addLine(to: CGPoint(x:screenWidth, y:0))
        
        arrowPath.addLine(to: CGPoint(x:screenWidth, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:screenWidth/2, y:givenView.bounds.size.height))
        
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        
        arrowPath.close()
        
        return arrowPath
    }
    
    //applying the mask to the image 
    @IBInspectable var curvedPercent : CGFloat = 0{
        didSet{
            guard curvedPercent <= 1 && curvedPercent >= 0 else{
                return
            }
            
            let shapeLayer = CAShapeLayer(layer: self.layer)
            shapeLayer.path = self.pathCurvedForView(givenView: self,curvedPercent: curvedPercent).cgPath
            shapeLayer.frame = self.bounds
            shapeLayer.masksToBounds = true
            self.layer.mask = shapeLayer
        }
    }

}
