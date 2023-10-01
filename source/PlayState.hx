package;

import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Rectangle;
import flixel.FlxState;
import flixel.addons.ui.FlxUIBar as FlxBar;
import flixel.effects.particles.FlxEmitter;
import Effect;
import game.Player;
import game.enemy.Archer;
import game.enemy.Enemy;
import game.enemy.Simple;
import game.enemy.Turret;
import lime.app.Application;
import lime.ui.Window;
import tjson.TJSON as Tjson;
using flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	public static var player:Player;

	public var Simple:Simple;

	var spr_levelTxt:Sprite;
	var spr_BoostBar:Sprite;
	var spr_BoostBarBG:Sprite;

	public static var level:Int = 0;

	var GAMECAM:FlxCamera;
	var HUDCAM:FlxCamera;
	var PAUSECAM:FlxCamera;

	var gameWidth:Float;
	var gameHeight:Float;

	public static var enemyGroup:FlxTypedSpriteGroup<Dynamic>;

	public static var boostBar:FlxSprite;
	public static var boostBarBG:FlxSprite;

	var targetwidth:Float;

	public static var hehe:Application;

	var stage:Stage;

	var levelTxt:FlxText;
	public var hudWindow:Window;

	public static var boostper:Float = 5;

	public static var instance:PlayState;


	var cameraCopySprite:FlxSprite;
	var hudGroup:Array<Dynamic> = [];


	override public function create()
	{
		super.create();

		cameraCopySprite = new FlxSprite(0, 0);
		cameraCopySprite.makeGraphic(500, 150, 0, true);
		instance = this;

		boostper = 5;
		stage = new Stage(Application.current.window, FlxColor.BLUE);
		targetwidth = Std.int(1920);

		FlxG.sound.playMusic("assets/music/mus_fullroom.mp3", 1, true);


		Application.current.window.borderless = true;
		GAMECAM = new FlxCamera();
		HUDCAM = new FlxCamera(0, 0, 500, 150);
		PAUSECAM = new FlxCamera();

		HUDCAM.bgColor.alpha = 0;
		PAUSECAM.bgColor.alpha = 0;

		FlxG.cameras.reset(GAMECAM);
		FlxG.cameras.add(HUDCAM, false);
		FlxG.cameras.add(PAUSECAM, false);

		FlxG.camera.zoom = FlxG.width / (targetwidth / 2);

		FlxG.camera.antialiasing = true;

		GAMECAM.bgColor = 0xff040524;

		player = new Player(0, 0);
		add(player);

		enemyGroup = new FlxTypedSpriteGroup<Dynamic>(100);

		add(enemyGroup);

		// player.pixelPerfectRender = true;

		var leveldata = Tjson.parse(File.getContent('assets/data/levels/level${Std.string(level)}.json'));

		var scaleX = targetwidth / 100;
		var scaleY = (stage.fullScreenHeight / 100) * 1.2;

		var parsedata:Array<Array<Dynamic>> = [];

		parsedata = leveldata.obstacles;
		for (item in parsedata)
		{
			var dickhead = new FlxSprite(item[1] * scaleX, item[2] * scaleY).makeGraphic(item[0], item[0], FlxColor.GRAY);
			// dickhead.pixelPerfectRender = true;
			add(dickhead);
		}

		parsedata = leveldata.enemies.simple;
		for (item in parsedata)
		{
			var dickhead = new Simple(item[0] * scaleX, item[1] * scaleY, FlxColor.RED);
			// dickhead.pixelPerfectRender = true;
			enemyGroup.add(dickhead);
		}

		parsedata = leveldata.enemies.turret;
		for (item in parsedata)
		{
			var dickhead = new Turret(item[0] * scaleX, item[1] * scaleY, FlxColor.BROWN);
			// dickhead.pixelPerfectRender = true;
			enemyGroup.add(dickhead);
		}

		parsedata = leveldata.enemies.archer;
		for (item in parsedata)
		{
			var dickhead = new Archer(item[0] * scaleX, item[1] * scaleY, FlxColor.PURPLE);
			// dickhead.pixelPerfectRender = true;
			enemyGroup.add(dickhead);
		}

		levelTxt = new FlxText(0, 10, 0, "Level " + Std.string(level), 15);
		levelTxt.cameras = [HUDCAM];
		levelTxt.x = 250 - (levelTxt.width/2);
		levelTxt.color = FlxColor.WHITE;

		add(levelTxt);

		boostBar = new FlxSprite( 10, 40).makeGraphic(480, 15, FlxColor.PURPLE);

		var boostBarBG = new FlxSprite(5, 35).makeGraphic(490, 25, FlxColor.BLACK);

		boostBar.cameras = [HUDCAM];
		boostBarBG.cameras = [HUDCAM];

		add(boostBarBG);
		add(boostBar);

		//hudGroup.push(levelTxt);
		//hudGroup.push(boostBar);
		FlxG.camera.follow(player, TOPDOWN, 0.3);
		FlxG.camera.minScrollX = -targetwidth;
		FlxG.camera.maxScrollX = targetwidth;

		FlxG.camera.pixelPerfectRender = true;

		FlxG.camera.minScrollY = -stage.fullScreenHeight * 1.2;
		FlxG.camera.maxScrollY = stage.fullScreenHeight * 1.2;
		gameWidth = Application.current.window.display.bounds.width;
		gameHeight = Application.current.window.display.bounds.height;

		HUDCAM.alpha = 0.0005;
	}

	var frame = 0;

	override public function update(elapsed:Float)
	{
		// player.x = Math.round( player.x);
		// player.y = Math.round( player.y);

		boostBar.scale.x = boostper/5;
		boostBar.updateHitbox();

		if (frame == 3)
		{
			hudWindow = Application.current.createWindow({
				title: 'hudBITCH',
				width: 500,
				height: 150,
				borderless: true,
				alwaysOnTop: true
			});
			hudWindow.x = Std.int(gameWidth / 2);

			hudWindow.x -= 250;
			hudWindow.y = 0;

			hudWindow.stage.color = 0x002B2B2B;
			// hudWindow.stage.addChild(HUDCAM.flashSprite);

			Application.current.window.focus();

			spr_levelTxt = new Sprite();
			spr_BoostBar = new Sprite();
			drawHud();

			hudWindow.stage.addChild(spr_levelTxt);
		//	hudWindow.stage.addChild(spr_BoostBar);
		}
		else if (frame > 3)
		{
			drawHud();
		}
		frame++;

		FlxG.camera.zoom = FlxG.width / targetwidth;

		// windowUpdate();
		Application.current.window.move(Std.int((gameWidth / 2) + ((FlxG.camera.scroll.x + (FlxG.width / 2)) * FlxG.camera.zoom) + (FlxG.width / -2)),
			Std.int((gameHeight / 2) + ((FlxG.camera.scroll.y + (FlxG.height / 2)) * FlxG.camera.zoom) + (FlxG.height / -2)));

		// Application.current.window.x = 	Std.int(Application.current.window.x/2);
		super.update(elapsed);

		if (FlxG.keys.anyPressed([X, ESCAPE]))
		{
			openSubState(new PauseSubState());
		}
		// trace(boostBar.scale.x);

		//drawHud();
	}

	override public function draw()
	{
		super.draw();
	}

	public function emitParticle(x:Float, y:Float, color:Int, ?time:Float = 1):Effect
	{
		var particles = new Effect(x, y, 20);

		particles.lifespan.set(0.1, time);
		particles.lifespan.active = true;
		particles.launchMode = FlxEmitterMode.CIRCLE;
		particles.makeParticles(20, 20, color, 50);
		particles.scale.set(1, 1, 1, 1, 4, 4, 8, 8);
		particles.alpha.set(1, 0.8, 0, 0);

		particles.start(true);

		return particles;
		//instance.add(particles);
	}

	function drawHud()
	{



	//	trace(frame);
		cameraCopySprite.fill(0);
		cameraCopySprite.pixels.draw(HUDCAM.canvas);
		  
		var rect = new Rectangle(cameraCopySprite.x, cameraCopySprite.y, cameraCopySprite.width, cameraCopySprite.height);
		spr_levelTxt.graphics.clear();
		spr_levelTxt.scrollRect = rect;
		spr_levelTxt.x = 0;
		spr_levelTxt.y = 0;
		spr_levelTxt.graphics.beginBitmapFill(cameraCopySprite.pixels);
		spr_levelTxt.graphics.drawRect(0, 0, cameraCopySprite.pixels.width, cameraCopySprite.pixels.height);
		spr_levelTxt.graphics.endFill();


	}
}
