package com.Objects
{
	import com.Isometric.FlxTilemapIso;
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../../../data/player.png')] public static var ImgPlayer:Class;
		[Embed(source='../../../data/character Boy.png')] public static var ImgPlayerBoy:Class;
		
		private const ACCEL_RATE:int = 800;
		public const MAX_VELOCITY:int = 250;
		private const FRICTION:int = 300;
		private var JUMP_POWER:int = 350;   
		private var tilemap:FlxTilemapIso = null;
		private var gradient:Number = 1;
		
		static public var nextPlayerType:Class = ImgPlayer;
		
		public function Player(X:Number,Y:Number):void 
		{
			super(X, Y);
			switch(nextPlayerType )
			{
				case ImgPlayer:
					loadGraphic(nextPlayerType, true, true, 32, 32 );
					break;
				case ImgPlayerBoy:
					loadGraphic(nextPlayerType, true, false, 101, 171 );
					break;
			}
			
			//bounding box tweaks
			width = 32;
			height = 28;
			offset.x = 0;
			offset.y = 4;			
			
			maxVelocity.x = MAX_VELOCITY;
			maxVelocity.y = MAX_VELOCITY;
			//Set the player health
			health = 10;
			//Gravity
			//acceleration.y = 220;			
			//Friction
			drag.x = FRICTION;
			drag.y = FRICTION;
			
		}
		
		override public function update():void 
		{
			if ( FlxG.keys.LEFT )
			{
				facing = LEFT;
				velocity.x -= ACCEL_RATE * FlxG.elapsed;
			}
			else if (FlxG.keys.RIGHT )
			{
				facing = RIGHT;
				velocity.x += ACCEL_RATE * FlxG.elapsed;		
			}
			
			if ( IsPlatformer() )
			{
				if ( FlxG.keys.justPressed("UP") && isTouching(FLOOR) )
				{
					velocity.y = -JUMP_POWER;
				}
			}
			else
			{
				if ( FlxG.keys.UP )
				{
					velocity.y -= ACCEL_RATE * FlxG.elapsed * gradient;
				}
				else if (FlxG.keys.DOWN )
				{
					velocity.y += ACCEL_RATE * FlxG.elapsed * gradient;		
				}
			}
			
		}
		
		public function set Tilemap(map:FlxTilemapIso):void
		{
			tilemap = map;
			
			// Work out the gradient so that moving on diagonals aligns with the gradient of the tilemap.
			
			// This isn't a perfect algorithm. It just works for diamond isometric and simple skewed tilemaps.
			// If the graident is different going right from going left then we can get undesired results.
			if ( tilemap.tileOffsetY && tilemap.tileOffsetX )
			{
				gradient = Math.abs( tilemap.tileOffsetY / tilemap.tileOffsetX);
			}
			else
			{
				gradient = 1;
			}
			
			if ( !IsPlatformer() )
			{
				maxVelocity.x = MAX_VELOCITY;
				maxVelocity.y = MAX_VELOCITY * gradient;
				
				drag.x = FRICTION;
				drag.y = FRICTION * gradient;
			}
		}
		
		private function IsPlatformer():Boolean
		{
			return (acceleration.y != 0);
		}
	
		
	}

}