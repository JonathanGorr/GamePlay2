package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Enemy extends FlxSprite {

	var bulletTimer:Float;
	
	public function new(startX:Float, startY:Float):Void {

		super(startX, startY, "assets/Enemy.png");
		//makeGraphic(60,20,0xffffffff);

		bulletTimer = (FlxG.random()*2) + 2; //pick number between 0-1, add 2 = seconds till enemy shoots
		
	}
	
	override public function update():Void {
		bulletTimer -= FlxG.elapsed; //Add/count down time(seconds) to 0

		if(bulletTimer < 0){
			cast(FlxG.state, Screen2).enemybullets.add(new EnemyBullet(x + 20, y +20));
			bulletTimer = (FlxG.random()*2) + 2;
			FlxG.play("Shoot");
		}

		super.update();

		}
	}
