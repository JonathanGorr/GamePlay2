package com.Stacked 
{
	import com.Utils.Misc;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.system.FlxTilemapBuffer;
	
	/**
	 * FlxTilemapExt modified for with debug to show tile types and alpha fading. 
	 * 
	 * @author Charles Goatley
	 */
	public class FlxTilemapStacked extends FlxTilemap
	{
		protected var _storedPixels:BitmapData = null;
		
		public function getRects(): Array { return _rects; }
		
		public var tileCount:uint = 0;
		
		public var tileSpacingY:uint = 0;
		public var stackHeight:uint = 0;
		
		protected var tileIdRects:Vector.<Rectangle>;
		public var stackData:Dictionary = new Dictionary;	// stackData[tileIdx] = StackInfo
		protected var drawIndex:uint = 0;
		
		public function get tileWidth(): uint
		{
			return _tileWidth;
		}
		
		public function get tileHeight(): uint
		{
			return _tileHeight;
		}
		
		public function FlxTilemapStacked() 
		{
			super();	
		}
		
		public function loadStackMap(MapData:String, TileGraphic:Class, TileWidth:uint=0, TileHeight:uint=0, TileSpacingY:uint = 0, StackHeight:int = 0, AutoTile:uint=OFF, StartingIndex:uint=0, DrawIndex:uint=1, CollideIndex:uint=1, StackData:String = null):FlxTilemap
		{
			super.loadMap( MapData, TileGraphic, TileWidth, TileHeight, AutoTile, StartingIndex, DrawIndex, CollideIndex );
			
			tileSpacingY = TileSpacingY;
			stackHeight = StackHeight;
			
			initBaseGraphics();
			
			drawIndex = DrawIndex;
			
			if ( StackData )
			{
				loadStackData(StackData);
			}
			
			return this;
		}
		
		public function loadStackData(StackData:String):void
		{
			//Figure out the map dimensions based on the data string
			var rows:Array = StackData.split("\n");
			_data = new Array();
			var maxRows:uint = Math.min(heightInTiles, rows.length);
			for ( var row:uint = 0; row < maxRows; row++ )
			{
				var columns:Array = rows[row].split(",");
				var maxColumns:uint = Math.min(widthInTiles, columns.length);
				var tileId:uint = (row * heightInTiles);
				for (var column:uint = 0; column < maxColumns; column++ )
				{
					var stacks:Array = columns[column].split(";");
					if ( stacks.length )
					{
						var newStack:StackInfo = new StackInfo;
						var addedStack:Boolean = false;
						for (var stack:uint = 0; stack < stacks.length; stack++ )
						{
							var tileData:Array = stacks[stack].split(":");
							if ( tileData.length >= 2 )
							{
								newStack.stackedTiles[uint(tileData[0])] = uint(tileData[1]);
								addedStack = true;
							}
						}
						if ( addedStack )
						{
							stackData[tileId] = newStack;
						}
					}
					tileId++;
				}
			}
		}
		
		private function initBaseGraphics():void
		{
			_flashPoint.x = _flashPoint.y = 0;

			_flashRect = new Rectangle(0, 0, _tiles.width, _tiles.height);
			_storedPixels = new BitmapData(_tiles.width, _tiles.height);
			_storedPixels.copyPixels(_tiles, _flashRect, _flashPoint);
			
			tileCount = ( _tiles.width / tileWidth ) * (_tiles.height / tileHeight );
			
			tileIdRects = new Vector.<Rectangle>;
			for ( var tileId:uint = 0; tileId < tileCount; tileId++ )
			{
				updateTileIdx(tileId);
			}
		}
		
		protected function updateTileIdx(tileId:uint):void
		{
			var rx:uint = (tileId-_startingIndex)*_tileWidth;
			var ry:uint = 0;
			if(rx >= _tiles.width)
			{
				ry = uint(rx/_tiles.width)*_tileHeight;
				rx %= _tiles.width;
			}
			tileIdRects[tileId] = (new Rectangle(rx, ry, _tileWidth, _tileHeight));
		}

		/**
		 * Draws the tilemap buffers to the cameras and handles flickering.
		 */
		override public function draw():void
		{
			if(_flickerTimer != 0)
			{
				_flicker = !_flicker;
				if(_flicker)
					return;
			}
			
			if(cameras == null)
				cameras = FlxG.cameras;
			var camera:FlxCamera;
			var buffer:FlxTilemapBuffer;
			var i:uint = 0;
			var l:uint = cameras.length;
			while(i < l)
			{
				camera = cameras[i];
				if (_buffers[i] == null )
				{
					// Override the whole function just so we can use tileSpacingY instead of tileheight.
					_buffers[i] = new FlxTilemapBuffer(_tileWidth, tileSpacingY, widthInTiles, heightInTiles, camera);
				}
				buffer = _buffers[i++] as FlxTilemapBuffer;
				if(!buffer.dirty)
				{
					_point.x = x - int(camera.scroll.x*scrollFactor.x) + buffer.x; //copied from getScreenXY()
					_point.y = y - int(camera.scroll.y*scrollFactor.y) + buffer.y;
					_point.x += (_point.x > 0)?0.0000001:-0.0000001;
					_point.y += (_point.y > 0)?0.0000001:-0.0000001;
					buffer.dirty = (_point.x > 0) || (_point.y > 0) || (_point.x + buffer.width < camera.width) || (_point.y + buffer.height < camera.height);
				}
				if(buffer.dirty)
				{
					drawTilemap(buffer,camera);
					buffer.dirty = false;
				}
				_flashPoint.x = x - int(camera.scroll.x*scrollFactor.x) + buffer.x; //copied from getScreenXY()
				_flashPoint.y = y - int(camera.scroll.y*scrollFactor.y) + buffer.y;
				_flashPoint.x += (_flashPoint.x > 0)?0.0000001:-0.0000001;
				_flashPoint.y += (_flashPoint.y > 0)?0.0000001:-0.0000001;
				buffer.draw(camera,_flashPoint);
				//_VISIBLECOUNT++;
			}
		}
		
		/**
		 * Internal function that actually renders the tilemap to the tilemap buffer.  Called by draw().
		 * 
		 * @param	Buffer		The <code>FlxTilemapBuffer</code> you are rendering to.
		 * @param	Camera		The related <code>FlxCamera</code>, mainly for scroll values.
		 */
		override protected function drawTilemap(Buffer:FlxTilemapBuffer,Camera:FlxCamera):void
		{			
			Buffer.fill();
			
			//Copy tile images into the tile buffer
			_point.x = int(Camera.scroll.x*scrollFactor.x) - x; //modified from getScreenXY()
			_point.y = int(Camera.scroll.y*scrollFactor.y) - y;
			var screenXInTiles:int = (_point.x + ((_point.x > 0)?0.0000001:-0.0000001))/_tileWidth;
			var screenYInTiles:int = (_point.y + ((_point.y > 0)?0.0000001:-0.0000001))/tileSpacingY;
			var screenRows:uint = Buffer.rows;
			var screenColumns:uint = Buffer.columns;
			
			//Bound the upper left corner
			if(screenXInTiles < 0)
				screenXInTiles = 0;
			if(screenXInTiles > widthInTiles-screenColumns)
				screenXInTiles = widthInTiles-screenColumns;
			if(screenYInTiles < 0)
				screenYInTiles = 0;
			if(screenYInTiles > heightInTiles-screenRows)
				screenYInTiles = heightInTiles-screenRows;
			
			var rowIndex:int = screenYInTiles*widthInTiles+screenXInTiles;
			_flashPoint.y = 0;
			var row:uint = 0;
			var column:uint;
			var columnIndex:uint;
			var tile:FlxTile;
			var debugTile:BitmapData;
			var drawAbovePoint:Point = new Point;
			while(row < screenRows)
			{
				columnIndex = rowIndex;
				column = 0;
				_flashPoint.x = 0;
				while(column < screenColumns)
				{
					_flashRect = _rects[columnIndex] as Rectangle;
					if(_flashRect != null)
					{
						Buffer.pixels.copyPixels(_tiles, _flashRect, _flashPoint, null, null, true);
						
						if ( stackData[columnIndex] )
						{
							var stackInfo:StackInfo = stackData[columnIndex];
							drawAbovePoint.x = _flashPoint.x;
							for( var tileKey:Object in stackInfo.stackedTiles )
							{
								var tileIdx:int = int(tileKey);
								var id:int = int(stackInfo.stackedTiles[tileIdx]);
								drawAbovePoint.y = _flashPoint.y - ( tileIdx * stackHeight );
								if ( id >= drawIndex )
								{
									_flashRect = tileIdRects[id];
									Buffer.pixels.copyPixels(_tiles, _flashRect, drawAbovePoint, null, null, true);
								}
							}
						}
						if(FlxG.visualDebug && !ignoreDrawDebug)
						{
							tile = _tileObjects[_data[columnIndex]];
							if(tile != null)
							{
								if(tile.allowCollisions <= NONE)
									debugTile = _debugTileNotSolid; //blue
								else if(tile.allowCollisions != ANY)
									debugTile = _debugTilePartial; //pink
								else
									debugTile = _debugTileSolid; //green
								Buffer.pixels.copyPixels(debugTile,_debugRect,_flashPoint,null,null,true);
							}
						}
						
					}
					_flashPoint.x += _tileWidth;
					column++;
					columnIndex++;
				}
				rowIndex += widthInTiles;
				_flashPoint.y += tileSpacingY;
				row++;
			}
			Buffer.x = screenXInTiles*_tileWidth;
			Buffer.y = screenYInTiles*tileSpacingY;
		}
	}

}