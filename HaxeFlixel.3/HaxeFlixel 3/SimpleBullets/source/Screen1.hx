// Using a FlxGroup to hold Bullets

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxGroup; // Import FlxGroup to store bullets

class Screen1 extends FlxState {

	public var bullets:FlxGroup; 	// Group to hold Bullets objects. Must be public so it can be accessed by Player
	var player:Player;

	override public function create():Void {
		// Create group and add it
		bullets = new FlxGroup();
		add(bullets);

		player = new Player(FlxG.width/2-20, FlxG.height-20);
		add(player);

		super.create();
	}
	
	override public function update():Void {
		super.update();
	}	
}