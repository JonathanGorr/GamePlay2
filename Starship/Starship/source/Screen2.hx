package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxGroup;
import org.flixel.FlxCamera;

class Screen2 extends FlxState {

	public var background = 0xff314AAD;

	var player:Player;
	var bullet:Bullet;
	var cloud:Cloud;
	var cloud2:Cloud;
	var bg:Background;
	var bg2:Background;
	var speed:Int;

	public var bullets:FlxGroup; //group
	public var enemybullets:FlxGroup; //group
	var enemies:FlxGroup; //enemies

	var numberofenemies:Int;

	override public function create():Void {

		FlxG.bgColor = background;

		bg = new Background(FlxG.width/2-160,FlxG.height/2-1000);
		add(bg);
		bg2 = new Background(FlxG.width/2-160,FlxG.height/2-2000);
		add(bg2);

		bg.scale.x = bg.scale.y = 2;
		bg2.scale.x = bg2.scale.y = 2;

		cloud = new Cloud(-100,-500);
		add(cloud);
		cloud2 = new Cloud(400,-800);
		add(cloud2);

		cloud.scale.x = cloud.scale.y = 3;
		cloud2.scale.x = cloud2.scale.y = 3;

		player = new Player();
		add(player);

		enemybullets = new FlxGroup();
		add(enemybullets);

		numberofenemies = 1;

		enemies = new FlxGroup();
		for (i in 0...numberofenemies) { //Does x times, 0 to x; instances
			enemies.add(new Enemy(i * 50, 100)); //placement= x value * a, y value * b.
		}

		add(enemies);

		bullets = new FlxGroup();
		add(bullets);

		// Do everything else that FlxState normally does when created
		super.create();
	}
	
	// Function called every frame
	override public function update():Void {

		speed = 100;

		bg.velocity.y = speed;
		bg2.velocity.y = speed;
		cloud.velocity.y = speed * 2.5;
		cloud2.velocity.y = speed * 2;

		FlxG.volume = 0.2;//controls volume of noises

		if(player.y > 920){
			player.y = 920;
		}

		if(cloud.y > 1000){
			cloud.y = -600;
		}

		if(cloud2.y > 1000){
			cloud2.y = -600;
		}

		if(bg.y > 1500){
			bg.y = -800;
		}

		if(bg2.y > 1500){
			bg2.y = -800;
		}

		FlxG.overlap(enemies, bullets, hitEnemy); //collision between bullets and enemies
		FlxG.overlap(player, enemybullets, hitPlayer); // collision bewteen player and enemy bullets

		if(numberofenemies == 0){ //win screen
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