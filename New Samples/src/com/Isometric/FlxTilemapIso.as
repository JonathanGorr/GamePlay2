package com.Isometric 
{
	import com.Utils.Misc;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
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
	public class FlxTilemapIso extends FlxTilemap
	{
		protected var _storedPixels:BitmapData = null;
		
		public function getRects(): Array { return _rects; }
		
		public var tileCount:uint = 0;
		
		public var tileOffsetX:int = 0;
		public var tileOffsetY:int = 0;
		
		public var tileSpacingX:uint = 0;
		public var tileSpacingY:uint = 0;
		
		// An offset from the top left of the tilemap to where the top left of the first tile is drawn.
		public var tilesStartX:uint = 0;
		public var tilesStartY:uint = 0;
		
		// The first visible tiles to render.
		protected var renderX:int = 0;
		protected var renderY:int = 0;
		
		public function get tileWidth(): uint
		{
			return _tileWidth;
		}
		
		public function get tileHeight(): uint
		{
			return _tileHeight;
		}
		
		public function FlxTilemapIso() 
		{
			super();	
		}
		
		public function loadIsoMap(MapData:String, TileGraphic:Class, TileWidth:uint=0, TileHeight:uint=0, TileOffsetX:int = 0, TileOffsetY:int = 0, TileSpacingX:uint = 0, TileSpacingY:uint = 0, TilesStartX:int = 0, TilesStartY:int = 0, AutoTile:uint=OFF, StartingIndex:uint=0, DrawIndex:uint=1, CollideIndex:uint=1):FlxTilemap
		{
			//_data = new Array();
			//_rects = new Array();
			// Pass in Unique=true so that we can fade these tiles separately, even if the graphics are shared among maps.
			//isUnique = true;	// Gets handled by addBitmap within loadMap
			super.loadMap( MapData, TileGraphic, TileWidth, TileHeight, AutoTile, StartingIndex, DrawIndex, CollideIndex );
			
			tileOffsetX = TileOffsetX;
			tileOffsetY = TileOffsetY;
			tileSpacingX = TileSpacingX;
			tileSpacingY = TileSpacingY;
			tilesStartX = TilesStartX;
			tilesStartY = TilesStartY;
			
			initBaseGraphics();
			
			return this;
		}
		
		private function initBaseGraphics():void
		{
			_flashPoint.x = _flashPoint.y = 0;

			_flashRect = new Rectangle(0, 0, _tiles.width, _tiles.height);
			_storedPixels = new BitmapData(_tiles.width, _tiles.height);
			_storedPixels.copyPixels(_tiles, _flashRect, _flashPoint);
			
			tileCount = ( _tiles.width / tileWidth ) * (_tiles.height / tileHeight );
		}
		
		private function getBufferSize(buffer:FlxTilemapBuffer, camera:FlxCamera):void
		{
			if ( tileOffsetY || tileOffsetX )
			{
				// Isometric tiles need some extra calculations.
				var sample:FlxPoint = new FlxPoint;
				var minx:int = 0;
				var miny:int = 0;
				var maxx:int = 0;
				var maxy:int = 0;
				
				// Sample top right of screen
				GetTilePosAtScreenPos( camera.width + tilesStartX, 0 + tilesStartY, sample, null);
				maxx = Math.max(sample.x, maxx);
				maxy = Math.max(sample.y, maxy);
				minx = Math.min(sample.x, minx);
				miny = Math.min(sample.y, miny);
				
				// Sample bottom right of screen
				GetTilePosAtScreenPos( camera.width + tilesStartX, camera.height + tilesStartY, sample, null);
				maxx = Math.max(sample.x, maxx);
				maxy = Math.max(sample.y, maxy);
				minx = Math.min(sample.x, minx);
				miny = Math.min(sample.y, miny);
				
				// Sample bottom left of screen
				GetTilePosAtScreenPos( 0 + tilesStartX, camera.height + tilesStartY, sample, null);
				maxx = Math.max(sample.x, maxx);
				maxy = Math.max(sample.y, maxy);
				minx = Math.min(sample.x, minx);
				miny = Math.min(sample.y, miny);
				
				// Add magic number to account for bottom tiles not being rendered. No idea why this works :s
				buffer.columns = (maxx - minx) + 5
				buffer.rows = (maxy - miny) + 5
			}
			/*else if ( xStagger )
			{
				_screenCols++;
				_screenRows++;
			}*/
			
			// Limit the screen size only when not repeating as we don't want to restrict the amount drawn in those cases.
			if( buffer.rows > heightInTiles)
				buffer.rows = heightInTiles;
			if( buffer.columns > widthInTiles)
				buffer.columns = widthInTiles;
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
					_buffers[i] = new FlxTilemapBuffer(_tileWidth, _tileHeight, widthInTiles, heightInTiles, camera);
					// Override the whole function just so we can call getBufferSize on new buffers...
					getBufferSize(_buffers[i], camera);
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
			if ( !tileOffsetX && !tileOffsetY )
			{
				super.drawTilemap(Buffer, Camera);
			}
			
			Buffer.fill();

			var tempPoint:FlxPoint = getScreenXY(null, Camera);
			//Copy tile images into the tile buffer
			_point.x = int(Camera.scroll.x*scrollFactor.x) - x; //modified from getScreenXY()
			_point.y = int(Camera.scroll.y * scrollFactor.y) - y;
			
			getRenderStartValues(tempPoint, Camera);
			
			var screenRows:uint = Buffer.rows;
			var screenColumns:uint = Buffer.columns;
			
			var rowIndex:int = renderY * widthInTiles + renderX;
			var row:uint = 0;
			var column:uint;
			var columnIndex:uint;
			var tile:FlxTile;
			var debugTile:BitmapData;
			
			var startX:int = 0;
			var startY:int = 0;
			var storedX:int = tilesStartX + (renderX * tileSpacingX) + (renderY * tileOffsetX);
			_flashPoint.y = tilesStartY + (renderY * tileSpacingY) + (renderX * tileOffsetY);
			
			var tilesToDraw:int = int(widthInTiles) - renderX;
			screenColumns = Math.min( screenColumns, Math.max(0,tilesToDraw) );
			
			storedX -= _point.x;
			_flashPoint.y -= _point.y;
			
			while(row < screenRows)
			{
				columnIndex = rowIndex;
				column = 0;
				_flashPoint.x = storedX;
				var storedY:int = _flashPoint.y;
				while(column < screenColumns)
				{
					_flashRect = _rects[columnIndex] as Rectangle;
					if(_flashRect != null)
					{
						Buffer.pixels.copyPixels(_tiles,_flashRect,_flashPoint,null,null,true);
						/*if(FlxG.visualDebug)
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
						}*/
					}
					_flashPoint.x += tileSpacingX;// _tileWidth;
					_flashPoint.y += tileOffsetY;
					column++;
					columnIndex++;
				}
				rowIndex += widthInTiles;
				_flashPoint.y = storedY + tileSpacingY;// _tileHeight;
				storedX += tileOffsetX;
				row++;
			}
			Buffer.x = _point.x;
			Buffer.y = _point.y;
		}
		
		protected function getRenderStartValues(screenPos:FlxPoint, camera:FlxCamera):void
		{			
			// Calculate the points we must sample to find the starting tile to draw for iso tiles
			if ( tileOffsetY || tileOffsetY )
			{
				var sample:FlxPoint = new FlxPoint;
			
				// Sample top left of screen
				GetTilePosAtScreenPos( -screenPos.x, -screenPos.y, sample, null);
				renderX = sample.x;
				renderY = sample.y;
				
				if ( tileOffsetY > 0 )
				{
					// Sample top right of screen.
					GetTilePosAtScreenPos( -screenPos.x + camera.width, -screenPos.y, sample, null );
					renderX = Math.min(sample.x, renderX);
					renderY= Math.min(sample.y, renderY);
				}
				else if ( tileOffsetX > 0 )
				{
					// Sample bottom left of screen.
					GetTilePosAtScreenPos( -screenPos.x, -screenPos.y + camera.height, sample, null );
					renderX = Math.min(sample.x, renderX);
					renderY = Math.min(sample.y, renderY);
				}
			}
			else
			{
				/*renderX = Math.floor( -screenPos.x / tileSpacingX);
				renderY = Math.floor( ( -screenPos.y - (tileHeight - tileSpacingY)) ) / tileSpacingY;
				if ( xStagger )
				{
					renderX--;
					renderY--;
				}*/
			}
			
			//if ( !repeatingX )
			{
				if (renderX < 0)
					renderX = 0;
				//if (renderX > widthInTiles - _screenCols)
				//	renderX = widthInTiles - _screenCols;
			}
			//if ( !repeatingY )
			{
				if (renderY < 0)
					renderY = 0;
				//if (renderY > heightInTiles - _screenRows)
				//	renderY = heightInTiles - _screenRows;
			}
		}
		
		public function GetTilePosAtScreenPos( worldx:Number, worldy:Number, unitTilePos:FlxPoint, tilePos:FlxPoint, allowFloats:Boolean = false):Boolean
		{
			unitTilePos.make( -1, -1);
			
			worldx -= tilesStartX;
			
			// Check standard or skewed isometric tilemaps.
			if ( tileOffsetX || tileOffsetY )
			{
				// Get position relative to the start of the tile that equates to x = 0, y = 0
				// Imagine rotating the tilemap so it is normal 2d, and worldx|y should match the top left of the tilemap.
				
				worldy -= ( tilesStartY + (tileHeight - tileSpacingY) );
				worldx += tileOffsetX;
				if ( tileOffsetY > 0 )
				{
					// -ive tileOffset is going up, which means the origin of the map is where the tile is.
					worldy += tileOffsetY;
				}
				if ( tileOffsetX > 0 )
				{
					worldx -= tileOffsetX;
				}
				
				// Get the right edge of the map
				var endxx:Number = tileSpacingX * widthInTiles;
				var endxy:Number = tileOffsetY * widthInTiles;
				
				// Get location on x-axis where world pos lies.
				var pt:FlxPoint = new FlxPoint;
				var intersects:Boolean = Misc.LineRayIntersection(0, 0, endxx, endxy, worldx, worldy, worldx - tileOffsetX, worldy - tileSpacingY, pt);
				
				var offX:Number = pt.x;
			
				// Get location on y-axis where world pos lies.
				// This is just the difference between world pos and x-axis intersection
				// Will not work if height differences are 0, ie map is rotated 90 degrees.
				var offY:Number = worldy - pt.y;
				
				var xpos:Number;
				var ypos:Number;
				
				xpos = offX / tileSpacingX;
				ypos = offY / tileSpacingY;
				var iXpos:int = int(xpos);
				var iYpos:int = int(ypos);
				
				intersects = intersects && ( offY >= 0 && iYpos < heightInTiles );
				
				// Account for the -0,+0 1 tile rounding error on each axis.
				if ( offX < 0 )
					iXpos--;
				if ( offY <= 0 )
					iYpos--;
					
				if ( !allowFloats )
				{
					xpos = iXpos;
					ypos = iYpos;
				}
					
				unitTilePos.make( xpos, ypos );
				
				GetTileWorldFromUnitPos(xpos, ypos, tilePos );
				return ( intersects && ( offY >= 0 && offY <= tileSpacingY * heightInTiles ) );
			}
			
			return false;
			
		}
		
		// Gets the actual screen relative world position from the map position.
		public function GetTileWorldFromUnitPos( xpos:Number, ypos:Number, result:FlxPoint, fromOrigin:Boolean = false ):void
		{
			if ( result == null )
			{
				return;
			}
			
			if ( tileOffsetX || tileOffsetY )
			{
				var newX:Number = (xpos * tileSpacingX) + (ypos * tileOffsetX);
				var newY:Number = (xpos * tileOffsetY) + (ypos * tileSpacingY);

				newX += x;
				newY += y;

				newX += tilesStartX;
				newY += tilesStartY;
				
				if ( fromOrigin )
				{
					newY += ( tileHeight - tileSpacingY );
					if ( tileOffsetX < 0 )
					{
						newX -= tileOffsetX;
					}
					if ( tileOffsetY > 0 )
					{
						newY -= tileOffsetY;
					}
				}
				
				result.make( newX, newY );
			}
			/*else if ( xStagger )
			{
				newX = xpos * tileSpacingX;
				newY = ypos * tileSpacingY;
				
				var tileStartY:int = tileHeight - tileSpacingY;
				newX += tilesStartX;
				newY += tileStartY;
				newY -= tileSpacingY;
				
				if( ypos%2!=0)
				{
					newX += xStagger;
				}
			
				newX += x;
				newY += y;
				
				if ( fromOrigin )
				{
					newX += ( tileSpacingX * 0.5 );
					newY += ( tileHeight - tileSpacingY );
				}
				
				result.make( newX, newY - ( tileHeight - ( tileSpacingY * 2 ) ) );
			}*/
			else
			{
				var tileStartY:int = tileHeight - tileSpacingY;
				// Scale up back into world pos.
				newX = xpos * tileSpacingX;
				newY = ypos * tileSpacingY;
				
				newY += tileStartY;
			
				newX += x;
				newY += y;
				
				if ( fromOrigin )
				{
					newY += ( tileHeight - tileSpacingY );
				}
				
				result.make( newX, newY - ( tileHeight - tileSpacingY ) );
			}
		}
		
	}

}