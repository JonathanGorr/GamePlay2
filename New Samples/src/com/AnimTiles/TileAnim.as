package com.AnimTiles 
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class TileAnim 
	{
		public var name:String;
		public var fps:Number;
		public var frames:Array;
		
		private var totalAnimTime:Number = 0;
		public var currentFrameIdx:int = 0;
		
		// flag to indicate if the frames should be changed.
		public var changeFrame:Boolean = false;
		
		public function TileAnim(Name:String, FPS:Number, Frames:Array) 
		{
			name = Name;
			fps = FPS;
			frames = Frames;
		}
		
		public function update():void
		{
			var newTotalAnimTime:Number = totalAnimTime + FlxG.elapsed;
			var maxTime:Number = frames.length / fps;
			if ( newTotalAnimTime > maxTime )
			{
				newTotalAnimTime = newTotalAnimTime - maxTime;
			}
			totalAnimTime = newTotalAnimTime;
			
			var newFrameIdx:uint = Math.floor( totalAnimTime * fps );
			if ( newFrameIdx != currentFrameIdx )
			{
				currentFrameIdx = newFrameIdx;
				changeFrame = true;
			}
			else
			{
				changeFrame = false;
			}
		}
		
	}

}