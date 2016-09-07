package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var zazz:Nave;
	private var arrayEnemigos:Array<Enemigos>;	
	private var arrayDisparos:Array<Disparo> = new Array();
	private var auxContSeg:Int = 0;
	
	public function crearEnemigos():Void
	{	
		arrayEnemigos = new Array();
		
		arrayEnemigos.push(new Enemigos(false, 10, 10));
		
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem , 10));
		
		arrayEnemigos.push(new Enemigos(false, 10, arrayEnemigos[arrayEnemigos.length - 1].y + Reg.heightEnemigos + Reg.espacioEntreEnem ));
			
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem , arrayEnemigos[0].y + Reg.heightEnemigos + Reg.espacioEntreEnem));
		
		arrayEnemigos.push(new Enemigos(false, 10, arrayEnemigos[arrayEnemigos.length - 1].y + Reg.heightEnemigos + Reg.espacioEntreEnem ));
			
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem, arrayEnemigos[0].y + Reg.heightEnemigos*2 + Reg.espacioEntreEnem*2));
			
		for (i in 0...arrayEnemigos.length) 
			add(arrayEnemigos[i]);
	}	
	public function crearDisparos():Void
	{
		arrayDisparos.push(new Disparo("aliado", zazz.x + zazz.width - zazz.width / 2, zazz.y));		
		for (i in 0...3)
			arrayDisparos.push(new Disparo("enemigo", arrayEnemigos[0].x, arrayEnemigos[0].y));		
		for (i in 0...arrayDisparos.length) 
			add(arrayDisparos[i]);
	}	
	public function dispararEnemigos():Void
	{
		for (i in 0...arrayEnemigos.length) 
		{
			if (arrayEnemigos[i].getPuedeDisparar() && FlxG.random.int(1,5) == 1) 
			{
				for (j in 0...arrayDisparos.length) 
				{
					if (arrayDisparos[j].getTipoDisparo() == "enemigo" && !arrayDisparos[j].getActiva()) 
					{
						arrayDisparos[j].disparar(arrayEnemigos[i].x + arrayEnemigos[i].width / 2, arrayEnemigos[i].y + arrayEnemigos[i].height);
						break;
					}
				}
			}
		}
	}	
	public function checkColisiones():Void
	{
		for (i in 0...arrayDisparos.length) 
		{
			if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], zazz))
			{
				zazz.daniar();
				arrayDisparos[i].resetear();
			}
			
			else if (arrayDisparos[i].getTipoDisparo() == "aliado")
			{
				for (j in 0...arrayEnemigos.length) 
				{
					if (FlxG.overlap(arrayDisparos[i], arrayEnemigos[j]))
					{		
						arrayEnemigos[j].destruir();
						arrayEnemigos.remove(arrayEnemigos[j]);
						arrayDisparos[i].resetear();
					}
				}
			}								
		}
		for (j in 0...arrayEnemigos.length)
		{
			if (FlxG.overlap(arrayEnemigos[j], zazz))
			zazz.daniar();
		}
	}	
	public function updateEnemigos():Void
	{
		if (auxContSeg == 60) 
		{
			for (i in 0...arrayEnemigos.length) 
				arrayEnemigos[i].updateEnemigos(arrayEnemigos);
			for (j in 0...arrayEnemigos.length) 
			{
				if (arrayEnemigos[j].checkDireccion())
				{
					for (k in 0...arrayEnemigos.length) 
					{	
						arrayEnemigos[k].cambiarDireccion();						
					}
					break;
				}
			}
			dispararEnemigos();
			auxContSeg = 0;
		}
	}
	override public function create():Void
	{
		super.create();
		zazz = new Nave();
		crearEnemigos();	
		crearDisparos();		 		
		add(zazz);
	}	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		auxContSeg++;	
		updateEnemigos();
		for (j in 0...arrayDisparos.length) 
			arrayDisparos[j].updateDisparos(zazz, arrayEnemigos);
		checkColisiones();
		if (FlxG.keys.pressed.SPACE && zazz.exists)
		{			
			for (k in 0...arrayDisparos.length) 
			{
				if (arrayDisparos[k].getTipoDisparo() == "aliado")					
					arrayDisparos[k].disparar(zazz.GetX() + zazz.width / 2 - arrayDisparos[0].width/2, zazz.GetY());
			}
		}
	}
}
