package game.enemy;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Boss extends Enemy
{
	private var tween:FlxTween;
	var playstate:PlayState;

	var attack:Bool = false;
	var time:Float = 0;
	var attackCooldown:Float = 10;

	var enemyGroup:FlxTypedSpriteGroup<Dynamic>;

	public function new(x:Float, y:Float, colorA:Int)
	{
		super(x, y, colorA);

		backUpDst = 1000;
		moveSpeed = 200;
	}

	override public function update(elapsed:Float)
	{
		time += elapsed;

		if (time > attackCooldown)
		{
			attack = true;
		}
		if (time > (attackCooldown + 2))
		{
			attackfunc();
		}

		if (attack == true)
		{
			angle = FlxG.random.int(-10, 10);
		}

		super.update(elapsed);
	}

	function attackfunc()
	{
		attack = false;
		time = 0;
		trace("boss attack");

		PlayState.instance.emitParticle(x + width, y + width, FlxColor.WHITE, 0.2);
		var enemychoice = FlxG.random.int(1, 3);

		if (enemychoice == 1)
		{
			playstate.spawnEnemy("simple", x, y);
		}
		else if (enemychoice == 2)
		{
			playstate.spawnEnemy("archer", x, y);
		}
		else if (enemychoice == 3)
		{
			playstate.spawnEnemy("turret", x, y);
		}

		tween = FlxTween.angle(this, -45, 0, 2.0, {ease: FlxEase.expoOut});
	}
}
