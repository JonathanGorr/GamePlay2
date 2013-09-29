package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Meteor extends FlxSprite{

	public function new(): Void {
		super(FlxG.width, FlxG.height/2+32,"assets/Meteor.png");

	}

	override public function update(): Void{

		velocity.x = -30;

		super.update();
	}


}
