//
//  SlideAnimator.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 23/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

typealias animationBlock = () -> Void

class SlideAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    var fromVc : NSViewController! = nil;
    var toVc : NSViewController! = nil;
    var animations : [animationBlock]!
    
    override init() {
        
        super.init()
        
        self.animations = [self.fadeOut, self.slideLeft]

    }
    
    func  animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        self.fromVc = fromViewController;
        self.toVc = viewController;
        
        //Initial setup
        viewController.view.wantsLayer = true
        viewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
    
        
        self.animate()
        
    }
        
        
    func animate() {
        
        if (self.animations.count == 0) {
            
            return;
            
        }
        
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            
            self.animations.removeFirst()()
            
        }, completionHandler: self.animate)
        
    }
    
    func fadeOut () -> Void {
        
        NSAnimationContext.current().duration = 1
        self.fromVc.view.animator().alphaValue = 0
        
        
    }
    
    
    func slideLeft() -> Void {
        
        NSAnimationContext.current().duration = 0.5
        
        self.fromVc.view = self.toVc.view
        self.fromVc.view.frame.origin.x = self.fromVc.view.frame.size.width
        self.fromVc.view.alphaValue = 1
        self.fromVc.view.animator().frame.origin.x = 0

        
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        
    }


}
