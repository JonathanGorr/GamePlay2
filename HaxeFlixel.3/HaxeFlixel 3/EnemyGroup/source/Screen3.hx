// Using FlxGroup to store Enemy objects.
// Working with functions
// Better collision

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen3 extends FlxState {

	var t:FlxText;

	override public function create():Void {
		t = new FlxText(0, 200, 640, "Press SPACE to restart");
		t.size = 40;
		t.alignment = "center";
		add(t);

		super.create();
	}
	
	override public function update():Void {
		if(FlxG.keys.SPACE == true){
			FlxG.switchState(new Screen1());
		}

		super.update();
	}	
}