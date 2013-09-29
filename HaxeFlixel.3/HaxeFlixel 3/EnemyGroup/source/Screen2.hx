// Using FlxGroup to store Enemy objects.
// Working with functions
// Better collision

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxGroup;

class Screen2 extends FlxState {

	public var bullets:FlxGroup;
	var enemies:FlxGroup; // Store Enemy objects in this FlxGroup
	var player:Player;
	var numberOfEnemies:Int; // Store the number of enemies. Can be used to end game.

	override public function create():Void {
		super.create();
		bullets = new FlxGroup();
		add(bullets);

		numberOfEnemies = 3;

		enemies = new FlxGroup();

		// A for loop can be used to do something a number of times before continuing
		for (i in 0...numberOfEnemies) {
			enemies.add(new Enemy()); // Add the Enemy objects to the enemies group
		}
		add(enemies);

		player = new Player(FlxG.width/2-20, FlxG.height-20);
		add(player);
	}
	
	override public function update():Void {

		// FlxG.overlap can be used to call a function which we create. Order of enemies and bullets here is important.
		FlxG.overlap(enemies, bullets, hitEnemy);

		// When this hits 0, the game ends
		if (numberOfEnemies == 0){
			FlxG.switchState(new Screen3());
		}

		super.update();
	}	

	// Our function, which is called when a member of enemies and a member of bullets overlap
	// Kill both objects and lower number of enemies
	public function hitEnemy(enemy:Enemy, bullet:Bullet):Void{
		enemy.kill();
		bullet.kill();
		numberOfEnemies--;
	}
}