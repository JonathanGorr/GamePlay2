package com 
{
	/* Simple Claws PlayState.as
	 * This sample code is intended to be used along with the flixelSimple exporter
	 * For Flixel version 2.5
	 * */
	import com.AnimTiles.AnimTilesState;
	import com.BaseLevel;
	import com.Isometric.IsometricState;
	import com.Objects.Player;
	import com.Stacked.StackState;
	import com.xml.XmlState;
	import flash.utils.getTimer;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;

	public class MenuState extends FlxState
	{
		private var buttonIso:FlxButtonPlus;
		private var buttonStack:FlxButtonPlus;
		private var buttonXml:FlxButtonPlus;
		private var buttonAnimTiles:FlxButtonPlus;
		private var header:FlxText;
		
		public function MenuState():void
		{
			super();
			FlxG.mouse.show();
		}
		
		override public function create():void
		{
			header = new FlxText(0, 20, FlxG.width,"Select demo.\nPress ESC to return to this menu.");
			header.setFormat("system", 12,0xffffff,"center");
			header.scrollFactor.x = header.scrollFactor.y = 0;
			add(header);
			
			buttonIso = new FlxButtonPlus(32, 90, onClickIso, [ "ABC", 12.3 ], "Isometric", 140);
			buttonIso.screenCenter();
			
			buttonStack = new FlxButtonPlus(32, 120, onClickStack, [ "ABC", 12.3 ], "Stacked", 140);
			buttonStack.screenCenter();
			
			buttonXml = new FlxButtonPlus(32, 150, onClickXml, [ "ABC", 12.3 ], "Xml Dynamic load", 140);
			buttonXml.screenCenter();
			
			buttonAnimTiles = new FlxButtonPlus(32, 180, onClickAnimTiles, [ "ABC", 12.3 ], "Animated Tiles", 140);
			buttonAnimTiles.screenCenter();
			
			add(buttonIso);
			add(buttonStack);
			add(buttonXml);
			add(buttonAnimTiles);
		}
		
		private function onClickIso(text:String, value:Number):void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new IsometricState);
		}
		
		private function onClickStack(text:String, value:Number):void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new StackState);
		}
		
		private function onClickXml(text:String, value:Number):void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new XmlState);
		}
		
		private function onClickAnimTiles(text:String, value:Number):void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new AnimTilesState);
		}
		
	}

}