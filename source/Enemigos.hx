package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Enemigos extends FlxSprite
{
	private var auxContSeg:Int = 0;
	private var puedeDisparar:Bool;
	private var direccion:String;
	private var decender:Bool = false;
	private var justoBajo:Bool = false;
	public function new(tipoEnemigo:Int,_puedeDisparar:Bool,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		puedeDisparar = _puedeDisparar;
		direccion = "derecha";
		switch(tipoEnemigo)
		{
			case 1:
				loadGraphic(AssetPaths.Enemigo1__1__png);
			case 2:
				loadGraphic(AssetPaths.Enemigo1__2__png);
			case 3:
				loadGraphic(AssetPaths.Enemigo1__3__png);
			case 4:
				loadGraphic(AssetPaths.Enemigo1__4__png);		
		}					
	}
	public function updateEnemigos(_arrayEnemigos:Array<Enemigos>)
	{
		puedeDisparar = checkPuedeDisparar(_arrayEnemigos);
		mover();
	}
	public function mover()
	{
		if (!decender) 
		{
			if (direccion == "derecha")
			x += 10;
			else if (direccion == "izquierda")
			x -= 10;	
			justoBajo = false;
		}
		else if (!justoBajo && decender)
		{
			y += 10;
			decender = false;
			justoBajo = true;
		}	
	}
	private function checkPuedeDisparar(_arrayEnemigos:Array<Enemigos>):Bool
	{
		for (i in 0..._arrayEnemigos.length) 
		{
			if (y + Reg.heightEnemigos + Reg.espacioEntreEnem == _arrayEnemigos[i].y && x == _arrayEnemigos[i].x)
				return false;
			
		}
		return true;
	}
	public function checkDireccion():Bool
	{
		if (x + Reg.widhtEnemigos >= FlxG.width || x <= 0)
			return true;
		else
			return false;
	}
	public function cambiarDireccion():Void
	{
		if (!justoBajo)
		{
			decender = true;
		if (direccion == "derecha")
			direccion = "izquierda";
		else if (direccion == "izquierda")
			direccion = "derecha";
		}
	}
	public function setPuedeDisparar(_puedeDisparar:Bool):Void
	{
		puedeDisparar = _puedeDisparar;
	}
	public function getPuedeDisparar():Bool
	{
		return puedeDisparar;
	}
	public function destruir():Void
	{
		destroy();
	}
}