package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Player extends FlxSprite {

	// If we add the keyword public, we can change these vaiables from Screen1
	public var startX:Float;
	public var startY:Float;

	public function new(startX:Float, startY:Float):Void {
		super(startX, startY);
		makeGraphic(60, 20, 0xffffffff);
	}

	// Player1 does this every frame
	override public function update():Void {
		super.update();

		velocity.x = 0;

		// Keyboard input
		if (FlxG.keys.LEFT == true){
			velocity.x = -300;
		}
		if (FlxG.keys.RIGHT == true){
			velocity.x = 300;
		}

		if(FlxG.keys.justPressed("SPACE") == true){
			cast(FlxG.state, Screen2).bullets.add(new Bullet(x+20, y-20));
		}

		// Restrict movement
		if (x < 0){
			x = 0;
		}
		if (x > FlxG.width-width){
			x = FlxG.width-width;
		}
	}
}