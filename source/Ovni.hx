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
		makeGraphic(14, 5, FlxColor.GREEN);
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
		//Acá se pondria la suma de puntuación (o en el PlayState).
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