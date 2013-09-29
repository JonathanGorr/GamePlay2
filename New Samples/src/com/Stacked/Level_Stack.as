//Code generated with DAME. http://www.dambots.com

package com.Stacked
{
	import org.flixel.*;
	// Custom imports:
import com.Objects.*import com.*
	public class Level_Stack extends BaseLevelSimple
	{
		//Embedded media...
		[Embed(source="../../../data/stacked/mapCSV_Area1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Area1Map1:Class;
		[Embed(source="../../../data/stacked/mapCSV_Area1_Map1_stacks.txt", mimeType="application/octet-stream")] public var CSV_Area1Map1_Stacks:Class;
		[Embed(source="../../../data/2halfDTiles.png")] public var Img_Area1Map1:Class;

		//Tilemaps
		public var layerArea1Map1:FlxTilemapStacked;

		//Sprites
		public var Area1spritesGroup:FlxGroup = new FlxGroup;


		public function Level_Stack(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerArea1Map1 = new FlxTilemapStacked;
			layerArea1Map1.loadStackMap( new CSV_Area1Map1, Img_Area1Map1, 60,100, 50, 22, FlxTilemap.OFF, 0, 1, 1, new CSV_Area1Map1_Stacks );
			layerArea1Map1.x = -888.000000;
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

			boundsMinX = -888;
			boundsMinY = 0;
			boundsMaxX = 912;
			boundsMaxY = 1550;

		}

		public function addSpritesForLayerArea1sprites(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Player, Area1spritesGroup , -242.000, 793.000, 0.000, false, 1, 1, onAddCallback );//""
		}


	}
}
