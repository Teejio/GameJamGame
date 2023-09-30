package;

import flixel.FlxSprite;

class Player extends FlxSprite
{
	var movement:Float = 0;
	var movementy:Float = 0;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		//  drag.x = 700;

		//   drag.y = 700;
		makeGraphic(100, 100, FlxColor.GREEN);
		centerOffsets();
		updateHitbox();
	}

	override public function update(elapsed:Float)
	{
		movement = 0;
		movementy = 0;

		if (FlxG.keys.anyPressed([A, LEFT]))
		{
			movement -= 1;
		}
		if (FlxG.keys.anyPressed([D, RIGHT]))
		{
			movement += 1;
		}

		if (FlxG.keys.anyPressed([W, UP]))
		{
			movementy -= 1;
		}
		if (FlxG.keys.anyPressed([S, DOWN]))
		{
			movementy += 1;
		}

		color = FlxColor.WHITE;
		if (FlxG.keys.anyPressed([SPACE]))
		{
			movementy *= 3.5;
			movement *= 3.5;
			color = FlxColor.ORANGE;
		}

		if ((movement != 0) && (movementy != 0))
		{
			movement *= 0.8;
			movementy *= 0.8;
		}
		velocity.x += movement * 1300 * elapsed;
		velocity.y += movementy * 1300 * elapsed;

		velocity.x *= 0.96;
		velocity.y *= 0.96;

		super.update(elapsed);
	}
}
