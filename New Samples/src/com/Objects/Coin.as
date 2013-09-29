package com.Objects 
{
	import org.flixel.*;
	
	public class Coin extends FlxSprite
	{
		[Embed(source = '../../../data/coin.png')] private var ImgCoin:Class;
		
		public function Coin(X:Number,Y:Number,animates:Boolean):void 
		{
			super(X, Y);
			loadGraphic(ImgCoin, true, true, 16, 16 );
			addAnimation("spin", [0, 1, 2, 3], 10);
			
			if ( animates )
			{
				play("spin");
				// Start from a random frame in the animation.
				_curFrame = int(Math.random() * (_curAnim.frames.length));
				calcFrame();
			}
			
		}
		
	}

}