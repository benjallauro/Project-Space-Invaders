package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	private var nubes:Array<Nube>;
	private var zazz:Nave;
	private var arrayEnemigos:Array<Enemigos>;	
	private var arrayDisparos:Array<Disparo> = new Array();
	private var auxContSeg:Int = 0;
	private var shield1:Escudo;
	private var shield2:Escudo;
	private var shield3:Escudo;
	private var ufo:Ovni;
	private var scoreText:FlxText;
	private var gameover:FlxText;
	private var continuar:FlxText;
	private var victoria:FlxText;
	private var vida1:VidasNave;
	private var vida2:VidasNave;
	private var vida3:VidasNave;
	private var lastDefense:FlxSound;
	private var disparoEnemigo:FlxSound;

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
		{
			add(arrayDisparos[i]);
		
		}
			
			
	
	}
	public function crearOvni():Void
	{
			var ufo:Ovni = new Ovni();
			add(ufo);
	}
	public function crearVidas():Void
	{
			vida1= new VidasNave(FlxG.width - 12, FlxG.height - 12);
			vida2= new VidasNave(FlxG.width - 27, FlxG.height - 12);
			vida3= new VidasNave(FlxG.width - 42, FlxG.height - 12);
			add(vida1);
			add(vida2);
			add(vida3);
	}
	public function sacarVidas():Void
	{
		if (zazz.getVida() == 2)
		{
			vida3.destroy();
		}
		else if (zazz.getVida() == 1)
		{
			vida2.destroy();
		}
		else if (zazz.getVida() == 0)
		{
			vida1.destroy();
		}
	}
	public function dispararEnemigos():Void
	{
		for (i in 0...arrayEnemigos.length) 
		{
			if (arrayEnemigos[i].getPuedeDisparar() && FlxG.random.int(1,1) == 1 && Reg.cantDisparosPantalla<Reg.cantDisparosMax) 
			{
				
				//arrayDisparos.push(new Disparo("enemigo", arrayEnemigos[0].x, arrayEnemigos[0].y));
				//arrayDisparos[arrayDisparos.length - 1].disparar(arrayEnemigos[i].x + arrayEnemigos[i].width / 2, arrayEnemigos[i].y + arrayEnemigos[i].height);
				//FlxG.sound.play(AssetPaths.disparoenemigo__wav);
				//add(arrayDisparos[arrayDisparos.length - 1]);
				//Reg.cantDisparosPantalla++;
				//trace("Asdasd");
				
				for (j in 0...arrayDisparos.length) 
				{
					if (arrayDisparos[j].getTipoDisparo() == "enemigo" && !arrayDisparos[j].getActiva()) 
					{
						arrayDisparos[j].disparar(arrayEnemigos[i].x + arrayEnemigos[i].width / 2, arrayEnemigos[i].y + arrayEnemigos[i].height);
						disparoEnemigo.play();
						break;
					}
				}
			}
		}
	}
	public function dispararNave():Void
	{
		//arrayDisparos.push(new Disparo("aliado", zazz.x + zazz.width - zazz.width / 2, zazz.y));
		//arrayDisparos[arrayDisparos.length - 1].disparar(zazz.GetX() + zazz.width / 2 - arrayDisparos[0].width/2, zazz.GetY());
		//zazz.setDisparo(true);
		//add(arrayDisparos[arrayDisparos.length - 1]);
		for (i in 0...arrayDisparos.length) 
		{			
			if (arrayDisparos[i].getTipoDisparo() == "aliado")					
				 arrayDisparos[i].disparar(zazz.GetX() + zazz.width / 2 - arrayDisparos[0].width/2, zazz.GetY());
			
		}

	}
	public function checkColisiones():Void
	{
		for (i in 0...arrayDisparos.length) 
		{
			for (k in 0...arrayDisparos.length) 
			{
				if (FlxG.overlap(arrayDisparos[i],arrayDisparos[k])&&arrayDisparos[i].getTipoDisparo() == "enemigo" && arrayDisparos[k].getTipoDisparo() =="aliado") 
				{
					arrayDisparos[i].resetear();
					arrayDisparos[k].resetear();
					Reg.cantDisparosPantalla--;
				}
			}
			if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], zazz))
			{
				zazz.daniar();
				arrayDisparos[i].resetear();
				sacarVidas();
				trace("zazz");
				Reg.cantDisparosPantalla--;
			}
			//Shield1
			if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield1))
			{
				shield1.daniar();
				arrayDisparos[i].resetear();
				trace("sh1");
				Reg.cantDisparosPantalla--;
			}
			//Shield2
			if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield2))
			{
				shield2.daniar();
				trace("sh2");
				arrayDisparos[i].resetear();
				Reg.cantDisparosPantalla--;
			}
			//Shield3
			if (arrayDisparos[i].getTipoDisparo() == "enemigo" && FlxG.overlap(arrayDisparos[i], shield3))
			{
				shield3.daniar();
				trace("sh3");
				arrayDisparos[i].resetear();
				Reg.cantDisparosPantalla--;
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
						zazz.setDisparo(false);
						
						
					}
					if (FlxG.overlap(arrayDisparos[i], shield1))
					{	
						shield1.daniar();
						arrayDisparos[i].resetear();
						zazz.setDisparo(false);
					}
					if (FlxG.overlap(arrayDisparos[i], shield2))
					{	
						shield2.daniar();
						arrayDisparos[i].resetear();
						zazz.setDisparo(false);
					}
					if (FlxG.overlap(arrayDisparos[i], shield3))
					{	
						shield3.daniar();
						arrayDisparos[i].resetear();
						zazz.setDisparo(false);
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
	private function crearNubes():Void
	{
		nubes = new Array();
		nubes[0] = new Nube(0,0);
		nubes[1] = new Nube(0,60);
		nubes[2] = new Nube(1,100);
		nubes[3] = new Nube(1,20);
		nubes[4] = new Nube(2,50);
		nubes[5] = new Nube(2, 30);
		for (i in 0...nubes.length) 
		{
			add(nubes[i]);
		}
	}
	private function moverNubes():Void
	{
		for (i in 0...nubes.length) 
		{
			nubes[i].updateNube();
			if (FlxG.random.int(1, 30) == 1)
			{
				nubes[i].launch(); 
				
			}
		}
	}
	private function gameLost() : Void
	{
		gameover.visible = true;
		continuar.visible = true;
		lastDefense.stop();
		if (FlxG.keys.justPressed.ENTER) 
		{
			shield1.destroy();
			shield2.destroy();
			shield3.destroy();
			ufo.destroy();
			scoreText.destroy();
			gameover.destroy();
			continuar.destroy();
			lastDefense.destroy();
			FlxG.switchState(new ScoreState());
		}
	}
	public function ganar()
	{
			victoria.visible = true;
			continuar.visible = true;
			ufo.destroy();
			scoreText.destroy();
			gameover.destroy();
			moverNubes();
			lastDefense.stop();
			if (FlxG.keys.justPressed.ENTER) 
			{
				trace("asda");
				shield1.destroy();
				shield2.destroy();
				shield3.destroy();
				continuar.destroy();
				zazz.destroy();
				lastDefense.destroy();
				FlxG.switchState(new ScoreState());
			}
		}
	override public function create():Void
	{
		FlxG.cameras.bgColor = 0xFF1abcc9;	
		Reg.score = 0;
		Reg.cantEnemigosDestruidos = 0;
		Reg.juegoGanado = false;
		super.create();
		crearNubes();
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
		scoreText = new FlxText(0, FlxG.height - 15);
		scoreText.color = 0xffd6ff00;
		scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000);
		scoreText.text = "Score: " + Reg.score;
		scoreText.scale.x = 0.7;
		scoreText.scale.y = 0.7;
		gameover = new FlxText(FlxG.width / 2 - 25, FlxG.height / 2 - 20);
		gameover.scale.x = 2;
		gameover.scale.y = 2;
		gameover.color = 0xFFFF0000;
		gameover.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000);
		gameover.text = "Game Over";
		gameover.visible = false;
		continuar = new FlxText(FlxG.width / 2 - 78 , FlxG.height / 2 );
		continuar.color = 0xFFFF0000;
		continuar.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000);
		continuar.text = "Presiona ENTER para continuar";
		continuar.visible = false;
		victoria = new FlxText(FlxG.width / 2 - 25, FlxG.height / 2 - 20);
		victoria.scale.x = 3;
		victoria.scale.y = 3;
		victoria.color = 0xFFFFFF00;
		victoria.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000);
		victoria.text = "VICTORIA";
		victoria.visible = false;
		crearVidas();
		add(zazz);
		add(shield1);
		add(shield2);
		add(shield3);
		add(ufo);
		add(scoreText);
		add(gameover);
		add(continuar);
		add(victoria);
		FlxG.sound.play(AssetPaths.gamestart__wav);
		lastDefense = new FlxSound();
		lastDefense.loadEmbedded(AssetPaths.Last_Defense__wav);
		lastDefense.volume = 1;
		lastDefense.play();
		disparoEnemigo = new FlxSound();
		disparoEnemigo.loadEmbedded(AssetPaths.disparoenemigo__wav);
		disparoEnemigo.volume = 1;
	}	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (!Reg.juegoGanado)
		{
			moverNubes();
			scoreText.text =  "Score: " + Reg.score;
			auxContSeg++;	
			updateEnemigos();
			
			for (j in 0...arrayDisparos.length) 
				arrayDisparos[j].updateDisparos(zazz, arrayEnemigos);
			checkColisiones();
			if (FlxG.keys.pressed.SPACE && zazz.exists)
			{	
				dispararNave();
			}
			if (ufo.x <= (FlxG.width) + 100)
				ufo.revisarLlegada();
			if (zazz.getVida()==0)
			{
				zazz.destroy();
				gameLost();
			}
			if (Reg.cantEnemigosDestruidos == Reg.cantTotalEnemigos)
			{
				Reg.cantEnemigosDestruidos = 0;
				ganar();
				Reg.juegoGanado = true;
			}
		}
		else 
		{
			ganar();
			zazz.y--;
		}
	}
}
