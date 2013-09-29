//Code generated with DAME. http://www.dambots.com

package com.Isometric
{
	import org.flixel.*;
	// Custom imports:
import com.Objects.*import com.*
	public class Level_Iso extends BaseLevelSimple
	{
		//Embedded media...
		[Embed(source="../../../data/isometric/mapCSV_Area1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Area1Map1:Class;
		[Embed(source="../../../data/simpleIso.png")] public var Img_Area1Map1:Class;

		//Tilemaps
		public var layerArea1Map1:FlxTilemapIso;

		//Sprites
		public var Area1spritesGroup:FlxGroup = new FlxGroup;


		public function Level_Iso(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerArea1Map1 = new FlxTilemapIso;
			layerArea1Map1.loadIsoMap( new CSV_Area1Map1, Img_Area1Map1, 60,30, -30,12, 30,12, 1470,0, FlxTilemap.OFF, 0, 1, 1 );
			layerArea1Map1.x = 0.000000;
			layerArea1Map1.y = 0.000000;
			layerArea1Map1.scrollFactor.x = 1.000000;
			layerArea1Map1.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerArea1Map1);
			masterLayer.add(Area1spritesGroup);


			if ( addToStage )
			{
				addSpritesForLayerArea1sprites(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerArea1Map1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 3000;
			boundsMaxY = 1206;

		}

		public function addSpritesForLayerArea1sprites(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Player, Area1spritesGroup , 1584.000, 480.000, 0.000, false, 1, 1, onAddCallback );//""
		}


	}
}
