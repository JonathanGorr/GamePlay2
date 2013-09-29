// Using a custom font

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen1 extends FlxState {

	var t:FlxText;

	override public function create():Void {
		t = new FlxText(0, 200, 640, "This is a custom font!");
		t.size = 40;

		// Put .ttf font file into assets folder and set with font property
		t.font = "assets/SourceCodePro-Light.ttf";
		t.alignment = "center";
		add(t);
		super.create();
	}
	
	override public function update():Void {
		super.update();
	}	
}