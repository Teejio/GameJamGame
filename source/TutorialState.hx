package;

import CustomButton;
import PlayState;
import lime.app.Application;

class TutorialState extends FlxState
{
	var easeFunc = FlxEase.backOut;
	var time = 2.5;

	var timer:Float = 0;

	var page:FlxSprite;


	var left:FlxSprite;

	var right:FlxSprite;

    var pageNum = 0;

	override function create()
	{
		super.create();

		FlxG.sound.playMusic("assets/music/mus_mainmenu.wav", 1, true);

		FlxG.camera.bgColor = 0xff1a0d50;

		page = new FlxSprite(0, 0);

		
		getPage();


      //  page.scale.x = page.scale.y = 2;

        page.screenCenter();

		add(page);

		left = new FlxSprite(60, 350).loadGraphic(Paths.image('tutorial/left'));
		right = new FlxSprite(460, 350).loadGraphic(Paths.image('tutorial/right'));


		add(left);
		add(right);
		var exit = new CustomButton(0, 0, 99, 40, "Press Escape", function()
		{
			//PlayState.instance.hudWindow.close();
			FlxG.switchState(new TitleState());
			//Application.current.window.borderless = false;
			//close();
		});

		add(exit);

	}


    function getPage(){


        pageNum = pageNum % 6;

        if (pageNum < 0) {
            pageNum = 5;
        }
		page.loadGraphic(Paths.image('tutorial/${pageNum}'));
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.mouse.visible = false;
		timer += elapsed;

		if (FlxG.keys.anyJustPressed([A, LEFT]))
		{
			pageNum -= 1;
			getPage();
		}
		if (FlxG.keys.anyJustPressed([D, RIGHT]))
		{
            pageNum += 1;
			getPage();
		}


		left.scale.x = 0.5;
		right.scale.x = 0.5;
		left.alpha = 1;
		right.alpha = 1;
		if (FlxG.keys.anyPressed([A, LEFT]))
		{
			left.scale.x = 0.4;

			left.alpha = 0.5;
		}
		if (FlxG.keys.anyPressed([ESCAPE, X]))
		{
			left.scale.x = 0.4;
			FlxG.switchState(new TitleState());
			left.alpha = 0.5;
		}
		if (FlxG.keys.anyPressed([D, RIGHT]))
		{
			right.scale.x = 0.4;

			right.alpha = 0.5;

			

		}

		left.scale.y = left.scale.x;
		right.scale.y = right.scale.x;

	//	left.updateHitbox();
		left.centerOffsets();
		left.centerOrigin();

		//right.updateHitbox();
		right.centerOffsets();
		right.centerOrigin();

	}
}
