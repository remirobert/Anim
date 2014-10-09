<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Anim/master/ressources/logo.gif"/>
  <h1 align="center">Anim</h1>
</p>


Anim allows you to use animations very easily. You can use it in your UIKit application for make smooth animations, using Swift. 


<h1 align="center">Features</h1>

 - Position (CGPoint)
 - Bounce effect
 - Resize (CGSize)
 - Rotation
 - Rotation X
 - Rotation Y
 - Rotation Z
 - Fade
 - Border raduis
 - Move circle
 - Animations sequence
 - Repeat animations
 - Block completion
 
<h1 align="center">How to use it</h1>

You can use Anim with all Layers (UIButton, UItableViewCell, UItextField, UIView, ...).
Anim provides a extension for CALayer, for use animation: 

```Swift
let animation = Animation.movePosition(CGPointmake(30, 30), delay: 1.5)
self.myView.layer.runAnimation(animation)
```

<h1 align="center">Example</h1>

<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Anim/master/ressources/record1.gif"/>
</p>

Here is the code for build the animation above:


```Swift
let animationStart = Animation.sequenceAnimations([Animation.resizeFrame(CGSizeMake(300, 300), delay: 2), Animation.rotationX(-0.85, delay: 2)])
        
o.layer.runAnimation(animationStart, blockCompletion: { () -> () in
  self.l.layer.runAnimation(Animation.movePosition(CGPointMake(100, 100), delay: 2))
  self.l.layer.runAnimation(Animation.resizeFrame(CGSizeMake(100, 100), delay: 2), blockCompletion: { () -> () in

    self.l2.layer.runAnimation(Animation.movePosition(CGPointMake(110, 110), delay: 2))
    self.l2.layer.runAnimation(Animation.resizeFrame(CGSizeMake(80, 80), delay: 2), blockCompletion: { () -> () in

      self.l3.layer.runAnimation(Animation.movePosition(CGPointMake(120, 120), delay: 2))
      self.l3.layer.runAnimation(Animation.resizeFrame(CGSizeMake(60, 60), delay: 2), blockCompletion: { () -> () in
                        
        o.layer.runAnimation(Animation.rotationX(0.85, delay: 2), blockCompletion: { () -> () in
        })
      })
    })
  })
})

```
