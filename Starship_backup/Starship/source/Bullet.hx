package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Bullet extends FlxSprite {
	
	public function new(startX:Float, startY:Float):Void {
		super(startX, startY, "assets/Bullet.png");
		//makeGraphic(10,10,0xffffffff);
	}

	override public function update():Void {
		velocity.y = -300;

		if(y < -height){
			kill();
		}

		super.update();
	}
}