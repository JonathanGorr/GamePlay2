// Playing a sound file
// Sounds must be linked in Template.xml file (under flash assets) like this: <sound path="sounds/shoot.mp3" id="Shoot" />

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxGroup; 

class Screen1 extends FlxState {

	public var bullets:FlxGroup; 
	var player:Player;

	override public function create():Void {
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