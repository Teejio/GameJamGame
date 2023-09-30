package;

import flixel.FlxState;
import flash.display.Stage;
import Player;
import lime.app.Application;

class PlayState extends FlxState
{

	public var player:Player;


	var GAMECAM:FlxCamera;
	var HUDCAM:FlxCamera;
	var PAUSECAM:FlxCamera;

	var gameWidth:Float;
	var gameHeight:Float;

	override public function create()
	{
		super.create();

		Application.current.window.borderless = true;
		GAMECAM = new FlxCamera();
		HUDCAM = new FlxCamera();
		PAUSECAM = new FlxCamera();
		var stage = new Stage(Application.current.window, FlxColor.BLUE);

		HUDCAM.bgColor.alpha = 0;
		PAUSECAM.bgColor.alpha = 0;
	
		FlxG.cameras.reset(GAMECAM);
		FlxG.cameras.add(HUDCAM, false);
		FlxG.cameras.add(PAUSECAM, false);

		GAMECAM.antialiasing = false;

		player = new Player((stage.fullScreenWidth) -  (Application.current.window.width/2) , (stage.fullScreenHeight) - (Application.current.window.height/2 ));
		add(player);

		var dickhead = new FlxSprite(player.x,player.y).makeGraphic(100,100, FlxColor.WHITE);
		add(dickhead);
		GAMECAM.follow(player, 1);

		gameWidth = Application.current.window.display.bounds.width;
		gameHeight = Application.current.window.display.bounds.height;

		
	}

	override public function update(elapsed:Float)
	{




	
		//player.x = Math.round( player.x);
		//player.y = Math.round( player.y);
		super.update(elapsed);

		Application.current.window.x = Std.int((gameWidth/-2) +player.x);
		
		Application.current.window.y = Std.int((gameHeight/-2) + player.y );


		trace(Application.current.window.x);

		if (FlxG.keys.anyPressed([X, ESCAPE])) {

			Application.current.window.close();
		}
	}

	override public function draw()

		{
			super.draw();

			
		}
}
