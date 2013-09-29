package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;

class Screen_Kill extends FlxState{

	var t:FlxText;

	override public function create():Void{
		t = new FlxText(0,220,480, "YOU LOSE!");
		t.color = 0x00000000;
		t.size = 40;
		t.alignment = "center";
		add(t);

		super.create();
	}

	override public function update(): Void{

		//velocity.x = -20;

		super.update();

	}
}

