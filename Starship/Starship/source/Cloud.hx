package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Cloud extends FlxSprite {
	
	public function new(startX:Float, startY:Float):Void {
		super(startX, startY, "assets/World/Clouds.png");
		//makeGraphic(10,10,0xffffffff);
	}

	override public function update():Void {

		super.update();
	}
}