class Power extends FlxSprite
{
	public var type:String;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		if (Math.random() > 0.95)
		{
			type = "super";
			loadGraphic("assets/images/game/super.png");
		}
		else if (Math.random() > 0.5)
		{
			type = "health";
			loadGraphic("assets/images/game/health.png");
		}
		else
		{
			type = "fuel";
			loadGraphic("assets/images/game/fuel.png");
		}

		velocity.x = (Math.random() - 0.5) * 1000;
		velocity.y = (Math.random() - 0.5) * 1000;

		centerOffsets();
		updateHitbox();
	}

	override public function update(elapsed:Float)
	{
		if (FlxMath.distanceBetween(this, PlayState.player) < 95)
		{
			if (type == "super")
			{
				PlayState.player.health = 5;
			}
			else if (type == "health")
			{
				if (PlayState.player.health != 5)
				{
					PlayState.player.health += 1;
				}
			}
			else
			{
				if (PlayState.boostper < 4)
				{
					PlayState.boostper += 1;
				}
				else
				{
					PlayState.boostper = 5;
				}
			}

			super.update(elapsed);
			kill();
		}
	}

	override public function kill()
	{
		PlayState.instance.remove(this, true);
		if (this != null)
		{
			PlayState.instance.emitParticle(x + width, y + width, FlxColor.BLUE, 1);
		}

		PlayState.player.invincibilityFrames = 0.1;

		FlxG.camera.shake(0.01, 0.3, true);
		// PlayState.enemyGroup.remove(this);
		super.kill();
	}
}
