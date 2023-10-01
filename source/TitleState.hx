package;

import CustomButton;
import PlayState;
import lime.app.Application;

class TitleState extends FlxState
{
	var easeFunc = FlxEase.backOut;
	var time = 2.5;

	var timer:Float = 0;

	var astro:FlxSprite;

	var title:FlxSprite;

	override function create()
	{
		super.create();

		FlxG.sound.playMusic("assets/music/mus_mainmenu.wav", 1, true);

		FlxG.camera.bgColor = 0xff1a0d50;

		astro = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image("Astro"));

		add(astro);

		astro.scale.x = astro.scale.y = 0.35;

		astro.updateHitbox();
		astro.screenCenter(Y);
		astro.y += 100;

		title = new FlxSprite(0, -200).loadGraphic(Paths.image("TitleScreenText"));

		add(title);

		title.scale.x = title.scale.y = 0.35;

		title.updateHitbox();
		title.screenCenter(X);

		var start = new CustomButton(0, FlxG.height + 200, 100, 40, "Start Game", function()
		{
			FlxG.switchState(new PlayState());
		});

		add(start);

		var tutorial = new CustomButton(0, FlxG.height + 300, 99, 40, "How to Play");

		add(tutorial);

		var setting = new CustomButton(0, FlxG.height + 400, 101, 40, "Settings", function (){
			Application.current.window.close();
		});

		add(setting);

		var close = new CustomButton(0, FlxG.height + 500, 98, 40, "Exit Game");

		add(close);

		FlxTween.tween(astro, {x: FlxG.width - 300}, 3.0, {ease: FlxEase.expoOut});
		FlxTween.tween(title, {y: 30}, 3.0, {ease: FlxEase.backOut});

		FlxTween.tween(start, {y: 200, x: 25}, time, {ease: easeFunc});
		FlxTween.tween(tutorial, {y: 265, x: 50}, time, {ease: easeFunc, startDelay: 0.1});
		FlxTween.tween(setting, {y: 330, x: 75}, time, {ease: easeFunc, startDelay: 0.2});
		FlxTween.tween(close, {y: 395, x: 100}, time, {ease: easeFunc, startDelay: 0.3});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timer += elapsed;

		astro.angle += elapsed * 3.7;

		if (timer > 3.0)
		{
			astro.x = FlxG.width - 300;
			astro.x += Math.sin(timer - 3) * 30;

			title.y = 20;
			title.y += Math.cos((timer - 3) / 1.2) * 10;
		}
	}
}
