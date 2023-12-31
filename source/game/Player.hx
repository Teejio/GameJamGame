package game;

import flixel.FlxSprite;

class Player extends FlxSprite
{
	var movement:Float = 0;
	var movementy:Float = 0;

	public var invincibilityFrames:Float = 2;

	public var isSpeeding:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		//  drag.x = 700;

		//   drag.y = 700;
		loadGraphic("assets/images/game/player.png");
		centerOffsets();
		updateHitbox();
		health = 3;
	}

	override public function update(elapsed:Float)
	{
		// trace(health, invincibilityFrames);
		super.update(elapsed);
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
				// color = FlxColor.ORANGE;
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

		if (health < 1)
		{
			PlayState.instance.hudWindow.close();
			FlxG.switchState(new DeathState());
		}

		invincibilityFrames = invincibilityFrames - elapsed;
	}

	public function hurtMe()
	{
		if (invincibilityFrames < 0)
		{
			health -= 1;
			trace("health: " + health);
			FlxG.camera.shake(0.03, 0.5, true);
			FlxG.camera.flash(FlxColor.RED, 0.5, true);
			invincibilityFrames = 2;
		}
	}
}
