//
//  Spinner.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 21/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

enum AnimationType : String {
    case ScaleUp = "scaleUp"
    case ScaleDown = "scaleDown"
}

class WaveIndicator : NSView, CAAnimationDelegate {
    
    private var elements : Dictionary<CALayer, [CAAnimationGroup]> = [:]
    private var color = NSColor(red:0/255.0, green:255/255.0, blue:200/255.0, alpha: 1)
    private let amount = 10;
    private let stroke : CGFloat = 5.0
    private let step : CGFloat = 10.0
    private let delay : CFTimeInterval = 0.05
    private let speed : CFTimeInterval = 0.5
    private let resize : Double = 1.2
    private let fov : Double = Double.pi / 1.5
    
    
    override func awakeFromNib() {
        
        self.wantsLayer = true;
        
        
        self.wave()
        
    }
    
    private func wave() {
        
        self.layer!.sublayers = []
        
        self.elements = self.createElements(amount: amount);
        
        for (layer, _) in elements {
            
            //Add the layer
            self.layer!.addSublayer(layer)
            
        }
        
        for (layer, animations) in self.elements {
            
            //Add the first animation
            layer.add(animations.first!, forKey: nil);
            layer.add(animations.last!, forKey: nil);
            
        }
        
    }
    
    private func createElements(amount : Int) -> Dictionary<CALayer, [CAAnimationGroup]> {
        
        var result : Dictionary<CALayer, [CAAnimationGroup]> = [:]
    
        for i in 0..<amount {
            
            let alpha : CGFloat = CGFloat(i + 1) / CGFloat(amount);
            
            let delay : CFTimeInterval = CFTimeInterval(i) * self.delay
            
            let start = Double.pi / 2 - self.fov / 2;
            
            //Correct the alpha
            self.color = self.color.withAlphaComponent(alpha)
            
            let layer = self.createArcLayer(radius: self.step * CGFloat(i + 1), start: start, end: start + self.fov , clockwise: false);
            
            let scaleUp = self.createWaveAnimation(from: 1, to: self.resize, duration: self.speed, delay: delay)
            scaleUp.setValue("up#\(i)", forKey: "id")
            
            let scaleDown = self.createWaveAnimation(from: self.resize, to: 1, duration: self.speed,  delay: self.speed + delay)
            scaleDown.setValue("down#\(i)", forKey: "id")

            result[layer] = [scaleUp, scaleDown];
            
            
        }
        
        return result;
    
    }
    
    private func createArcLayer(radius : CGFloat, start : Double, end : Double, clockwise : Bool) -> CALayer {
        
        let layer = CAShapeLayer()
        let center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let path = CGMutablePath()
        
        //Create the path
        path.addArc(center: center, radius: radius, startAngle: CGFloat(start) , endAngle: CGFloat(end), clockwise: clockwise)
        
        //Build the layer
        layer.frame = self.bounds;
        layer.path = path;
        layer.fillColor     = NSColor(calibratedWhite: 1, alpha: 0).cgColor;
        layer.strokeColor   = self.color.cgColor
        layer.lineWidth     = self.stroke;
        layer.lineCap       = kCALineCapRound
        
        return layer;
        
    }
    
    private func createWaveAnimation(from : Double, to : Double, duration : CFTimeInterval, delay : CFTimeInterval) -> CAAnimationGroup {
        
        let scaleX = CABasicAnimation(keyPath: "transform.scale.x");
        let scaleY = CABasicAnimation(keyPath: "transform.scale.y");
        let group = CAAnimationGroup()
        
        
        //Define the amount of the scale up
        scaleX.fromValue = from;
        scaleY.fromValue = from;
        
        scaleX.toValue = to;
        scaleY.toValue = to;
        
        //Build the animation group
        group.animations = [scaleX, scaleY]
        group.duration = duration;
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        group.delegate = self;
        group.beginTime = CACurrentMediaTime() + delay
        
        group.isRemovedOnCompletion = true
        
        return group;
        
    }

    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if (flag && anim.value(forKey: "id") != nil && (anim.value(forKey: "id") as! String) == "down#\(amount - 1)") {
            
            self.wave()
            
        }
    }
    
}
