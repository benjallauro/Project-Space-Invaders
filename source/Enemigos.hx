package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

class Enemigos extends FlxSprite
{
	private var auxContSeg:Int = 0;
	private var puedeDisparar:Bool;
	private var direccion:String;
	private var decender:Bool = false;
	private var justoBajo:Bool = false;
	private var boolSonido:Bool = true;
	private var disparoEnemigo:FlxSound;
	private var enemigomoviendose1:FlxSound;
	private var enemigomoviendose2:FlxSound;
	
	public function new(tipoEnemigo:Int,_puedeDisparar:Bool,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		puedeDisparar = _puedeDisparar;
		direccion = "derecha";
		enemigomoviendose1 = new FlxSound();
		enemigomoviendose1.loadEmbedded(AssetPaths.enemigomoviendose1__wav);
		enemigomoviendose1.volume = 0.3;
		enemigomoviendose2 = new FlxSound();
		enemigomoviendose2.loadEmbedded(AssetPaths.enemigomoviendose2__wav);
		enemigomoviendose2.volume = 0.3;
		switch(tipoEnemigo)
		{
			case 1:
				{
					loadGraphic(AssetPaths.Enemigo1__1Anim__png, true, 10, 10);
					animation.add("idle", [0, 1], 2, true);
					animation.play("idle");
				}
			case 2:
				{
					loadGraphic(AssetPaths.Enemigo1__2Anim__png, true, 10, 10);
					animation.add("idle", [0, 1, 2], 2, true);
					animation.play("idle");
				}
			case 3:
				{
					loadGraphic(AssetPaths.Enemigo1__3Anim__png, true, 10, 10);
					animation.add("idle", [0, 1], 2, true);
					animation.play("idle");
				}	
		}					
	}
	public function updateEnemigos(_arrayEnemigos:Array<Enemigos>)
	{
		puedeDisparar = checkPuedeDisparar(_arrayEnemigos);
		mover();
	}
	public function mover()
	{
		if (boolSonido = true)
		enemigomoviendose1.play();
		else
		enemigomoviendose2.play();
		
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
		FlxG.sound.play(AssetPaths.enemigodestruido__wav);
		Reg.score += 10;
		Reg.cantEnemigosDestruidos++;
	}
}