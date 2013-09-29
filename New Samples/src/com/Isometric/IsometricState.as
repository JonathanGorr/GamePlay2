package com.Isometric 
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

	public class IsometricState extends FlxState
	{
		private var level:BaseLevelSimple;
		private var player:Player;
		
		public static var elapsedTime:Number = 0;
		private static var lastTime:uint = 0;
		private var text:FlxText;
		
		private var coinsGroup:FlxGroup = null;
		
		private var camera:FlxCamera;
		
		protected function onSpriteAddedCallback(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Player)
			{
				player = sprite as Player;
			}
		}
		
		public function IsometricState():void
		{
			super();
		}
		
		override public function create():void
		{
			Player.nextPlayerType = Player.ImgPlayer;
			level = new Level_Iso(true, onSpriteAddedCallback);
			player.Tilemap = level.mainLayer as FlxTilemapIso;
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			FlxG.worldBounds = new FlxRect(level.mainLayer.x, level.mainLayer.y, level.mainLayer.width, level.mainLayer.height);
			
			text = new FlxText(20, 20, 80);
			text.setFormat("system", 12,0xffffff,"left",0x444444);
			text.scrollFactor.x = text.scrollFactor.y = 0;
			FlxG.state.add(text);
		}
		
		override public function update():void
		{
			super.update();
			
			var unitPos:FlxPoint = new FlxPoint;
			var tilemapIso:FlxTilemapIso = level.mainLayer as FlxTilemapIso;
			tilemapIso.GetTilePosAtScreenPos((player.x + (player.width * 0.5)) - level.mainLayer.x , (player.y + player.height) - level.mainLayer.y, unitPos, null, true);
			text.text = (int)(Math.floor(unitPos.x)) + "," + (int)(Math.floor(unitPos.y));
			
			// Simple check to prevent player going out of bounds.
			var outOfBounds:Boolean = false;
			if ( unitPos.x < 0 )
			{
				unitPos.x = 0;
				outOfBounds = true;
			}
			else if ( unitPos.x >= tilemapIso.widthInTiles )
			{
				unitPos.x = tilemapIso.widthInTiles - 0.01;
				outOfBounds = true;
			}
			if ( unitPos.y < 0 )
			{
				unitPos.y = 0;
				outOfBounds = true;
			}
			else if ( unitPos.y >= tilemapIso.heightInTiles )
			{
				unitPos.y = tilemapIso.heightInTiles;
				outOfBounds = true;
			}
			if ( outOfBounds )
			{
				var screenPos:FlxPoint = new FlxPoint;
				tilemapIso.GetTileWorldFromUnitPos(unitPos.x, unitPos.y, screenPos, true);
				player.x = screenPos.x - (player.width * 0.5);
				player.y = screenPos.y - player.height;
				
			}
			
			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new MenuState() );
			}
			
		}
		
	}

}