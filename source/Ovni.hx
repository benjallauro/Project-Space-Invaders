package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Ovni extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.OVNI__png);
		x = 1200;
		y = 2;
	}
	public function escape()
	{
		x += 1000;
		trace("El ovni se escapo");
	}
	public function recibioDisparo()
	{
		x += 1000;
		Reg.score += 50;
		trace("El disparo colisiono con el ovni");
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		x -= 1;
		if (x <= (0 - width))
		escape();
	}
	
}