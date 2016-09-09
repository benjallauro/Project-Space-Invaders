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
	private var shield1:Escudo;
	private var shield2:Escudo;
	private var shield3:Escudo;
	private var ufo:Ovni;
	
	public function crearEnemigos():Void
	{	
		arrayEnemigos = new Array();
		
		arrayEnemigos.push(new Enemigos(1,false, 10, 10));
		
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(1,false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem , 10));
		
		arrayEnemigos.push(new Enemigos(2,false, 10, arrayEnemigos[arrayEnemigos.length - 1].y + Reg.heightEnemigos + Reg.espacioEntreEnem ));
			
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(2,false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem , arrayEnemigos[0].y + Reg.heightEnemigos + Reg.espacioEntreEnem));
		
		arrayEnemigos.push(new Enemigos(3,false, 10, arrayEnemigos[arrayEnemigos.length - 1].y + Reg.heightEnemigos + Reg.espacioEntreEnem ));
			
		for (i in 0...Reg.cantEnemigosPorLinea-1) 
			arrayEnemigos.push(new Enemigos(3,false,arrayEnemigos[arrayEnemigos.length - 1].x + Reg.widhtEnemigos + Reg.espacioEntreEnem, arrayEnemigos[0].y + Reg.heightEnemigos*2 + Reg.espacioEntreEnem*2));
			
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
	public function crearOvni():Void
	{
			var ufo:Ovni = new Ovni();
			add(ufo);
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
			//Shield1
		if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield1))
			{
				shield1.daniar();
				arrayDisparos[i].resetear();
			}
			//Shield2
		if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield2))
			{
				shield2.daniar();
				arrayDisparos[i].resetear();
			}
				//Shield3
		if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield3))
			{
				shield3.daniar();
				arrayDisparos[i].resetear();
			}
		if (FlxG.overlap(arrayDisparos[i], ufo))
			{
				ufo.recibioDisparo();
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
					if (FlxG.overlap(arrayDisparos[i], shield1))
					{	
						shield1.daniar();
						arrayDisparos[i].resetear();
					}
					if (FlxG.overlap(arrayDisparos[i], shield2))
					{	
						shield2.daniar();
						arrayDisparos[i].resetear();
					}
					if (FlxG.overlap(arrayDisparos[i], shield3))
					{	
						shield3.daniar();
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
		for (j in 0...arrayEnemigos.length)
		{
			if (FlxG.overlap(arrayEnemigos[j], shield1))
			shield1.daniar();
		}
		for (j in 0...arrayEnemigos.length)
		{
			if (FlxG.overlap(arrayEnemigos[j], shield2))
			shield2.daniar();
		}
		for (j in 0...arrayEnemigos.length)
		{
			if (FlxG.overlap(arrayEnemigos[j], shield3))
			shield3.daniar();
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
		FlxG.cameras.bgColor = 0xFFFFFFFF;		
		super.create();
		zazz = new Nave();
		shield1 = new Escudo((FlxG.width / 4), 90);
		shield1.x -= shield1.width / 2;
		shield2 = new Escudo((FlxG.width / 2), 90);
		shield2.x -= shield2.width / 2;
		shield3 = new Escudo((FlxG.width / 4) * 3, 90);
		shield3.x -= shield3.width / 2;
		ufo = new Ovni();
		crearEnemigos();	
		crearDisparos();		 		
		add(zazz);
		add(shield1);
		add(shield2);
		add(shield3);
		add(ufo);
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
