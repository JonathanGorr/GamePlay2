package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class EnemyBullet extends FlxSprite {

	public var startX:Float;
	public var startY:Float;

	public function new(startX:Float, startY:Float):Void {
		super(startX, startY);
		makeGraphic(20, 20, 0xffffff00);
	}

	override public function update():Void {
		if (y > FlxG.height){
			kill();
		}
		velocity.y = 300;
		super.update();
	}
}