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

	var title:FlxSprite;

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

		var exit = new CustomButton(0, 0, 99, 40, "Title", function()
		{
			//PlayState.instance.hudWindow.close();
			FlxG.switchState(new TitleState());
			//Application.current.window.borderless = false;
			//close();
		});

		add(exit);

	}


    function getPage(){


        pageNum = pageNum % 4;

        if (pageNum < 0) {
            pageNum = 3;
        }
		page.loadGraphic(Paths.image('tutorial/${pageNum}'));
    }

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

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
	}
}
