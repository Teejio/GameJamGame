import flixel.effects.particles.FlxEmitter;

class Effect extends FlxEmitter {


    var time:Float = 0;


    override function update(elapsed:Float){

        super.update(elapsed);


        time += elapsed;

        if (time > lifespan.max){

            destroy();
        }
    }


}