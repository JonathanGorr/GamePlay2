package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Sun extends FlxSprite{

	public function new(): Void {
		super(FlxG.width/2-64, FlxG.height/2-64,"assets/sun.png");
	}

	override public function update(): Void{
		
		super.update();
	}


}
