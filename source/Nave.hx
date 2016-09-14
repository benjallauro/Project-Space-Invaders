package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class Nave extends FlxSprite
{
	var vida:Int = 3;
	private var disparo:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);		
		loadGraphic(AssetPaths.NaveAnim__png,true,14,14);
		animation.add("idle", [0, 1], 4, true);
		animation.play("idle");
		x = (FlxG.width / 2) - width / 2;
		y = 120;
	}
	public function GetX()
	{
		return x;
	}	
	public function GetY()
	{
		return y;
	}	
	public function getVida():Int
	{
		return vida;
	}
	public function daniar() : Void
	{
		trace("nave daniada");
		vida--;
		Reg.score-= 50;
		if (vida == 0)
		FlxG.sound.play(AssetPaths.Death__wav);
	}
	public function getDisparo():Bool
	{
		return disparo;
	}
	public function setDisparo(_disparo:Bool):Void
	{
		disparo = _disparo;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.x = 0;
		if ((FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) && x < (FlxG.width - width)) //MOVIMIENTO HORIZONTAL DE LA NAVE (controles y velocidad).
			velocity.x = 100;
		else if ((FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) && x >= 0)
			velocity.x = -100;
	}
}