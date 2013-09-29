package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class StarField_Back extends FlxSprite{

var scrollSpeed:Float;

public function new(): Void {

	super(100, 0,"assets/stars.png");
}

override public function update(): Void{

	scrollSpeed = -12;
	
	velocity.y = 0; // Scrolls the background up
	velocity.x = scrollSpeed; // Scrolls the background to the left

	if(x > FlxG.width){ //wraps around seamlessly
			x = 0;
		}

		if(x < -width){
			x = FlxG.width;
		}

	super.update();
	}
}
