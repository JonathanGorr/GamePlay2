package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxGroup;

class Screen2 extends FlxState {

	// Public so they can be used by other objects
	public var bullets:FlxGroup;
	public var enemyBullets:FlxGroup;
	var enemies:FlxGroup;
	var player:Player;
	var numberOfEnemies:Int;

	override public function create():Void {
		bullets = new FlxGroup();
		add(bullets);

		enemyBullets = new FlxGroup();
		add(enemyBullets);

		numberOfEnemies = 3;

		enemies = new FlxGroup();
		for (i in 0...numberOfEnemies) {
			// The for loop can be used to position the enemies by multiplying i (the iterator) by an amount to move
			enemies.add(new Enemy(FlxG.random()*(FlxG.width-120), i * 80));
		}
		add(enemies);

		player = new Player(FlxG.width/2-20, FlxG.height-20);
		add(player);
		super.create();
	}
	
	override public function update():Void {
		FlxG.overlap(enemies, bullets, hitEnemy);
		FlxG.overlap(player, enemyBullets, hitPlayer);

		if (numberOfEnemies == 0){
			FlxG.switchState(new Screen3());
		}

		super.update();
	}	

	public function hitEnemy(enemy:Enemy, bullet:Bullet):Void{
		enemy.kill();
		bullet.kill();
		numberOfEnemies--;
	}

	// Function which kills the player and ends game
	public function hitPlayer(player:Player, ebullet:EnemyBullet):Void{
		player.kill();
		ebullet.kill();
		FlxG.switchState(new Screen3());
	}
}