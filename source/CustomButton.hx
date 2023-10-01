package ;
 
 import flixel.addons.ui.FlxUIButton;
import  flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

import flixel.tweens.FlxEase.EaseFunction;

class CustomButton extends FlxUIButton{

    private var tweenAlpha:FlxTween;




    private var tweenScale:FlxTween;
    
    private var instance:CustomButton;

    private var buttonIcon:FlxSprite;


    var time = 0.01;

    var scales = 0.2;
    public function new (x:Float , y:Float, w:Float, h:Int, text:String, ?OnClick:() -> Void){



        var icon = new FlxText( 0, 0, 0 ,text, Std.int((w-2) / (text.length/1.4)), true);


		icon.setFormat(Paths.font("main.ttf"), Std.int((w - 2) / (text.length / 2)), FlxColor.BLACK);


        time = 0.01;
        buttonIcon = icon;
        super(x,y, OnClick);
        instance = this;
       
        buttonIcon.drawFrame(true);

        
        loadGraphic(Paths.image("button"));
		instance.scale.x = instance.scale.y = scales;
        instance.updateHitbox();
        alpha =  0.7;

        onOut.callback = function () {

            if (tweenAlpha != null){
                instance.tweenAlpha.cancel();
                instance.tweenScale.cancel();
            }
            
            instance.tweenAlpha = FlxTween.tween(instance, { alpha:0.7}, 0.3,  {
                 ease: FlxEase.quadOut 
                
                });


			instance.tweenScale = FlxTween.tween(instance.scale, {x: scales, y: scales}, 0.3 ,  { 
                ease:FlxEase.quadOut
             });



  
  
        }

        onOver.callback = function () {

            if (tweenAlpha != null){
                instance.tweenAlpha.cancel();
                instance.tweenScale.cancel();
            }
           // FlxG.sound.play(Paths.sound('scrollMenu'));
            instance.tweenAlpha = FlxTween.tween(instance, { alpha:1.0}, 0.3,  { ease:FlxEase.quadOut });
			instance.tweenScale = FlxTween.tween(instance.scale, {x: scales * 1.2, y: scales * 1.2}, 0.3,  { ease:FlxEase.quadOut });
    



        }

    }

    override public function update(elapsed)
        {


            super.update(elapsed);

            time += elapsed;







            if (buttonIcon != null){
                buttonIcon.alpha = instance.alpha;

                buttonIcon.x = instance.x +  (instance.width/2) + (buttonIcon.width/-2);
                buttonIcon.y  = instance.y+  (instance.height/2) + (buttonIcon.height/-2);

               // trace(buttonIcon);
                
            }

        }
        override public function draw():Void
            {
                super.draw();
        
                if (buttonIcon != null){

                  
                    buttonIcon.cameras = cameras;
                    buttonIcon.draw();
                    
                }
    
            }

}

