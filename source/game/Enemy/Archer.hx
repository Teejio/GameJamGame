package game.enemy;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Archer extends Enemy
{
	private var tween:FlxTween;

	var time:Float = 0;
	var attackCooldown:Float = 5;

	public function new(x:Float, y:Float, colorA:Int)
	{
		super(x, y, colorA);

		backUpDst = FlxG.random.int(300, 500);

		time = Math.random() * attackCooldown;
	}

	override public function update(elapsed:Float)
	{
		time += elapsed;

		if ((time > attackCooldown) && (FlxMath.distanceBetween(this, PlayState.player) < 500))
		{
			time = 0;
			attack();
		}

		super.update(elapsed);
	}

	function attack()
	{
		tween = FlxTween.angle(this, 0, -45, 2.0, {ease: FlxEase.quadInOut, onComplete: attackFinished});
	}

	function attackFinished(tween:FlxTween)
	{
		PlayState.instance.emitParticle(x + width, y + width, FlxColor.WHITE, 0.2);
		var bullet = new Bullet(x + (width / 2), y + (height / 2), 0, 0);
		FlxVelocity.moveTowardsObject(bullet, PlayState.player, 800);

		tween = FlxTween.angle(this, -45, 0, 2.0, {ease: FlxEase.expoOut});
	}

	override public function kill()
	{
		if (tween != null)
		{
			tween.cancel();
		}

		super.kill();
	}
}
