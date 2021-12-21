package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitBeta:FlxSprite;
	var portraitMad:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitGF:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'good enough':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -95;
				box.y = 390;
			case 'lover':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -95;
				box.y = 390;
			case 'tug-of-war':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -95;
				box.y = 390;
			case 'animal':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -95;
				box.y = 390;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		
		else if(PlayState.SONG.song.toLowerCase() == 'good enough' || PlayState.SONG.song.toLowerCase() == 'lover' || PlayState.SONG.song.toLowerCase() == 'tug-of-war')
		{
			//portraitLeft = new FlxSprite(-600, 60);
			portraitLeft = new FlxSprite(100, 150);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits/annietexto', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'annietext', 24, true);
			portraitLeft.animation.addByPrefix('stop', 'anniestop', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.12));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitLeft2 = new FlxSprite(100, 150); // i did this cuz im stupid
			portraitLeft2.frames = Paths.getSparrowAtlas('portraits/annietexto', 'shared');
			portraitLeft2.animation.addByPrefix('enter', 'annietext', 24, true);
			portraitLeft2.animation.addByPrefix('stop', 'anniestop', 24, false);
			portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.12));
			portraitLeft2.updateHitbox();
			portraitLeft2.scrollFactor.set();
			add(portraitLeft2);
			portraitLeft2.visible = false;
		}
		else if(PlayState.SONG.song.toLowerCase() == 'animal' )
		{
			//portraitLeft = new FlxSprite(-600, 60);
			portraitLeft = new FlxSprite(100, 150);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits/annietexto', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'annietext', 24, true);
			portraitLeft.animation.addByPrefix('stop', 'anniestop', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.12));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitLeft2 = new FlxSprite(100, 150); // i did this cuz im stupid
			portraitLeft2.frames = Paths.getSparrowAtlas('portraits/annietexto', 'shared');
			portraitLeft2.animation.addByPrefix('enter', 'annietext', 24, true);
			portraitLeft2.animation.addByPrefix('stop', 'anniestop', 24, false);
			portraitLeft2.setGraphicSize(Std.int(portraitLeft2.width * PlayState.daPixelZoom * 0.12));
			portraitLeft2.updateHitbox();
			portraitLeft2.scrollFactor.set();
			add(portraitLeft2);
			portraitLeft2.visible = false;
		}

		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}

		else if(PlayState.SONG.song.toLowerCase() == 'good enough' || PlayState.SONG.song.toLowerCase() == 'lover' || PlayState.SONG.song.toLowerCase() == 'tug-of-war')
		{
			//portraitRight = new FlxSprite(0, 60);
			portraitRight = new FlxSprite(750, 250);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/bluetexto', 'shared');
			portraitRight.animation.addByPrefix('enter', 'bluetexto', 24, true);
			portraitRight.animation.addByPrefix('stop', 'bluestop', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.12));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			portraitBeta = new FlxSprite(750, 250);
			portraitBeta.frames = Paths.getSparrowAtlas('portraits/betatexto', 'shared');
			portraitBeta.animation.addByPrefix('enter', 'betatexto', 24, true);
			portraitBeta.animation.addByPrefix('stop', 'betastop', 24, false);
			portraitBeta.setGraphicSize(Std.int(portraitBeta.width * PlayState.daPixelZoom * 0.12));
			portraitBeta.updateHitbox();
			portraitBeta.scrollFactor.set();
			add(portraitBeta);
			portraitBeta.visible = false;

			portraitMad = new FlxSprite(780, 280);
			portraitMad.frames = Paths.getSparrowAtlas('portraits/meantexto', 'shared');
			portraitMad.animation.addByPrefix('enter', 'meantexto', 24, true);
			portraitMad.animation.addByPrefix('stop', 'meanstop', 24, false);
			portraitMad.setGraphicSize(Std.int(portraitMad.width * PlayState.daPixelZoom * 0.12));
			portraitMad.updateHitbox();
			portraitMad.scrollFactor.set();
			add(portraitMad);
			portraitMad.visible = false;

			portraitGF = new FlxSprite(780, 200);
			portraitGF.frames = Paths.getSparrowAtlas('fat update/gf', 'shared');
			portraitGF.animation.addByPrefix('enter', 'GF habla', 24, true);
			portraitGF.animation.addByPrefix('stop', 'GF stop', 24, false);
			portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.15));
			portraitGF.updateHitbox();
			portraitGF.scrollFactor.set();
			add(portraitGF);
			portraitGF.visible = false;
		}
		else if(PlayState.SONG.song.toLowerCase() == 'animal') //i don't like how i made this but im too lazy to change it
		{
			//portraitRight = new FlxSprite(0, 60);
			portraitRight = new FlxSprite(750, 250);
			portraitRight.frames = Paths.getSparrowAtlas('fat update/blutextoasustado', 'shared');
			portraitRight.animation.addByPrefix('enter', 'bluetextoasusado', 24, true);
			portraitRight.animation.addByPrefix('stop', 'bluestop', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.12));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			portraitBeta = new FlxSprite(750, 250);
			portraitBeta.frames = Paths.getSparrowAtlas('fat update/betatextaasustado', 'shared');
			portraitBeta.animation.addByPrefix('enter', 'betatextoasustado', 24, true);
			portraitBeta.animation.addByPrefix('stop', 'betastop', 24, false);
			portraitBeta.setGraphicSize(Std.int(portraitBeta.width * PlayState.daPixelZoom * 0.12));
			portraitBeta.updateHitbox();
			portraitBeta.scrollFactor.set();
			add(portraitBeta);
			portraitBeta.visible = false;

			portraitMad = new FlxSprite(780, 280);
			portraitMad.frames = Paths.getSparrowAtlas('portraits/meantexto', 'shared');
			portraitMad.animation.addByPrefix('enter', 'meantexto', 24, true);
			portraitMad.animation.addByPrefix('stop', 'meanstop', 24, false);
			portraitMad.setGraphicSize(Std.int(portraitMad.width * PlayState.daPixelZoom * 0.12));
			portraitMad.updateHitbox();
			portraitMad.scrollFactor.set();
			add(portraitMad);
			portraitMad.visible = false;

			portraitGF = new FlxSprite(780, 200);
			portraitGF.frames = Paths.getSparrowAtlas('fat update/gf', 'shared');
			portraitGF.animation.addByPrefix('enter', 'GF habla', 24, true);
			portraitGF.animation.addByPrefix('stop', 'GF stop', 24, false);
			portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.15));
			portraitGF.updateHitbox();
			portraitGF.scrollFactor.set();
			add(portraitGF);
			portraitGF.visible = false;
		}
		
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		//portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		//add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'good enough' || PlayState.SONG.song.toLowerCase() == 'lover' || PlayState.SONG.song.toLowerCase() == 'tug-of-war' || PlayState.SONG.song.toLowerCase() == 'animal')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	function endAnimation():Void 
	{
		portraitLeft.animation.play('stop');
		portraitLeft2.animation.play('stop');
        portraitRight.animation.play('stop');
		portraitBeta.animation.play('stop');
		portraitMad.animation.play('stop');
		portraitGF.animation.play('stop');
	}
	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);
		swagDialogue.completeCallback = endAnimation;

		switch (curCharacter)
		{
			case 'dad':
				portraitBeta.visible = false;
				portraitLeft2.visible = false;
				portraitRight.visible = false;
				portraitMad.visible = false;
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'dad2':
				portraitBeta.visible = false;
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitMad.visible = false;
				portraitRight.visible = false;
				if (!portraitLeft2.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitBeta.visible = false;
				portraitMad.visible = false;
				portraitGF.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfbeta':
				portraitLeft.visible = false;
				portraitLeft2.visible = false;
				portraitMad.visible = false;
				portraitRight.visible = false;
				portraitGF.visible = false;
				if (!portraitRight.visible)
				{
					portraitBeta.visible = true;
					portraitBeta.animation.play('enter');
				}
		case 'bfmad':
			portraitLeft.visible = false;
			portraitLeft2.visible = false;
			portraitBeta.visible = false;
			portraitRight.visible = false;
			portraitGF.visible = false;
				if (!portraitRight.visible)
				{
					portraitMad.visible = true;
					portraitMad.animation.play('enter');
				}
		case 'gf':
			portraitLeft.visible = false;
			portraitLeft2.visible = false;
			portraitBeta.visible = false;
			portraitRight.visible = false;  
			portraitMad.visible = false;
			if (!portraitGF.visible)
				{
					portraitGF.visible = true;
					portraitGF.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}