package;

import Player;
import flash.display.Stage;
import flixel.FlxState;
import lime.app.Application;
import tjson.TJSON as Tjson;
import  lime.ui.Window;
import flash.display.Sprite;
import  flash.geom.Rectangle;

class PlayState extends FlxState
{
	public var player:Player;
	public static var level:Int = 0;

	var GAMECAM:FlxCamera;
	var HUDCAM:FlxCamera;
	var PAUSECAM:FlxCamera;

	var gameWidth:Float;
	var gameHeight:Float;

	var targetwidth:Float;

	public static var hehe:Application;

	var stage:Stage;

	var hudWindow:Window;


	override public function create()
	{
		super.create();
		 stage = new Stage(Application.current.window, FlxColor.BLUE);
		targetwidth = Std.int(1920);



		Application.current.window.borderless = true;
		GAMECAM = new FlxCamera();
		HUDCAM = new FlxCamera(0,0,300,150);
		PAUSECAM = new FlxCamera();


		HUDCAM.bgColor.alpha = 0;
		PAUSECAM.bgColor.alpha = 0;

		FlxG.cameras.reset(GAMECAM);
		//FlxG.cameras.add(HUDCAM, false);
		FlxG.cameras.add(PAUSECAM, false);

		GAMECAM.zoom = FlxG.width/targetwidth;
	
		GAMECAM.antialiasing = true;

		player = new Player(0,0);
		add(player);


		


		var leveldata = Tjson.parse(File.getContent('assets/data/levels/level${Std.string(level)}.json'));


		var scaleX = targetwidth /100;
		var scaleY = (stage.fullScreenHeight /100 ) * 1.2 ;

		var parsedata:Array<Array<Dynamic>> = [];

		parsedata  = leveldata.obstacles;
		for(item in parsedata){

			var dickhead = new FlxSprite(item[1] * scaleX, item[2]* scaleY).makeGraphic(item[0], item[0], FlxColor.GRAY);
			dickhead.pixelPerfectRender = true;
			add(dickhead);

		}

		parsedata  = leveldata.enemies.simple;
		for(item in parsedata){

			var dickhead = new FlxSprite(item[0] * scaleX, item[1]* scaleY).makeGraphic(80, 80, FlxColor.RED);
			dickhead.pixelPerfectRender = true;
			add(dickhead);

		}

		parsedata  = leveldata.enemies.turret;
		for(item in parsedata){

			var dickhead = new FlxSprite(item[0] * scaleX , item[1]* scaleY).makeGraphic(80, 80, FlxColor.BROWN);
			dickhead.pixelPerfectRender = true;
			add(dickhead);

		}

		parsedata  = leveldata.enemies.archer;
		for(item in parsedata){

			var dickhead = new FlxSprite(item[0] * scaleX, item[1]* scaleY).makeGraphic(80, 80, FlxColor.PURPLE);
			dickhead.pixelPerfectRender = true;
			add(dickhead);

		}

		GAMECAM.follow(player, FlxCameraFollowStyle.NO_DEAD_ZONE);
		GAMECAM.minScrollX = -1920;
		GAMECAM.maxScrollX = 1920;

		GAMECAM.minScrollY = -stage.fullScreenHeight * 1.2;
		GAMECAM.maxScrollY = stage.fullScreenHeight * 1.2;
		gameWidth = Application.current.window.display.bounds.width;
		gameHeight = Application.current.window.display.bounds.height;


		
	}


	var frame = 0;
	override public function update(elapsed:Float)
	{
		// player.x = Math.round( player.x);
		// player.y = Math.round( player.y);


		if (frame == 2){

			hudWindow = Application.current.createWindow({
				title: 'hudBITCH',
				width: 500,
				height: 150,
				borderless: true,    
				alwaysOnTop: true     
			});
			hudWindow.x = Std.int(gameWidth/2);

			hudWindow.x -= 250;
			hudWindow.y = 0;

			hudWindow.stage.color = 0x002B2B2B;
			//hudWindow.stage.addChild(HUDCAM.flashSprite);

            Application.current.window.focus();

			var exampleText = new FlxText(0,0,0, "EXAMPLE YAY",10);

			exampleText.cameras = [HUDCAM];
	
			var imageCool = new Sprite();
			var rect = new Rectangle(exampleText.x, exampleText.y, exampleText.width, exampleText.height);

	
			imageCool.scrollRect = rect;
			imageCool.x = 0;
			imageCool.y = 0;
			imageCool.graphics.beginBitmapFill(exampleText.pixels);
			imageCool.graphics.drawRect(0, 0, exampleText.pixels.width, exampleText.pixels.height);
			imageCool.graphics.endFill();
	
			hudWindow.stage.addChild(imageCool);
	
		}
		frame ++;
		
		GAMECAM.zoom = FlxG.width/targetwidth;

		//windowUpdate();
		Application.current.window.move(Std.int((gameWidth/2)  + ((GAMECAM.scroll.x + (FlxG.width/2)) * GAMECAM.zoom) + (FlxG.width/ -2 )),  Std.int((gameHeight / 2)+ ( (GAMECAM.scroll.y + (FlxG.height/2)) * GAMECAM.zoom) +(FlxG.height/ -2)));



		

		//Application.current.window.x = 	Std.int(Application.current.window.x/2);
		super.update(elapsed);



		if (FlxG.keys.anyPressed([X, ESCAPE]))
		{
			hudWindow.close();
			Application.current.window.close();
		}
		trace(player.y);
	}



	override public function draw()
	{
		
		super.draw();
	}
}
