package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;

class Nave extends FlxSprite
{
	var vida:Int = 3;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);		
		loadGraphic(AssetPaths.zazz__png);
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
	}	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if ((FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) && x < (FlxG.width - width)) //MOVIMIENTO HORIZONTAL DE LA NAVE (controles y velocidad).
			x += 1;
		else if ((FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) && x >= 0)
			x -= 1;
	}
}