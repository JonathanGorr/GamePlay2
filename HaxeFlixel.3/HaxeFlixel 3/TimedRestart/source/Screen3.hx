// Using FlxTimer to switch states

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxTimer;	// Import FlxTimer

class Screen3 extends FlxState {

	var t:FlxText;
	var timer:FlxTimer;	// Declare FlxTimer object

	override public function create():Void {
		t = new FlxText(0, 200, 640, "Wait 5 sec. to restart");
		t.size = 40;
		t.alignment = "center";
		add(t);

		timer = new FlxTimer();
		timer.start(5);	// Start a timer of 5 seconds
		// No add() needed because we will not be drawing to the screen
		
		super.create();
	}
	
	override public function update():Void {
		// Use timeLeft property to check remaining time
		FlxG.log(timer.timeLeft);

		// When the timer runs out do this...
		if (timer.finished == true){
			FlxG.switchState(new Screen1());
		}

		super.update();
	}	
}