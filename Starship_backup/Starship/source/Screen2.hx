package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxGroup;

class Screen2 extends FlxState {

	var player:Player;
	var bullet:Bullet;

	public var bullets:FlxGroup; //group
	public var enemybullets:FlxGroup; //group
	var enemies:FlxGroup; //enemies

	var numberofenemies:Int;

	override public function create():Void {

		player = new Player();
		add(player);

		enemybullets = new FlxGroup();
		add(enemybullets);

		numberofenemies = 13;

		enemies = new FlxGroup();
		for (i in 0...numberofenemies) { //Does x times, 0 to x; instances
			enemies.add(new Enemy(i * 50, 100)); //placement= x value * a, y value * b.
		}

		add(enemies);

		bullets = new FlxGroup();
		add(bullets);

		// Set a background color
		FlxG.bgColor = 0xff99CC33;
		// Do everything else that FlxState normally does when created
		super.create();
	}
	
	// Function called every frame
	override public function update():Void {
		FlxG.overlap(enemies, bullets, hitEnemy); //collision between bullets and enemies
		FlxG.overlap(player, enemybullets, hitPlayer); // collision bewteen player and enemy bullets

		if(FlxG.keys.SPACE == true){
			FlxG.switchState(new Screen3());
		}

		if(numberofenemies == 0){
			FlxG.switchState(new Screen3());
		}

		// Do everything which FlxState normally does every frame
		super.update();
	}
	//allow picking of one entity vs all
	public function hitEnemy(enemy:Enemy, bullet:Bullet):Void { //Void is data type for no data type/no numeric value; like int/float
		enemy.kill();
		bullet.kill();
		numberofenemies --; //everytime enemy killed, minuses from count
		FlxG.play("Explosion");

	}
	public function hitPlayer(p:Player, eBullet:EnemyBullet):Void { //Void is data type for no data type/no numeric value; like int/float
		p.kill();
		eBullet.kill();
		FlxG.switchState(new Screen3());
		FlxG.play("Explosion");

	}
}