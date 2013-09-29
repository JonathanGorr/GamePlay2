// 3 state example
// Screen3: game over screen

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen3 extends FlxState {

	var t:FlxText;

	override public function create():Void {
		t = new FlxText(0, 200, 640, "Press ANY KEY to restart");
		t.size = 40;
		t.alignment = "center";
		add(t);

		super.create();
	}
	
	override public function update():Void {
		// Restart with a keypress. any() can be used to accept any key pressed
		if(FlxG.keys.any() == true){
			FlxG.switchState(new Screen1());
		}

		super.update();
	}	
}