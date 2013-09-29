package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Ball extends FlxSprite{

	public var directionX: Int;
	public var directionY: Int;

	public var speedX: Float;
	public var speedY: Float;

	public var done:Bool; //true/false end game/death

	public function new(): Void {
	
		//super(FlxG.width/2, FlxG.height/2); //center is half of width & height
		super(FlxG.width/2-16, FlxG.height/2-16+270,"assets/Ball.png");

		directionX = Std.int(FlxG.random()*2); //directionX = std/rounded random function * 2 // Std.int(FlxG.random()*2)
		if (directionX == 0) {
			directionX = -1;
		}

		directionY = Std.int(FlxG.random()*2);
		if (directionY == 0) {
			directionY = -1;
		}

		FlxG.log(directionX);

		speedX = 100; //ball speed
		speedY = 200;

		done = false; //end game screen is inactive
	}

	override public function update(): Void{

/*		//wrap around c.f. asteroids
		if(x > FlxG.width){
			x = 0;
		}

		if(x < -width){
			x = FlxG.width;
		}

		if(y > FlxG.height){
			y = 0;
		}

		if(y < -height){
			y = FlxG.height;
		}
*/

		// Bounces off walls
		if(y > FlxG.height - height) { //game over quadrant
			done = true;
		}

		if(x < 0) {
			directionX *= -1; //left boundary
		}

		if(x > FlxG.width - width) { //right boundary
			directionX *= -1;
		}
/*
		if(y > FlxG.height - height) { //down boundary
			directionY *= -1;
		}
*/
		if(y < 0) { //up boundary
			directionY *= -1;
		}

/*
		if(FlxG.keys.SPACE == true) {//if press SPACE, Shoots ball
			velocity.x = speedX * directionX; //diagonal movement
			velocity.y = speedY * directionY; //diagonal movement
		}
*/
			velocity.x = speedX * directionX; //diagonal movement
			velocity.y = speedY * directionY; //diagonal movement

		super.update();


	}

}