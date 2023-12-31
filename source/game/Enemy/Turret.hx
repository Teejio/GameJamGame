package game.enemy;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;
import game.Bullet;

class Turret extends Enemy
{
	private var tween:FlxTween;

	var time:Float = 0;
	var attackCooldown:Float = 7.5;

	public function new(x:Float, y:Float, colorA:Int)
	{
		super(x, y, colorA);

		moveSpeed = 0;

		time = Math.random() * attackCooldown;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		time += elapsed;

		if (time > attackCooldown)
		{
			time = 0;
			attack();
		}
	}

	function attack()
	{
		tween = FlxTween.angle(this, 0, 180045, 3.0, {ease: FlxEase.quadOut, onComplete: attackFinished});
	}

	function attackFinished(tween:FlxTween)
	{
		var offset = 30;

		PlayState.instance.emitParticle(x + width, y + width, FlxColor.WHITE, 2);
		var leftBullet = new Bullet(x + offset, y + offset, -200, 0);
		var downBullet = new Bullet(x + offset, y + offset, 0, 200);
		var upBullet = new Bullet(x + offset, y + offset, 0, -200);
		var rightBullet = new Bullet(x + offset, y + offset, 200, 0);

		tween = FlxTween.angle(this, 45, 0, 2.0, {ease: FlxEase.expoOut});
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
