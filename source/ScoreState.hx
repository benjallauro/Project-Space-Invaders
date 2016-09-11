package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

/**
 * ...
 * @author ...
 */
class ScoreState extends FlxState
{
	private var scoreText:FlxText;
	private var highscoreText:FlxText;
	private var precioneText:FlxText;
	private var newHighscore:Bool = false;
	private var auxCountSeg:Int = 0;
	private var colorHighscore:Int = 0;
	override public function create():Void
	{
		FlxG.camera.bgColor = 0xFF000000;
		scoreText = new FlxText(50,50);
		scoreText.text = "Tu Score: " + Reg.score;
		if (Reg.checkHighscore()) 
		{
			highscoreText = new FlxText(43,20);
			highscoreText.text = "New Highscore";
			highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFFFF0000);
			highscoreText.scale.x = 1.6;
			highscoreText.scale.y = 1.6;
			add(highscoreText);
			newHighscore = true;
			Reg.highscore = Reg.score;
		}
		precioneText = new FlxText(1, 80);
		precioneText.text = "Precione ENTER para continuar";
		add(scoreText);
		add(precioneText);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		auxCountSeg++;
		if (auxCountSeg == 45 && newHighscore) 
		{
			switch (colorHighscore)
			{
				case 0:
					{
						highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFFd6ff00);
						colorHighscore++;
					}
				case 1:
					{
						highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFF07389f);
						colorHighscore++;
					}
				case 2:
					{
						highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFFFF0000);
						colorHighscore = 0;
					}
			}
			auxCountSeg = 0;
		}
		if (FlxG.keys.justPressed.ENTER) 
		{
			scoreText.destroy();
			if (newHighscore)
				highscoreText.destroy();
			precioneText.destroy();
			FlxG.switchState(new MenuState());
		}   
	}       
}