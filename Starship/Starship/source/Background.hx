package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Background extends FlxSprite {
	
	public function new(startX:Float, startY:Float):Void {
		super(startX, startY, "assets/World/Background.png");
	}

	override public function update():Void {
		super.update();
	}
}