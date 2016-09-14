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
		scoreText = new FlxText(40, 50);
		scoreText.color = 0xffd6ff00;
		scoreText.text = "Tu Score: " + Reg.score;
		if (Reg.checkHighscore()) 
		{
			highscoreText = new FlxText(43, 20);
			highscoreText.color = 0xffd6ff00;
			highscoreText.text = "New Highscore";
			highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFFFF0000);
			highscoreText.scale.x = 1.6;
			highscoreText.scale.y = 1.6;
			add(highscoreText);
			newHighscore = true;
			Reg.highscore = Reg.score;
		}
		precioneText = new FlxText(1, 80);
		precioneText.color = 0xffd6ff00;
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
						highscoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFF1abcc9);
						colorHighscore++;
					}
				case 1:
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