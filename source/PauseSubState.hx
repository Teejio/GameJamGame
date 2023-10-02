import flixel.FlxSubState;
import lime.app.Application;
import TitleState;


class PauseSubState extends FlxSubState {



    public function new() {

        super();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }


    var time = 1;


	var timer:Float = 0;

	var astro:FlxSprite;




    var easeFunc = FlxEase.expoOut;
    override public function create() {


        super.create();

		

        var bg = new FlxSprite(0,0).makeGraphic(640,480, FlxColor.PURPLE);

        bg.alpha = 0.5;
        
        add(bg);


		astro = new FlxSprite(FlxG.width, 0).loadGraphic(Paths.image("Astro"));

		add(astro);

		astro.scale.x = astro.scale.y = 0.35;

		astro.updateHitbox();
		astro.screenCenter(Y);
		astro.y += 100;

		var cont = new CustomButton(50, 100 , 100, 40, "Continue", function()
		{
			FlxG.mouse.visible = false;
			close();
		});

		add(cont);
		var restart = new CustomButton(60, 150, 100, 40, "Restart", function()
		{
			FlxG.mouse.visible = false;
			PlayState.instance.hudWindow.close();
			FlxG.switchState(new PlayState());
		});
        
		add(restart);

		var exit = new CustomButton(70, 200, 99, 40, "Title", function()
		{
			PlayState.instance.hudWindow.close();
			FlxG.switchState(new TitleState());
			Application.current.window.borderless = false;
            close();
		});

		add(exit);

		var close = new CustomButton(80, 250, 101, 40, "Close Game", function()
		{
			PlayState.instance.hudWindow.close();
			Application.current.window.close();
		});

		add(close);


		cont.cameras = exit.cameras = close.cameras = restart.cameras =  [FlxG.cameras.list[FlxG.cameras.list.length - 1]];


		FlxTween.tween(cont, {y: 120, x: 50}, time, {ease: easeFunc});
		FlxTween.tween(restart, {y: 190, x: 75}, time * 1.1, {ease: easeFunc});
		FlxTween.tween(exit, {y: 260, x: 100}, time * 1.2, {ease: easeFunc});
		FlxTween.tween(close, {y: 330, x: 125}, time * 1.3, {ease: easeFunc});

		FlxTween.tween(astro, {x: FlxG.width - 300}, 1.0, {ease: FlxEase.expoOut});

    }

	override public function update(elapsed:Float)
		{
			super.update(elapsed);
	
			timer += elapsed;
	
			astro.angle += elapsed * 3.7;
	

			
			if (timer > 1.0)
			{
				astro.x = FlxG.width - 300;
				astro.x += Math.sin(timer - 3) * 30;

			}
		}
}