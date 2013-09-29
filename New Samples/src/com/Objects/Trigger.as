package com.Objects 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class Trigger extends FlxSprite
	{
		public var target:String = "";
		public var targetObject:Object = null;
		public var moveDir:uint = FlxObject.NONE;
		
		public function Trigger( X:Number, Y:Number, Width:uint, Height:uint ) 
		{
			super(X, Y);
			width = Width;
			height = Height;
			visible = false;
		}
		
		public function ParseProperties( properties:Array):void
		{
			if ( properties )
			{
				var i:int = properties.length;
				while(i--)
				{
					if ( properties[i].name == "target" )
					{
						target = properties[i].value;
					}
					else if ( properties[i].name == "moveDir" )
					{
						switch( properties[i].value )
						{
							case "LEFT":
								moveDir = FlxObject.LEFT;
								break;
							case "RIGHT":
								moveDir = FlxObject.RIGHT;
								break;
							case "UP":
								moveDir = FlxObject.UP;
								break;
							case "DOWN":
								moveDir = FlxObject.DOWN;
								break;
						}
					}
				}
			}
		}
		
		public function AddLinkTo(obj:Object):void
		{
			targetObject = obj;
		}
		
	}

}