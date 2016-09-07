package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Escudo extends FlxSprite
{
	var vida:Int = 5;
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(15, 10, FlxColor.RED);
	}
	
	public function daniar()
	{
		trace("Escudo daniado");
		vida--;
		if (vida <= 0)
		destruirEscudo();
	}
	
	public function destruirEscudo()
	{
		trace("Escudo destruido");
		destroy();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}