package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.util.FlxTimer;

class Enemy extends FlxSprite {

	var directionX:Int;
	var speedX:Int;
	var bulletTimer:Float; // bulletTimer will hold our timer countdown to fire bullets

	public function new(startX:Float, startY:Float):Void {
		super(startX, startY);
		makeGraphic(60, 60, 0xffff0000);

		directionX = Std.int(FlxG.random()*2);
		if (directionX == 0){
			directionX = -1;
		}

		speedX = 100;
		bulletTimer = (FlxG.random()*4)+1; // The timer will be set to a random value between 1 and 5 seconds
	}

	override public function update():Void {
		velocity.x = speedX * directionX;
		super.update();

		if(x < 0 || x > FlxG.width-width){
			directionX *= -1;
		}


		// Subtract 1 from bulletTimer each second
		bulletTimer -= FlxG.elapsed;

		// When the timer runs out, add an EnemyBullet to Screen2's enemyBullets FlxGroup.
		if(bulletTimer < 0){
			cast(FlxG.state, Screen2).enemyBullets.add(new EnemyBullet(x+20,y+height));
			bulletTimer = (FlxG.random()*4)+1;	// Reset the timer for the next shot
		}


	}
}