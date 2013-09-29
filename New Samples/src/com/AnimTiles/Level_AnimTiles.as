//Code generated with DAME. http://www.dambots.com

package com.AnimTiles
{
	import flash.utils.Dictionary;
	import org.flixel.*;
	// Custom imports:
import com.Objects.*
import com.*
	public class Level_AnimTiles extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../../../data/animTiles/mapCSV_Area1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Area1Map1:Class;
		[Embed(source="../../../data/animTiles/mapCSV_Area1_Map1_stacks.txt", mimeType="application/octet-stream")] public var CSV_Area1Map1_Stacks:Class;
		[Embed(source="../../../data/animTiles.png")] public var Img_Area1Map1:Class;

		//Tilemaps
		public var layerArea1Map1:FlxTilemap;

		//Sprites

		private var tileProperties:Array = [];


		public function Level_AnimTiles(addToStage:Boolean = true, onAddCallback:Function = null)
		{
			// Generate maps.
			var tileAnims:Dictionary = new Dictionary;
			tileAnims[1]=new TileAnim("grass",5.500,[1,9,1,10,10,1,10,10]);
			tileAnims[2]=new TileAnim("waves",5.000,[2,3,4,5,6,7,8]);
			tileProperties.push( { name:"%DAME_tiledata%", value:tileAnims } );
			layerArea1Map1 = addTilemap( CSV_Area1Map1, Img_Area1Map1, 0.000, 0.000, 50, 50, 1.000, 1.000, false, 1, 1, tileProperties, onAddCallback );
			layerArea1Map1.x = 0.000000;
			layerArea1Map1.y = 0.000000;
			layerArea1Map1.scrollFactor.x = 1.000000;
			layerArea1Map1.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerArea1Map1);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerArea1Map1;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 500;
			boundsMaxY = 500;

		}


	}
}
