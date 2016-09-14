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
	var ovnillegando:Bool = false;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.OvniAnim__png, true,14,5);
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 10, true); 
		animation.play("idle");
		x = 1200;
		y = 2;
	}
	public function revisarLlegada()
	{
		if (ovnillegando == false)
			{
				FlxG.sound.play(AssetPaths.OVNI__wav, 0.1);
				ovnillegando == true;
			}
	}
	public function escape()
	{
		x += 1000;
		trace("El ovni se escapo");
		ovnillegando = false;
	}
	public function recibioDisparo()
	{
		x += 1000;
		Reg.score += 50;
		ovnillegando = false;
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