package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Meteor_2 extends FlxSprite{

	public function new(): Void {
		super(FlxG.width+200, FlxG.height/2-300,"assets/Meteor.png");
	}

	override public function update(): Void{

		velocity.x = -40;

		super.update();
	}


}
