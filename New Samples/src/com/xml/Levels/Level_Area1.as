//Code generated with DAME. http://www.dambots.com

package com.xml.Levels
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	import com.Objects.*;
	public class Level_Area1 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../../../data/mapCSV_Area1_Main.csv", mimeType="application/octet-stream")] public var CSV_Main:Class;
		[Embed(source="../../../data/maintiles.png")] public var Img_Main:Class;

		//Tilemaps
		public var layerMain:FlxTilemap;

		//Sprites
		public var spritesGroup:FlxGroup = new FlxGroup;

		//Shapes
		public var GravityZonesGroup:FlxGroup = new FlxGroup;

		//Properties


		public function Level_Area1(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( { name:"PointlessProperty", value:9 }, null );
			layerMain = addTilemap( CSV_Main, Img_Main, 0.000, 0.000, 32, 32, 1.000, 1.000, true, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(spritesGroup);
			masterLayer.add(layerMain);
			masterLayer.add(GravityZonesGroup);

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 2656;
			boundsMaxY = 3296;
			boundsMin = new FlxPoint(0, 0);
			boundsMax = new FlxPoint(2656, 3296);
			bgColor = 0xff000000;
		}

		override public function createObjects(onAddCallback:Function = null, parentObject:Object = null):void
		{
			addShapesForLayerGravityZones(onAddCallback);
			addSpritesForLayersprites(onAddCallback);
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function addShapesForLayerGravityZones(onAddCallback:Function = null):void
		{
			var obj:Object;

			obj = new BoxData(0.000, -32.000, 0.000, 192.000, 512.000, GravityZonesGroup );
			shapes.push(obj);
			callbackNewData( obj, onAddCallback, GravityZonesGroup, generateProperties( { name:"gravity", value:-1.000000 }, null ), 1, 1 );
			obj = new BoxData(0.000, 480.000, 0.000, 192.000, 416.000, GravityZonesGroup );
			shapes.push(obj);
			callbackNewData( obj, onAddCallback, GravityZonesGroup, generateProperties( { name:"gravityTop", value:-1.000000 }, { name:"gravityBottom", value:0 }, null ), 1, 1 );
			obj = new BoxData(0.000, 2912.000, 0.000, 192.000, 416.000, GravityZonesGroup );
			shapes.push(obj);
			callbackNewData( obj, onAddCallback, GravityZonesGroup, generateProperties( { name:"gravity", value:1.000000 }, null ), 1, 1 );
			obj = new BoxData(0.000, 2432.000, 0.000, 192.000, 480.000, GravityZonesGroup );
			shapes.push(obj);
			callbackNewData( obj, onAddCallback, GravityZonesGroup, generateProperties( { name:"gravityTop", value:0.000000 }, { name:"gravityBottom", value:1.000000 }, null ), 1, 1 );
		}

		public function addSpritesForLayersprites(onAddCallback:Function = null):void
		{
			addSpriteToLayer(null, Player, spritesGroup , 416.000, 2304.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Claws"
			addSpriteToLayer(null, Platform, spritesGroup , 512.000, 2304.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"blood"
			addSpriteToLayer(null, Platform, spritesGroup , 704.000, 1920.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"blood"
			addSpriteToLayer(null, Platform, spritesGroup , 544.000, 3232.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"blood"
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
