package com.AnimTiles 
{
	/* Simple Claws PlayState.as
	 * This sample code is intended to be used along with the flixelSimple exporter
	 * For Flixel version 2.5
	 * */
	import com.BaseLevel;
	import com.MenuState;
	import com.Objects.Player;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import org.flixel.*;

	public class AnimTilesState extends FlxState
	{
		private var level:BaseLevel;
		
		private var camera:FlxCamera;
		private var animTiles:Dictionary;
		
		public function AnimTilesState():void
		{
			super();
		}
		
		override public function create():void
		{
			Player.nextPlayerType = Player.ImgPlayerBoy;
			level = new Level_AnimTiles(true, onObjectAddedCallback);
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			//camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			FlxG.worldBounds = new FlxRect(level.mainLayer.x, level.mainLayer.y, level.mainLayer.width, level.mainLayer.height);
		}
		
		protected function onObjectAddedCallback(obj:Object, layer:FlxGroup, level:BaseLevel, scrollX:Number, scrollY:Number, properties:Array):Object
		{
			if ( properties )
			{
				var i:uint = properties.length;
				while(i--)
				{
					if ( properties[i].name == "%DAME_tiledata%" )
					{
						animTiles = properties[i].value;
						break;
					}
				}
			}
			
			return obj;
		}
		
		override public function update():void
		{
			super.update();
			
			// update the tile animations.
			// There are better, more effecient ways of doing this...
			for ( var animKey:Object in animTiles )
			{
				var tileAnim:TileAnim = animTiles[animKey];
				tileAnim.update();
			}
				
			var mapData:Array = level.mainLayer.getData(false);
			var i:uint = mapData.length;
			while (i--)
			{
				var tileId:int = mapData[i];
				for ( animKey in animTiles )
				{
					tileAnim = animTiles[animKey];
					var idx:int = tileAnim.frames.indexOf(tileId);
					if ( idx != -1 )
					{
						if ( tileAnim.changeFrame )
						{
							level.mainLayer.setTileByIndex(i, tileAnim.frames[tileAnim.currentFrameIdx], true);
						}
					}
				}
			}
			
			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new MenuState() );
			}
		}
		
	}

}