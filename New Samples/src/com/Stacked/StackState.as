package com.Stacked 
{
	/* Simple Claws PlayState.as
	 * This sample code is intended to be used along with the flixelSimple exporter
	 * For Flixel version 2.5
	 * */
	import com.BaseLevelSimple;
	import com.MenuState;
	import com.Objects.Player;
	import flash.utils.getTimer;
	import org.flixel.*;

	public class StackState extends FlxState
	{
		private var level:BaseLevelSimple;
		private var player:Player;
		
		public static var elapsedTime:Number = 0;
		private static var lastTime:uint = 0;
		
		private var coinsGroup:FlxGroup = null;
		
		private var camera:FlxCamera;
		
		protected function onSpriteAddedCallback(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Player)
			{
				player = sprite as Player;
			}
		}
		
		public function StackState():void
		{
			super();
		}
		
		override public function create():void
		{
			Player.nextPlayerType = Player.ImgPlayerBoy;
			level = new Level_Stack(true, onSpriteAddedCallback);
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			FlxG.worldBounds = new FlxRect(level.mainLayer.x, level.mainLayer.y, level.mainLayer.width, level.mainLayer.height);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new MenuState() );
			}
			
		}
		
	}

}