class JetPack extends FlxSprite
{
	

	public function new(x:Float, y:Float)
	{
		super(x, y);


        velocity.y = 1000;
		//  drag.x = 700;

		drag.y = 700;
		makeGraphic(100, 100, FlxColor.ORANGE);
		centerOffsets();
		updateHitbox();
	


	}


    override public function update(elapsed:Float){

		if (FlxMath.distanceBetween(this, PlayState.player) < 80)
		{

            PlayState.instance.doEnding();

            kill();
		}
    }
}