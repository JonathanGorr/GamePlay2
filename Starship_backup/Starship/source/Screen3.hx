package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen3 extends FlxState {

	var t:FlxText;

	override public function create():Void {
		// Set a background color
		FlxG.bgColor = 0xff99CC33;

		t = new FlxText(0,420,640, "THE WAR IS OVER");
		t.size = 40;
		t.font = "assets/courier.ttf";
		t.alignment = "center";
		add(t);

		// Do everything else that FlxState normally does when created
		super.create();
	}
	
	// Function called every frame
	override public function update():Void {

		if(FlxG.keys.SPACE == true){
			FlxG.switchState(new Screen1());

		}

		// Do everything which FlxState normally does every frame
		super.update();
	}	
}