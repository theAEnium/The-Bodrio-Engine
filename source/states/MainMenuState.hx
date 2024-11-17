package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits',
		'options',
		'mods'
	];

	var camFollow:FlxObject;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var gief:FlxSprite = new FlxSprite().loadGraphic(Paths.image('gief'));
		gief.antialiasing = ClientPrefs.data.antialiasing;
		gief.setGraphicSize(Std.int(gief.width * 0.31));
		gief.x = 150;
		gief.y = -440;
		FlxTween.tween(gief, { y: -490 }, 3.5, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		FlxTween.tween(gief, { x: 140 }, 5, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		var bief:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bief'));
		bief.antialiasing = ClientPrefs.data.antialiasing;
		bief.setGraphicSize(Std.int(bief.width * 0.31));
		bief.x = 385;
		bief.y = -290;
		FlxTween.tween(bief, { y: -340 }, 5, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		FlxTween.tween(bief, { x: 395 }, 3.5, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		var waos:FlxSprite = new FlxSprite().loadGraphic(Paths.image('this'));
		waos.antialiasing = ClientPrefs.data.antialiasing;
		waos.screenCenter();
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bgs'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.5));
		bg.x = 210;
		bg.y = 120;
		FlxTween.tween(bg, { x: -500 }, 17, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});
		add(bg);
		add(gief);
		add(bief);
		add(waos);

		camFollow = new FlxObject(0, 0, 0, 0);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(37, 20 + (i * 141));
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.setGraphicSize(Std.int(menuItem.width * 1));
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			bg.scrollFactor.set(0, scr);
			waos.scrollFactor.set(0, scr);
			bief.scrollFactor.set(0, scr);
			gief.scrollFactor.set(0, scr);
		}

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Bodrio Engine (P.E.)v " + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("PhantomMuff 1.5", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' Proxyram v " + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("PhantomMuff 1.5", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		super.create();

		FlxG.camera.follow(camFollow, null, 9);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;

					if (ClientPrefs.data.flashing)

						FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
							{
							   switch (optionShit[curSelected])
							   {
								  case 'story_mode':
									 MusicBeatState.switchState(new StoryMenuState());
								  case 'freeplay':
									 MusicBeatState.switchState(new FreeplayState());
								  case 'mods':
									 MusicBeatState.switchState(new ModsMenuState());
								  case 'credits':
									 MusicBeatState.switchState(new CreditsState());
								  case 'options':
									 MusicBeatState.switchState(new OptionsState());
									 OptionsState.onPlayState = false;
									 if (PlayState.SONG != null)
									 {
										PlayState.SONG.arrowSkin = null;
										PlayState.SONG.splashSkin = null;
										PlayState.stageUI = 'normal';
									 }
								  default:
									 trace('Unknown menu option: ' + optionShit[curSelected]);
							   }
							});							

					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(menuItems.members[i], {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].animation.play('selected');
		menuItems.members[curSelected].centerOffsets();

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}