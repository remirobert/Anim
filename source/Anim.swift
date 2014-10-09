//
//  Animation.swift
//  Animation
//
//  Created by Remi Robert on 08/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit

enum Repeat {
    case Count(Int)
    case Infinity
}

enum AnimationType {
    case Bounce(Float)
    case Position(CGPoint)
    case Resize(CGSize)
    case Rotation(Float)
    case RotationY(Float)
    case RotationX(Float)
    case RotationZ(Float)
    case Fade(Float)
    case BorderRaduis(Float)
    case Sequence(([Animation]))
    case Repeat((Int, Animation))
    case MoveCircle(CGRect)
    case None
}

class Animation: NSObject {
    private var type: AnimationType = .None
    private var delay: NSTimeInterval = 0.5
    private var blockCompletion: (() -> ())?
    private var countAnimation: Int = 0
    private var animationsList: [Animation]? = nil

    //MARK: Bounce
    class func bounce(value: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.Bounce(value)
        return animation
    }
    
    class func bounce(value: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.Bounce(value)
        return animation
    }

    //MARK: Move Position
    class func movePosition(position: CGPoint) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.Position(position)
        return animation
    }
    
    class func movePosition(position: CGPoint, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.Position(position)
        return animation
    }
    
    //MARK: Resize Frame
    class func resizeFrame(resize: CGSize) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.Resize(resize)
        return animation
    }
    
    class func resizeFrame(resize: CGSize, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.Resize(resize)
        return animation
    }
    
    //MARK: Rotation Frame
    class func rotation(angle: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.Rotation(angle)
        return animation
    }
    
    class func rotation(angle: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.Rotation(angle)
        return animation
    }
    
    //MARK: 3D Rotation Y
    class func rotationY(rotation: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.RotationY(rotation)
        return animation
    }

    class func rotationY(rotation: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.RotationY(rotation)
        return animation
    }

    //MARK: 3D Rotation X
    class func rotationX(rotation: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.RotationX(rotation)
        return animation
    }
    
    class func rotationX(rotation: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.RotationX(rotation)
        return animation
    }
    
    //MARK: 3D Rotation Z
    class func rotationZ(rotation: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.RotationZ(rotation)
        return animation
    }
    
    class func rotationZ(rotation: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.RotationZ(rotation)
        return animation
    }
    
    //MARK: Fade
    class func fade(pourcent: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.Fade(pourcent)
        return animation
    }
    
    class func fade(pourcent: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.Fade(pourcent)
        return animation
    }
    
    //MARK: Border Raduis
    class func borderRaduis(angle: Float) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.BorderRaduis(angle)
        return animation
    }
    
    class func borderRaduis(angle: Float, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.BorderRaduis(angle)
        return animation
    }

    //MARK: sequence Animations
    class func sequenceAnimations(animations: [Animation]) -> Animation {
        let animation = Animation()

        animation.type = AnimationType.Sequence(animations)
        return animation
    }
    
    //MARK: repeat Animations
    class func repeatAnimations(count: Repeat, animationParam: Animation) -> Animation {
        let animation = Animation()
        
        switch count {
        case .Count(let value):
            animation.type = AnimationType.Repeat((value, animationParam))
        case .Infinity:
            animation.type = AnimationType.Repeat((-1, animationParam))
        }
        return animation
    }
    
    //MARK: Move arround circle
    class func moveCircle(frameCircle: CGRect) -> Animation {
        let animation = Animation()
        
        animation.type = AnimationType.MoveCircle(frameCircle)
        return animation
    }
    
    class func moveCircle(frameCircle: CGRect, delay: NSTimeInterval) -> Animation {
        let animation = Animation()
        
        animation.delay = delay
        animation.type = AnimationType.MoveCircle(frameCircle)
        return animation
    }
    
    private func createAnimation(pathAnimation: String, delay: NSTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: pathAnimation)
        
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.delegate = self
        animation.duration = delay
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        return animation
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        blockCompletion?()
    }
    
    private func runBounce(layer:CALayer, value:Float, blockCompletion: (() -> ())?) {
        println("call bounce \(self.delay) and \(value)")
        if value <= 3 {
            if let block = blockCompletion {
                block()
            }
            return Void()
        }
        UIView.animateWithDuration(self.delay, animations: { () -> Void in
            layer.frame = CGRectMake(layer.frame.origin.x - CGFloat(value / 2), layer.frame.origin.y - CGFloat(value / 2),
                layer.frame.size.width + CGFloat(value),
                layer.frame.size.height + CGFloat(value))
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(self.delay, animations: { () -> Void in
                    layer.frame = CGRectMake(layer.frame.origin.x + CGFloat(value / 2), layer.frame.origin.y + CGFloat(value / 2),
                        layer.frame.size.width - CGFloat(value),
                        layer.frame.size.height - CGFloat(value))
                    }, completion: { (Bool) -> Void in
                        self.runBounce(layer, value: value / 2, blockCompletion: blockCompletion)
                })
        }
    }
    
    private func runMovePosition(layer: CALayer, position: CGPoint, blockCompletion: (() -> ())?) {
        println("call here")
        UIView.animateWithDuration(self.delay, animations: { () -> Void in
            layer.frame = CGRectMake(position.x, position.y, layer.frame.size.width, layer.frame.size.height)
        }) { (Bool) -> Void in
            if let block = blockCompletion {
                block()
            }
        }
    }
    
    private func runResize(layer: CALayer, resize: CGSize, blockCompletion: (() -> ())?) {
        UIView.animateWithDuration(self.delay, animations: { () -> Void in
            layer.frame = CGRectMake(layer.frame.origin.x, layer.frame.origin.y,
                resize.width, resize.height)
        }) { (Bool) -> Void in
            if let block = blockCompletion {
                block()
            }
        }
    }
    
    private func runRotation(layer:CALayer, rotation: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("transform.rotation", delay: self.delay)
        
        animation.fromValue = 0
        if let currentLayer: AnyObject = layer.presentationLayer() {
            animation.fromValue = Float(currentLayer.valueForKeyPath("transform.rotation") as NSNumber)
        }
        
        self.blockCompletion = blockCompletion
        animation.toValue = rotation + Float(animation.fromValue as NSNumber)
        layer.addAnimation(animation, forKey: "rotation")
    }
    
    private func runRotationY(layer: CALayer, y: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("transform.rotation.y", delay: self.delay)
        var rotation = CATransform3DIdentity
        
        animation.fromValue = 0
        if let currentLayer: AnyObject = layer.presentationLayer() {
           animation.fromValue = Float(currentLayer.valueForKeyPath("transform.rotation.y") as NSNumber)
        }

        self.blockCompletion = blockCompletion
        rotation.m34 = 1.0 / 500.0
        animation.toValue = y + Float(animation.fromValue as NSNumber)
        layer.addAnimation(animation, forKey: "rotationY")
        layer.transform = rotation
    }

    private func runRotationX(layer: CALayer, x: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("transform.rotation.x", delay: self.delay)
        var rotation = CATransform3DIdentity
        
        animation.fromValue = 0
        if let currentLayer: AnyObject = layer.presentationLayer() {
            animation.fromValue = Float(currentLayer.valueForKeyPath("transform.rotation.x") as NSNumber)
        }

        self.blockCompletion = blockCompletion
        rotation.m34 = 1.0 / 500.0
        animation.toValue = x + Float(animation.fromValue as NSNumber)
        layer.addAnimation(animation, forKey: "rotationX")
        layer.transform = rotation
    }
    
    private func runRotationZ(layer: CALayer, z: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("transform.rotation.z", delay: self.delay)
        var rotation = CATransform3DIdentity
        
        animation.fromValue = 0
        if let currentLayer: AnyObject = layer.presentationLayer() {
            animation.fromValue = Float(currentLayer.valueForKeyPath("transform.rotation.z") as NSNumber)
        }
        
        self.blockCompletion = blockCompletion
        rotation.m34 = 1.0 / 500.0
        animation.toValue = z + Float(animation.fromValue as NSNumber)
        layer.addAnimation(animation, forKey: "rotationZ")
        layer.transform = rotation
    }
    
    private func runFade(layer: CALayer, pourcent: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("opacity", delay: self.delay)
        
        self.blockCompletion = blockCompletion
        animation.toValue = pourcent
        layer.addAnimation(animation, forKey: "fade")
    }
    
    private func runBorderRaduis(layer: CALayer, angle: Float, blockCompletion: (() -> ())?) {
        let animation = createAnimation("cornerRadius", delay: self.delay)
        
        self.blockCompletion = blockCompletion
        animation.toValue = 15.0
        animation.fromValue = layer.cornerRadius
        layer.addAnimation(animation, forKey: "angleRaduis")
    }
    
    private func runMoveCircle(layer: CALayer, frameCircle: CGRect, blockCompletion: (() -> ())?) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        self.blockCompletion = blockCompletion
        
        animation.path = CGPathCreateWithEllipseInRect(frameCircle, nil)
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.delegate = self
        animation.duration = delay
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

        animation.additive = true;
        animation.calculationMode = kCAAnimationPaced;
        animation.rotationMode = kCAAnimationRotateAuto;
        layer.addAnimation(animation, forKey: "moveCircle")
    }
    
    private func execAnimationSequence(layer:CALayer) {
        if self.countAnimation >= self.animationsList?.count {
            self.blockCompletion?()
            return Void()
        }
        
        let currentAnimation = self.animationsList?[self.countAnimation]
        
        currentAnimation?.runAnimation(layer, blockCompletion: { () -> () in
            println("current Time action : \(currentAnimation?.delay)")
            self.countAnimation += 1
            self.execAnimationSequence(layer)
        })
    }
    
    private func runSequenceAnimation(layer: CALayer, animations: [Animation], blockCompletion: (() -> ())?) {
        self.blockCompletion = blockCompletion
        self.countAnimation = 0
        self.animationsList = animations
        self.execAnimationSequence(layer)
    }
    
    
    private func runRepeatAnimation(layer: CALayer, count: Int, animation: Animation, blockCompletion: (() -> ())?) {
        if count == 0 {
            blockCompletion?()
            return Void()
        }
        animation.runAnimation(layer, blockCompletion: { () -> () in
            self.runRepeatAnimation(layer, count: count - 1, animation: animation, blockCompletion: blockCompletion)
        })
    }
    
    private func runAnimation(layer: CALayer, blockCompletion: (() -> ())?) {
        switch self.type {
        case .Bounce(let value):
            self.runBounce(layer, value: value, blockCompletion: blockCompletion)
        case .Position(let value):
            self.runMovePosition(layer, position: value, blockCompletion: blockCompletion)
        case .Resize(let value):
            self.runResize(layer, resize: value, blockCompletion: blockCompletion)
        case .Rotation(let value):
            self.runRotation(layer, rotation: value, blockCompletion: blockCompletion)
        case .RotationY(let value):
            self.runRotationY(layer, y: value, blockCompletion: blockCompletion)
        case .RotationX(let value):
            self.runRotationX(layer, x: value, blockCompletion: blockCompletion)
        case .RotationZ(let value):
            self.runRotationZ(layer, z: value, blockCompletion: blockCompletion)
        case .Fade(let value):
            self.runFade(layer, pourcent: value, blockCompletion: blockCompletion)
        case .BorderRaduis(let value):
            self.runBorderRaduis(layer, angle: value, blockCompletion: blockCompletion)
        case .Sequence(let animations):
            self.runSequenceAnimation(layer, animations: animations, blockCompletion: blockCompletion)
        case .Repeat(let count, let animation):
            self.runRepeatAnimation(layer, count: count, animation: animation, blockCompletion: blockCompletion)
        case .MoveCircle(let value):
            self.runMoveCircle(layer, frameCircle: value, blockCompletion: blockCompletion)
        case .None:
            Void()
        }
    }
}

extension CALayer {
    
    func runAnimation(animation: Animation) {
        animation.runAnimation(self, blockCompletion: nil)
    }

    func runAnimation(animation: Animation, blockCompletion :(() -> ())) {
        animation.runAnimation(self, blockCompletion: blockCompletion)
    }
}