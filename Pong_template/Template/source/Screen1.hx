package;
//import needed libraries
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxGroup;

class Screen1 extends FlxState { //create class: screen1

	
	var p1: Player1;  //player1 paddle

	var bgImage:FlxSprite; //background image
	public var stars:StarField_Fore;//stars
	public var stars_2:StarField_Fore_2;//stars
	public var stars_back:StarField_Back;//stars

	var sun:Sun; //sun
	var meteor:Meteor;
	var meteor_2:Meteor_2; //meteors
	var ball:Ball;//bouncing ball

	private var top: FlxGroup;
	private var middle: FlxGroup;
	private var bottom: FlxGroup;
	public var win:Bool; //true/false end game/death

	override public function create():Void {

		FlxG.bgColor = 0xffffffff; //WHITE BACKGROUND
	/*
		bgImage = new FlxSprite(0,0, "assets/bgImage.png");
		add(bgImage);
	*/
		win = false;

		stars = new StarField_Fore();
		add(stars);

		stars_back = new StarField_Back();
		add(stars_back);

		stars_2 = new StarField_Fore_2();
		add(stars_2);

		sun = new Sun();
		add(sun);

		meteor = new Meteor();
		add(meteor);

		meteor_2 = new Meteor_2();
		add(meteor_2);

		ball = new Ball(); //bouncing ball
		add(ball);

		p1 = new Player1(); //player1 paddle
		add(p1);

		// Do everything else that FlxState normally does when created
		super.create();
		}
		// Function called every frame
		override public function update():Void {
		// Do everything which FlxState normally does every frame

		if(FlxG.overlap(p1,ball) == true){ //ball collision
			ball.directionX = -1;
		}

		if(FlxG.overlap(p1,ball) == true){ //ball collision
			ball.directionY = -1;
		}

		if(ball.done == true){ //change to kill screen
			FlxG.switchState(new Screen_Kill());
		}

		if(FlxG.overlap(meteor, ball) == true) { //block collision
			meteor.kill();
		}
		if(FlxG.overlap(meteor_2, ball) == true) { //block collision
			meteor_2.kill();
			win = true;
		}
		if(win == true){ //change to kill screen
			FlxG.switchState(new Screen_Win());
		
		}

		super.update();
	}	
}