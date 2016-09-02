package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
/*
 * Preguntas para Cid:
 * 	- Problema con static en class Reg 
 * 
 */
class PlayState extends FlxState
{
	var zazz:Nave;
	var arrayEnemigos:Array<Enemigos>;	
	var arrayDisparos:Array<Disparo> = new Array();
	public function crearEnemigos():Void
	{
		arrayEnemigos = new Array();
		arrayEnemigos.push(new Enemigos(10, 10));
		for (i in 0...5) 
			arrayEnemigos.push(new Enemigos(arrayEnemigos[arrayEnemigos.length - 1].x + arrayEnemigos[arrayEnemigos.length - 1].width + arrayEnemigos[arrayEnemigos.length - 1].width / 2 , 10));
		arrayEnemigos.push(new Enemigos(10, arrayEnemigos[0].height*2 ));
		for (i in 0...5) 
			arrayEnemigos.push(new Enemigos(arrayEnemigos[arrayEnemigos.length - 1].x + arrayEnemigos[arrayEnemigos.length - 1].width + arrayEnemigos[arrayEnemigos.length - 1].width / 2 , arrayEnemigos[0].height*2));
		for (i in 0...arrayEnemigos.length) 
			add(arrayEnemigos[i]);		
	}
	override public function create():Void
	{
		super.create();	
		crearEnemigos();		
		zazz = new Nave(); 
		arrayDisparos.push(new Disparo("aliado", zazz.GetX() + zazz.width - zazz.width / 2, zazz.GetY()));
		for (i in 0...arrayDisparos.length) 
			add(arrayDisparos[i]);
		add(zazz);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		for (i in 0...arrayEnemigos.length) 
			arrayEnemigos[i].updateEnemigos();				
		for (j in 0...arrayDisparos.length) 
			arrayDisparos[j].update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
		{			
			for (k in 0...arrayDisparos.length) 
			{
				if (arrayDisparos[k].getTipoDisparo() == "aliado")					
					arrayDisparos[k].disparar(zazz.GetX() + zazz.width / 2 - arrayDisparos[0].width/2, zazz.GetY());
			}
		}					
	}
}
