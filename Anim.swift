//
//  Animation.swift
//  Animation
//
//  Created by Remi Robert on 08/10/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

import UIKit
private func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

private func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


enum Repeat {
  case count(Int)
  case infinity
}

enum AnimationType {
  case bounce(Float)
  case position(CGPoint)
  case resize(CGSize)
  case rotation(Float)
  case rotationY(Float)
  case rotationX(Float)
  case rotationZ(Float)
  case fade(Float)
  case borderRaduis(Float)
  case sequence(([Animation]))
  case `repeat`((Int, Animation))
  case moveCircle(CGRect)
  case none
}

class Animation: NSObject, CAAnimationDelegate {
  fileprivate var type: AnimationType = .none
  fileprivate var delay: TimeInterval = 0.5
  fileprivate var blockCompletion: (() -> ())?
  fileprivate var countAnimation: Int = 0
  fileprivate var animationsList: [Animation]? = nil
  
  //MARK: Bounce
  class func bounce(_ value: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.bounce(value)
    return animation
  }
  
  class func bounce(_ value: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.bounce(value)
    return animation
  }
  
  //MARK: Move Position
  class func movePosition(_ position: CGPoint) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.position(position)
    return animation
  }
  
  class func movePosition(_ position: CGPoint, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.position(position)
    return animation
  }
  
  //MARK: Resize Frame
  class func resizeFrame(_ resize: CGSize) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.resize(resize)
    return animation
  }
  
  class func resizeFrame(_ resize: CGSize, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.resize(resize)
    return animation
  }
  
  //MARK: Rotation Frame
  class func rotation(_ angle: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.rotation(angle)
    return animation
  }
  
  class func rotation(_ angle: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.rotation(angle)
    return animation
  }
  
  //MARK: 3D Rotation Y
  class func rotationY(_ rotation: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.rotationY(rotation)
    return animation
  }
  
  class func rotationY(_ rotation: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.rotationY(rotation)
    return animation
  }
  
  //MARK: 3D Rotation X
  class func rotationX(_ rotation: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.rotationX(rotation)
    return animation
  }
  
  class func rotationX(_ rotation: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.rotationX(rotation)
    return animation
  }
  
  //MARK: 3D Rotation Z
  class func rotationZ(_ rotation: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.rotationZ(rotation)
    return animation
  }
  
  class func rotationZ(_ rotation: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.rotationZ(rotation)
    return animation
  }
  
  //MARK: Fade
  class func fade(_ pourcent: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.fade(pourcent)
    return animation
  }
  
  class func fade(_ pourcent: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.fade(pourcent)
    return animation
  }
  
  //MARK: Border Raduis
  class func borderRaduis(_ angle: Float) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.borderRaduis(angle)
    return animation
  }
  
  class func borderRaduis(_ angle: Float, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.borderRaduis(angle)
    return animation
  }
  
  //MARK: sequence Animations
  class func sequenceAnimations(_ animations: [Animation]) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.sequence(animations)
    return animation
  }
  
  //MARK: repeat Animations
  class func repeatAnimations(_ count: Repeat, animationParam: Animation) -> Animation {
    let animation = Animation()
    
    switch count {
    case .count(let value):
      animation.type = AnimationType.repeat((value, animationParam))
    case .infinity:
      animation.type = AnimationType.repeat((-1, animationParam))
    }
    return animation
  }
  
  //MARK: Move arround circle
  class func moveCircle(_ frameCircle: CGRect) -> Animation {
    let animation = Animation()
    
    animation.type = AnimationType.moveCircle(frameCircle)
    return animation
  }
  
  class func moveCircle(_ frameCircle: CGRect, delay: TimeInterval) -> Animation {
    let animation = Animation()
    
    animation.delay = delay
    animation.type = AnimationType.moveCircle(frameCircle)
    return animation
  }
  
  fileprivate func createAnimation(_ pathAnimation: String, delay: TimeInterval) -> CABasicAnimation {
    let animation = CABasicAnimation(keyPath: pathAnimation)
    
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    animation.delegate = self
    animation.duration = delay
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    return animation
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    blockCompletion?()
  }
  
  fileprivate func runBounce(_ layer:CALayer, value:Float, blockCompletion: (() -> ())?) {
    if value <= 3 {
      if let block = blockCompletion {
        block()
      }
      return Void()
    }
    UIView.animate(withDuration: self.delay, animations: { () -> Void in
      layer.frame = CGRect(x: layer.frame.origin.x - CGFloat(value / 2), y: layer.frame.origin.y - CGFloat(value / 2),
                           width: layer.frame.size.width + CGFloat(value),
                           height: layer.frame.size.height + CGFloat(value))
    }) { (Bool) -> Void in
      
      UIView.animate(withDuration: self.delay, animations: { () -> Void in
        layer.frame = CGRect(x: layer.frame.origin.x + CGFloat(value / 2), y: layer.frame.origin.y + CGFloat(value / 2),
                             width: layer.frame.size.width - CGFloat(value),
                             height: layer.frame.size.height - CGFloat(value))
        }, completion: { (Bool) -> Void in
          self.runBounce(layer, value: value / 2, blockCompletion: blockCompletion)
      })
    }
  }
  
  fileprivate func runMovePosition(_ layer: CALayer, position: CGPoint, blockCompletion: (() -> ())?) {
    UIView.animate(withDuration: self.delay, animations: { () -> Void in
      layer.frame = CGRect(x: position.x, y: position.y, width: layer.frame.size.width, height: layer.frame.size.height)
    }) { (Bool) -> Void in
      if let block = blockCompletion {
        block()
      }
    }
  }
  
  fileprivate func runResize(_ layer: CALayer, resize: CGSize, blockCompletion: (() -> ())?) {
    UIView.animate(withDuration: self.delay, animations: { () -> Void in
      layer.frame = CGRect(x: layer.frame.origin.x, y: layer.frame.origin.y,
                           width: resize.width, height: resize.height)
    }) { (Bool) -> Void in
      if let block = blockCompletion {
        block()
      }
    }
  }
  
  fileprivate func runRotation(_ layer:CALayer, rotation: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("transform.rotation", delay: self.delay)
    
    animation.fromValue = 0
    if let currentLayer: AnyObject = layer.presentation() {
      animation.fromValue = Float(currentLayer.value(forKeyPath: "transform.rotation") as! NSNumber)
    }
    
    self.blockCompletion = blockCompletion
    animation.toValue = rotation + Float(animation.fromValue as! NSNumber)
    layer.add(animation, forKey: "rotation")
  }
  
  fileprivate func runRotationY(_ layer: CALayer, y: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("transform.rotation.y", delay: self.delay)
    var rotation = CATransform3DIdentity
    
    animation.fromValue = 0
    if let currentLayer: AnyObject = layer.presentation() {
      animation.fromValue = Float(currentLayer.value(forKeyPath: "transform.rotation.y") as! NSNumber)
    }
    
    self.blockCompletion = blockCompletion
    rotation.m34 = 1.0 / 500.0
    animation.toValue = y + Float(animation.fromValue as! NSNumber)
    layer.add(animation, forKey: "rotationY")
    layer.transform = rotation
  }
  
  fileprivate func runRotationX(_ layer: CALayer, x: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("transform.rotation.x", delay: self.delay)
    var rotation = CATransform3DIdentity
    
    animation.fromValue = 0
    if let currentLayer: AnyObject = layer.presentation() {
      animation.fromValue = Float(currentLayer.value(forKeyPath: "transform.rotation.x")as! NSNumber)
    }
    
    self.blockCompletion = blockCompletion
    rotation.m34 = 1.0 / 500.0
    animation.toValue = x + Float(animation.fromValue as! NSNumber)
    layer.add(animation, forKey: "rotationX")
    layer.transform = rotation
  }
  
  fileprivate func runRotationZ(_ layer: CALayer, z: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("transform.rotation.z", delay: self.delay)
    var rotation = CATransform3DIdentity
    
    animation.fromValue = 0
    if let currentLayer: AnyObject = layer.presentation() {
      animation.fromValue = Float(currentLayer.value(forKeyPath: "transform.rotation.z") as! NSNumber)
    }
    
    self.blockCompletion = blockCompletion
    rotation.m34 = 1.0 / 500.0
    animation.toValue = z + Float(animation.fromValue as!
      NSNumber)
    layer.add(animation, forKey: "rotationZ")
    layer.transform = rotation
  }
  
  fileprivate func runFade(_ layer: CALayer, pourcent: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("opacity", delay: self.delay)
    
    self.blockCompletion = blockCompletion
    animation.toValue = pourcent
    layer.add(animation, forKey: "fade")
  }
  
  fileprivate func runBorderRaduis(_ layer: CALayer, angle: Float, blockCompletion: (() -> ())?) {
    let animation = createAnimation("cornerRadius", delay: self.delay)
    
    self.blockCompletion = blockCompletion
    animation.toValue = 15.0
    animation.fromValue = layer.cornerRadius
    layer.add(animation, forKey: "angleRaduis")
  }
  
  fileprivate func runMoveCircle(_ layer: CALayer, frameCircle: CGRect, blockCompletion: (() -> ())?) {
    let animation = CAKeyframeAnimation(keyPath: "position")
    self.blockCompletion = blockCompletion
    
    animation.path = CGPath(ellipseIn: frameCircle, transform: nil)
    animation.fillMode = kCAFillModeForwards
    animation.isRemovedOnCompletion = false
    animation.delegate = self
    animation.duration = delay
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    animation.isAdditive = true;
    animation.calculationMode = kCAAnimationPaced;
    animation.rotationMode = kCAAnimationRotateAuto;
    layer.add(animation, forKey: "moveCircle")
  }
  
  fileprivate func execAnimationSequence(_ layer:CALayer) {
    if self.countAnimation >= self.animationsList?.count {
      self.blockCompletion?()
      return Void()
    }
    
    let currentAnimation = self.animationsList?[self.countAnimation]
    
    currentAnimation?.runAnimation(layer, blockCompletion: { () -> () in
      self.countAnimation += 1
      self.execAnimationSequence(layer)
    })
  }
  
  fileprivate func runSequenceAnimation(_ layer: CALayer, animations: [Animation], blockCompletion: (() -> ())?) {
    self.blockCompletion = blockCompletion
    self.countAnimation = 0
    self.animationsList = animations
    self.execAnimationSequence(layer)
  }
  
  
  fileprivate func runRepeatAnimation(_ layer: CALayer, count: Int, animation: Animation, blockCompletion: (() -> ())?) {
    if count == 0 {
      blockCompletion?()
      return Void()
    }
    animation.runAnimation(layer, blockCompletion: { () -> () in
      self.runRepeatAnimation(layer, count: count - 1, animation: animation, blockCompletion: blockCompletion)
    })
  }
  
  fileprivate func runAnimation(_ layer: CALayer, blockCompletion: (() -> ())?) {
    switch self.type {
    case .bounce(let value):
      self.runBounce(layer, value: value, blockCompletion: blockCompletion)
    case .position(let value):
      self.runMovePosition(layer, position: value, blockCompletion: blockCompletion)
    case .resize(let value):
      self.runResize(layer, resize: value, blockCompletion: blockCompletion)
    case .rotation(let value):
      self.runRotation(layer, rotation: value, blockCompletion: blockCompletion)
    case .rotationY(let value):
      self.runRotationY(layer, y: value, blockCompletion: blockCompletion)
    case .rotationX(let value):
      self.runRotationX(layer, x: value, blockCompletion: blockCompletion)
    case .rotationZ(let value):
      self.runRotationZ(layer, z: value, blockCompletion: blockCompletion)
    case .fade(let value):
      self.runFade(layer, pourcent: value, blockCompletion: blockCompletion)
    case .borderRaduis(let value):
      self.runBorderRaduis(layer, angle: value, blockCompletion: blockCompletion)
    case .sequence(let animations):
      self.runSequenceAnimation(layer, animations: animations, blockCompletion: blockCompletion)
    case .repeat(let count, let animation):
      self.runRepeatAnimation(layer, count: count, animation: animation, blockCompletion: blockCompletion)
    case .moveCircle(let value):
      self.runMoveCircle(layer, frameCircle: value, blockCompletion: blockCompletion)
    case .none:
      Void()
    }
  }
}

extension CALayer {
  
  func runAnimation(_ animation: Animation) {
    animation.runAnimation(self, blockCompletion: nil)
  }
  
  func runAnimation(_ animation: Animation, blockCompletion :(() -> ())) {
    animation.runAnimation(self, blockCompletion: blockCompletion)
  }
}
