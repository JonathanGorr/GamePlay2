package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Player extends FlxSprite {
	
	public function new():Void {

		super(FlxG.width/2-16, FlxG.height/2-16+400, "assets/Player.png");
		//makeGraphic(60,20,0xffffffff);
	
	override public function update():Void {
		super.update();

		velocity.x = 0;
		velocity.y = 0;

		//Movement X
		if(FlxG.keys.A == true) {
			velocity.x = -300;
		}
		if(FlxG.keys.D == true) {
			velocity.x = 300;
		}
		//Wrap around
		if(x < 0){
			x = 620;
		}
		if(x > 620){
			x = 0;
		}

		//Movement Y
		if(FlxG.keys.W == true) {
			velocity.y = -300;
		}
		if(FlxG.keys.S == true) {
			velocity.y = 300;
		}

		if(FlxG.keys.justPressed("SHIFT")){ //will only respond after one click
			FlxG.play("Shoot");
			cast(FlxG.state, Screen2).bullets.add(new Bullet(x + 20, y - 20));//FlxG.state
		}
	}
}
}