package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Nave extends FlxSprite
{
	var disparoListo:Bool = true;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		makeGraphic(14, 14, FlxColor.RED);
		
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
	
	public function disparar(pos:Float) //DE MOMENTO, LA NAVE DISPARA UNA SOLA VEZ ¿ALGUNA IDEA PARA SOLUCIONAR ESTO?
		{
			
				var zapp:Disparo = new Disparo();
				zapp.x = pos + (width / 2);
				zapp.y = 110;
				FlxG.state.add(zapp);
				disparoListo = false;
				if (zapp.y < 0)
				disparoListo = true;
			
		}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) //MOVIMIENTO HORIZONTAL DE LA NAVE (controles y velocidad).
		x += 1;
		else if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)
		x -= 1;
		if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.L)
		{
			if (disparoListo == true)
			{
				disparar(x);
			}
		}
		
	}
	
}