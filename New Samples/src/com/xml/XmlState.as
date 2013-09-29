package com.xml 
{
	/* Complex Claws PlayState.as
	 * This sample code is intended to be used along with the flixelComplex exporter.
	 * */
	import com.MenuState;
	import com.*;
	import com.Utils.ImageBank;
	import com.xml.Levels.*;
	import com.Objects.*;
	import com.Utils.FileLoader;
	import com.Utils.Misc;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.filters.ShaderFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import org.flixel.*;

	public class XmlState extends FlxState
	{
		[Embed(systemFont = 'Verdana', fontName = 'VerdanaFont', mimeType = 'application/x-font')] private var fontVerdana:Class;
		[Embed(systemFont = 'Arial', fontName = 'ArialFont', mimeType = 'application/x-font')] private var fontArial:Class;
		
		private var currentLevel:LevelData;
		private var lastLevel:LevelData = null;
		// List of all levels currently loaded
		public var levels:Vector.<LevelData> = new Vector.<LevelData>;
		private var isLoadingLevel:Boolean = false;
		
		public var layerStage:FlxGroup = new FlxGroup;
		
		private var ids:Dictionary = new Dictionary(true);
		
		private var player:Player = null;
		private var camera:FlxCamera;
		public static var text:FlxText;
		
		public function XmlState():void
		{
			super();
			ImageBank.Initialize();
		}
		
		override public function create():void
		{
			text = new FlxText(30, 43, 300,"Loading...");
			Player.nextPlayerType = Player.ImgPlayer;
			add(layerStage);
			add(text);
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			isLoadingLevel = true;
			currentLevel = new LevelData;
			currentLevel.LoadMap("xmlSample/Level_Area1.xml", onObjectAddedCallback, startLevelLoaded);
			levels.push(currentLevel);
			
		}
		
		private function startLevelLoaded( level:LevelData ):void
		{
			//FlxG.bgColor = currentLevel.bgColor;
			camera.setBounds(currentLevel.boundsMin.x + 1, currentLevel.boundsMin.y + 1, currentLevel.boundsMax.x - currentLevel.boundsMin.x, currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
			layerStage.add(level);
			isLoadingLevel = false;
		}
		
		protected function onObjectAddedCallback(obj:Object, layer:FlxGroup, level:LevelData, scrollX:Number, scrollY:Number, properties:Array):Object
		{
			if ( properties )
			{
				var i:uint = properties.length;
				while(i--)
				{
					if ( properties[i].name == "id" )
					{
						var name:String = properties[i].value;
						ids[name] = obj;
						break;
					}
				}
			}
			
			if (obj is Player)
			{
				player = obj as Player;
				player.acceleration.y = 400;	// add some gravity.	
				player.maxVelocity.y = 400;
				camera.follow(player, FlxCamera.STYLE_LOCKON);
			}
			else if ( obj is TextData )
			{
				var tData:TextData = obj as TextData;
				if ( tData.fontName != "" && tData.fontName != "system" )
				{
					tData.fontName += "Font";
				}
				return level.addTextToLayer(tData, layer, scrollX, scrollY, true, properties, onObjectAddedCallback );
			}
			else if ( obj is BoxData )
			{
				// Create the trigger.
				var bData:BoxData = obj as BoxData;
				var trigger:Trigger = new Trigger(bData.x, bData.y, bData.width, bData.height);
				trigger.ParseProperties(properties);
				level.addSpriteToLayer(trigger, FlxSprite, layer, trigger.x, trigger.y, bData.angle, scrollX, scrollY);
				return trigger;
			}
			else if ( obj is ObjectLink )
			{
				var link:ObjectLink = obj as ObjectLink;
				var fromBox:Trigger = link.fromObject as Trigger;
				if ( fromBox )
				{
					fromBox.targetObject = link.toObject;
				}
			}
			return obj;
		}
		
		override public function update():void
		{
			if ( !isLoadingLevel )
			{
				super.update();
			}
			
			if ( !player )
			{
				return;
			}
			
			if ( !isLoadingLevel )
			{
				// map collisions			
				FlxG.collide(player, currentLevel.collideGroup);
				FlxG.collide(currentLevel.collidingSpritesGroup, currentLevel.collideGroup);
				
				//player-object collisions
				FlxG.overlap(player, currentLevel.overlapGroup, PlayerOverlap );
			}

			if (FlxG.keys.pressed("ESCAPE"))
			{
				// Restart
				FlxG.switchState( new MenuState() );
			}
		}
		
		private function TriggerEntered( plr:FlxSprite, trigger:Trigger):void
		{			
			if ( plr == player && !isLoadingLevel && 
				(trigger.moveDir == FlxObject.NONE || plr.facing == trigger.moveDir) )
			{
				LoadLevel( trigger.target );
			}
		}
		
		private function PlayerOverlap( plr:FlxSprite, obj:FlxSprite):void
		{
			if ( player == plr)
			{
				if ( obj is Trigger )
				{
					TriggerEntered( plr, obj as Trigger );
				}
				else if ( obj is Coin )
				{
					obj.kill();
				}
			}
		}
		
		private function FindLevelDataByName(levelName:String):LevelData
		{
			var i:int = levels.length;
			while (i--)
			{
				if ( levels[i].name == levelName )
				{
					return levels[i];
				}
			}
			return null;
		}
		
		private function MovePlayerToLevel(level:LevelData):void
		{
			// reapply gravity and allow movement.
			FlxG.paused = false;
			if ( level["spritesGroup"] != null )
			{
				if ( currentLevel && currentLevel["spritesGroup"] != null )
				{
					var oldGroup:FlxGroup = currentLevel["spritesGroup"];
					oldGroup.remove(player, true);
				}
				var newGroup:FlxGroup = level["spritesGroup"];
				newGroup.add(player);
			}
			lastLevel = currentLevel;
			currentLevel = level;
			camera.setBounds(currentLevel.boundsMin.x, currentLevel.boundsMin.y, currentLevel.boundsMax.x - currentLevel.boundsMin.x, currentLevel.boundsMax.y - currentLevel.boundsMin.y, true);
		}
		
		private function levelLoaded( level:LevelData, alreadyLoaded:Boolean = false ):void
		{
			if ( currentLevel )
			{
				currentLevel.fadeoff();
			}
			isLoadingLevel = false;
			if ( layerStage.members.indexOf(level) == -1 )
			{
				layerStage.add(level);
			}
			MovePlayerToLevel(level);
			level.fadeon();
		}
		
		public function LoadLevel(name:String):void
		{
			try
			{
				var nextLevel:LevelData = FindLevelDataByName( name );
				if ( nextLevel )
				{
					// Move the player forward so that if the enter/exit triggers overlap the player
					// will be outside the one in the next level by the end of the transition.
					levelLoaded(nextLevel, true);
				}
				else if( !nextLevel )
				{
					isLoadingLevel = true;
					nextLevel = new LevelData;
					var filename:String = "xmlSample/" + name + ".xml";
					FlxG.paused = true;
					nextLevel.LoadMap(filename, onObjectAddedCallback, levelLoaded);
					levels.push(nextLevel);
				}
			}
			catch ( error:Error)
			{
			}
		}
		
	}

}