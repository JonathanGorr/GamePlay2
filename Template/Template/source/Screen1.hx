package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen1 extends FlxState {

	// Function called when screen is created. Generally used to set things up
	override public function create():Void {
		// Set a background color
		FlxG.bgColor = 0xffaa0000;
		// Do everything else that FlxState normally does when created
		super.create();
	}
	
	// Function called every frame
	override public function update():Void {
		// Do everything which FlxState normally does every frame
		super.update();
	}	
}