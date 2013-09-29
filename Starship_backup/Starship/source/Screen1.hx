package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxTimer;

class Screen1 extends FlxState {

	var t:FlxText;
	var timer:FlxTimer;

	override public function create():Void {
		// Set a background color

		FlxG.bgColor = 0xff99CC33;

		timer = new FlxTimer();
		timer.start(5); //wait x seconds to start

		t = new FlxText(0,420,640, "Press SPACE to start");
		t.size = 40; 
		t.font = "assets/courier.ttf";
		t.alignment = "center";
		add(t);

		super.create();
 		// Do everything else that FlxState normally does when created
		super.create();
	}
	
	// Function called every frame
	override public function update():Void {

		FlxG.log(timer.timeLeft);

		if(FlxG.keys.SPACE == true){
			FlxG.switchState(new Screen2());

		}
		if(timer.finished == true){
			FlxG.switchState(new Screen2());
		}

		// Do everything which FlxState normally does every frame
		super.update();
	}
}