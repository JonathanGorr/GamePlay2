package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy extends FlxSprite {

	public function new():Void {
		super(FlxG.random()*FlxG.width, FlxG.random()*200);
		makeGraphic(60, 60, 0xffff0000);
	}

	// Player1 does this every frame
	override public function update():Void {
		super.update();
	}
}