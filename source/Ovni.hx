package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Ovni extends FlxSprite
{
	private var ovnillegando:Bool = false;
	private var sonidoOvni:FlxSound;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.OvniAnim__png, true,14,5);
		animation.add("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 10, true); 
		animation.play("idle");
		x = 1200;
		y = 2;
		
		sonidoOvni = new FlxSound();
		sonidoOvni.loadEmbedded(AssetPaths.OVNI__wav);
		sonidoOvni.volume = 1;
	}
	public function revisarLlegada()
	{
		if (ovnillegando == false)
			{
				sonidoOvni.play();
				ovnillegando == true;
			}
	}
	public function escape()
	{
		x += 1000;
		trace("El ovni se escapo");
		ovnillegando = false;
		sonidoOvni.stop();
	}
	public function recibioDisparo()
	{
		x += 1000;
		Reg.score += 50;
		ovnillegando = false;
		trace("El disparo colisiono con el ovni");
		sonidoOvni.stop();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		x -= 1;
		if (x <= (0 - width))
		escape();
	}
	
}