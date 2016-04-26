# AnimationDemo
##基础动画的三种实现方式
###UIView 代码块
	[UIView animateWithDuration:1.0f animations:^{
		//animations code
	} completion:^(BOOL finished) {
		//the code excute after finished animations
	}]; 

###UIView beginAnimation commitAnimations
	[UIView beginAnimations:@"AnimationName" context:nil];
	[UIView setAnimationDuration:1.0f];
	//animation code;
	[UIView commitAnimations];

###CABasicAnimation 
	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"layerPorperty"];
	animation.fromValue = NSObject;//NSValue ,NSNumber ...
	animation,toValue = NSObject;//NSValue ,NSNumber ...
	[_animation.layer addAnimation:animation forKey:"animationName"];
	