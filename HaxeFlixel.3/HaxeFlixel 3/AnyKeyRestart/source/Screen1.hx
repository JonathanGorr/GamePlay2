// 3 state example
// Screen1: menu/start state

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen1 extends FlxState {

	var t:FlxText;

	override public function create():Void {
		t = new FlxText(0, 200, 640, "Press SPACE to start");
		t.size = 40;
		t.alignment = "center";
		add(t);
		super.create();
	}
	
	override public function update():Void {
		if(FlxG.keys.SPACE == true){
			FlxG.switchState(new Screen2());
		}
		super.update();
	}	
}