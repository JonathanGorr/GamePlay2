package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class StarField_Fore extends FlxSprite{

var scrollSpeed:Float;

public function new(): Void {

	super(0, 0,"assets/stars_fore.png");
}

override public function update(): Void{

	scrollSpeed = -20;
	
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
