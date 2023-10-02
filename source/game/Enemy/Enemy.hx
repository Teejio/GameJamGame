package game.enemy;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Enemy extends FlxSprite
{
	public var moveSpeed:Float = 250;
	public var backUpDst:Float = 0;

	public function new(x:Float, y:Float, colorA:Int)
	{
		super(x, y);

		cameras = PlayState.enemyGroup.cameras;

		makeGraphic(80 + Std.int((Math.random() * 10) - 5), 80 + Std.int((Math.random() * 10) - 5), colorA);
		updateHitbox();
	}

	override public function update(elapsed:Float)
	{
		if (PlayState.player != null)
		{
			FlxVelocity.moveTowardsObject(this, PlayState.player, (FlxMath.distanceBetween(this, PlayState.player) < backUpDst) ? -moveSpeed : moveSpeed);
			FlxG.collide(this, PlayState.enemyGroup);
		}

		super.update(elapsed);

		if (FlxMath.distanceBetween(this, PlayState.player) < 80)
		{
			// var speed = (Math.abs(PlayState.player.velocity.x) > Math.abs(PlayState.player.velocity.y)) ? Math.abs(PlayState.player.velocity.x) : Math.abs(PlayState.player.velocity.y);

			if (PlayState.player.isSpeeding)
			{
				PlayState.boostper = 5;

				this.kill();
			}
			else
			{
				PlayState.player.hurtMe();
			}
		}
	}

	override public function kill()
	{

		PlayState.instance.remove(this,true);
		PlayState.enemyGroup.remove(this,true);
		if (this != null)
		{
			PlayState.instance.emitParticle(x + width, y + width, FlxColor.GREEN, 1);
		}

		PlayState.player.invincibilityFrames = 0.1;

		FlxG.camera.shake(0.02,0.4,true);
		// PlayState.enemyGroup.remove(this);
		super.kill();
	}
}
