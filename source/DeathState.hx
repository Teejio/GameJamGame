class DeathState extends FlxState
{
	var deathText:FlxText;

	var timer:Float = 0;

	override function create()
	{
		deathText = new FlxText(0, -150, FlxG.width, "You Died!", 50);
		deathText.alignment = "center";
		add(deathText);

		var menu = new CustomButton((FlxG.width / 2) - 60, (FlxG.height + 200), 90, 40, "Back To Menu", function()
		{
			FlxG.switchState(new TitleState());
		});
		add(menu);

		FlxTween.tween(deathText, {y: 50, x: 0}, 2.5, {ease: FlxEase.backOut});
		FlxTween.tween(menu, {y: (FlxG.height / 2), x: (FlxG.width / 2) - 60}, 2.5, {ease: FlxEase.backOut});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timer += elapsed;

		if (timer > 2)
		{
			deathText.y = 50;
			deathText.y += Math.cos((timer - 2.5) / 1.2) * 10;
		}
	}
}
