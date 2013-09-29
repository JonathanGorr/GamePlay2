package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;

class Screen_Win extends FlxState{

	var t:FlxText;

	override public function create():Void{
		t = new FlxText(0,220,480, "AMERICA!");
		t.color = 0x00000000;
		t.size = 40;
		t.alignment = "center";
		add(t);

		super.create();
	}

	override public function update(): Void{
		super.update();

		//velocity.x = -20;
	}
}

