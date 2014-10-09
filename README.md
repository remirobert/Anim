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
let animation = Animation.movePosition(CGPointMake(30, 30), delay: 1.5)
self.myView.layer.runAnimation(animation)
```
<hr>

You can use the block completion for link animation

```Swift
let resizeAnimation = Animation.resize(CGSizeMake(30, 30), delay: 1.5)
let bounceAnimation = Animation.bounce(30, delay: 0.1)

self.myView.layer.runAnimation(resizeAnimation, blockCompletion: { () -> () in
  self.myView.layer.runAnimation(bounceAnimation)
})
```
<hr>

You can also use sequence of animations. All animations in a sequence will be executed one after the other.

```Swift
let sequenceAnimation = Animation.sequenceAnimations([Animation.resize(CGSizeMake(30, 30), delay: 1.5),
                                                      Animation.bounce(30, delay: 0.1)])

self.myView.layer.runAnimation(sequenceAnimation)
```

<hr>

Now there is the repeat animation method. For infinite or count animation.

```Swift
let move = Animation.sequenceAnimations([Animation.movePosition(CGPointMake(10, 10), delay: 1.5),
                                         Animation.movePosition(CGPointMake(30, 30), delay: 1.5)])
let bounce = Animation.bounce(30, delay: 0.1)
                                                      
let repeatBouceForEver = Animation.repeatAnimations(Repeat.Infinity, animationParam: bounce)
let repeatMove = Animation.repeatAnimations(Repeat.Count(10), animationParam: move)

self.myView.layer.runAnimation(repeatBouceForEver)
self.myView.layer.runAnimation(repeatMove)
```

<hr>

For remove all current animation:

```Swift
self.myView.layer.removeAllAnimations()
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
<hr>

<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Anim/master/ressources/record2.gif"/>
</p>

```Swift       
let a = Animation.repeatAnimations(Repeat.Count(3), animationParam: Animation.moveCircle(CGRectMake(0, 100, 200, 200), delay: 1))
let a2 = Animation.repeatAnimations(Repeat.Count(3), animationParam: Animation.moveCircle(CGRectMake(0, 100, 200, 200), delay: 1.5))
let a3 = Animation.repeatAnimations(Repeat.Count(3), animationParam: Animation.moveCircle(CGRectMake(0, 100, 200, 200), delay: 2))

l.layer.runAnimation(a)
l2.layer.runAnimation(a2)
l3.layer.runAnimation(a3)
```

<hr>

<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Anim/master/ressources/record3.gif"/>
</p>

```Swift
self.myImageView.layer.runAnimation(Animation.rotationY(Float(M_PI) * 4, delay: 2), blockCompletion: { () -> () in
  self.myImageView.layer.runAnimation(Animation.bounce(60, delay: 0.1))
  self.myImageView.image = UIImage(named: "otherImage")
})
```

