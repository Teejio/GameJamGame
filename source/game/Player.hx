package game;

import flixel.FlxSprite;

class Player extends FlxSprite
{
	var movement:Float = 0;
	var movementy:Float = 0;

	public var hp = 3;

	public var invincibilityFrames:Float = 2;

	public var isSpeeding:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		//  drag.x = 700;

		//   drag.y = 700;
		makeGraphic(100, 100, FlxColor.GREEN);
		centerOffsets();
		updateHitbox();
		health = 3;
	}

	override public function update(elapsed:Float)
	{
		// trace(health, invincibilityFrames);

		movement = 0;
		movementy = 0;

		if ((PlayState.boostper > 0))
		{
			if (FlxG.keys.anyPressed([A, LEFT]))
			{
				movement -= 1;
				PlayState.boostper -= 0.2 * elapsed;
			}
			if (FlxG.keys.anyPressed([D, RIGHT]))
			{
				movement += 1;
				PlayState.boostper -= 0.2 * elapsed;
			}

			if (FlxG.keys.anyPressed([W, UP]))
			{
				movementy -= 1;
				PlayState.boostper -= 0.2 * elapsed;
			}
			if (FlxG.keys.anyPressed([S, DOWN]))
			{
				movementy += 1;
				PlayState.boostper -= 0.2 * elapsed;
			}

			color = FlxColor.WHITE;
			isSpeeding = false;
			if (FlxG.keys.anyPressed([SPACE]))
			{
				isSpeeding = true;
				movementy *= 3.5;
				movement *= 3.5;
				color = FlxColor.ORANGE;
				PlayState.boostper -= 1.2 * elapsed;
			}
		}

		if ((movement != 0) && (movementy != 0))
		{
			movement *= 0.8;
			movementy *= 0.8;
		}

		var velo = Math.sqrt((movement * movement) + (movementy * movementy));

		velocity.x += movement * 1300 * elapsed;
		velocity.y += movementy * 1300 * elapsed;

		velocity.x *= 0.96;
		velocity.y *= 0.96;

		if (invincibilityFrames > 0)
		{
			color = FlxColor.GRAY;
		}
		else
		{
			color = FlxColor.WHITE;
		}

		super.update(elapsed);

		invincibilityFrames = invincibilityFrames - elapsed;
	}

	public function hurtMe()
	{
		if (invincibilityFrames < 0)
		{
			trace("get hurt");
			health -= 1;
			invincibilityFrames = 2;
		}
	}
}
