package;

import CustomButton;
import PlayState;
import TutorialState;
import lime.app.Application;
using flixel.util.FlxSpriteUtil;

class WinState extends FlxState
{
	var easeFunc = FlxEase.backOut;
	var time = 2.5;

	var timer:Float = 0;

	var astro:FlxSprite;

	var title:FlxSprite;

	override function create()
	{
		super.create();

		title = new FlxSprite(0, 0).loadGraphic(Paths.image("YouWin"));

		add(title);

		title.screenCenter();

		var start = new CustomButton(500, 10, 100, 40, "Main Menu", function()
		{
			FlxG.switchState(new TitleState());
		});

		add(start);

		

		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

    }
}
