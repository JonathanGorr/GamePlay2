package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxCamera;

class Player1 extends FlxSprite {

	public function new(): Void {

		super(FlxG.width/2-64, FlxG.height-25, "assets/player1.png");

	}

	override public function update(): Void {

		super.update();
		
		//automatic brakes
		velocity.y=0; 
		velocity.x=0;

		/*
		if(FlxG.keys.UP == true){ //if press UP, moves up y
			velocity.y = -350; //speed of paddle
		}

		if(FlxG.keys.DOWN == true){ //if press DOWN, moves down y
			velocity.y = 350; //speed of paddle
		}
		*/

		if(FlxG.keys.LEFT == true){//if press LEFT, moves left x
			velocity.x = -300;
		}

		if(FlxG.keys.RIGHT == true){//if press RIGHT, moves right x
			velocity.x = 300;
		}
/*
		//Y Barriers
		if(y < 0){ //up
			y = 0;
		}

		if(y > FlxG.height - height){//down
			y = FlxG.height - height;
		}
/*
		//X barriers
		if(x < 0){
			x = 0;
		}

		if(x > FlxG.width - width){
			x = FlxG.width - width;
		}
*/
		if(x > FlxG.width){
			x = 0;
		}

		if(x < -width){
			x = FlxG.width;
		}

		super.update();

	}
}