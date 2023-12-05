package ui;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import ui.AtlasText.AtlasFont;
import ui.TextMenuList.TextMenuItem;

class PreferencesMenu extends ui.OptionsState.Page
{
	static var save:FlxSave;

	public static var preferences:Map<String, Dynamic> = new Map<String, Dynamic>();

	static var defaultPreferences:Array<Array<Dynamic>> = [
		['naughtyness', 'censor-naughty', true],
		['downscroll', 'downscroll', false],
		['flashing lights', 'flashing-menu', true],
		['camera zooms', 'camera-zoom', true],
		['ghost tapping', 'ghost-tapping', true],
		['note splashes', 'splashes', false],
		// ['hitsounds', 'hitsounds', false],
		['antialiasing', 'antialiasing', true],
		#if !mobile
		['fps counter', 'fps-counter', true], ['memory counter', 'mem-counter', true], ['memory peak counter', 'mem-peak-counter', true],
		#end
		#if (desktop || web)
		['auto pause', 'auto-pause', #if web false #else true #end]
		#end
	];

	var items:TextMenuList;

	var checkboxes:Array<CheckboxThingie> = [];
	var menuCamera:FlxCamera;
	var camFollow:FlxObject;

	public function new()
	{
		super();

		menuCamera = new SwagCamera();
		FlxG.cameras.add(menuCamera, false);
		menuCamera.bgColor = 0x0;
		camera = menuCamera;

		add(items = new TextMenuList());

		for (pref in defaultPreferences)
		{
			createPrefItem(pref[0], pref[1], pref[2]);
		}

		camFollow = new FlxObject(FlxG.width / 2, 0, 140, 70);
		if (items != null)
			camFollow.y = items.selectedItem.y;

		menuCamera.follow(camFollow, null, 0.06);
		var margin = 160;
		menuCamera.deadzone.set(0, margin, menuCamera.width, 40);
		menuCamera.minScrollY = 0;

		items.onChange.add(function(selected)
		{
			camFollow.y = selected.y;
		});
	}

	inline public static function getPref(pref:String):Dynamic
	{
		return preferences.get(pref);
	}

	// easy shorthand?
	inline public static function setPref(pref:String, value:Dynamic):Void
	{
		preferences.set(pref, value);
	}

	public static function initPrefs()
	{
		save = new FlxSave();
		save.bind('preferences', 'charlescatyt');
		if (save.data.preferences != null)
		{
			preferences = cast save.data.preferences;
		}
		for (pref in defaultPreferences)
		{
			preferenceCheck(pref[1], pref[2]);
			prefUpdate(pref[1]);
		}
		savePrefs();
	}

	public static function savePrefs()
	{
		save.data.preferences = preferences;
		save.flush();
	}

	private function createPrefItem(prefName:String, prefString:String, prefValue:Dynamic):Void
	{
		items.createItem(120, (120 * items.length) + 30, prefName, AtlasFont.Bold, function()
		{
			preferenceCheck(prefString, prefValue);

			switch (Type.typeof(prefValue).getName())
			{
				case 'TBool':
					prefToggle(prefString);

				default:
					trace('swag');
			}
		});

		switch (Type.typeof(prefValue).getName())
		{
			case 'TBool':
				createCheckbox(prefString);

			default:
				trace('swag');
		}

		trace(Type.typeof(prefValue).getName());
	}

	function createCheckbox(prefString:String)
	{
		var checkbox:CheckboxThingie = new CheckboxThingie(0, 120 * (items.length - 1), preferences.get(prefString));
		checkboxes.push(checkbox);
		add(checkbox);
	}

	/**
	 * Assumes that the preference has already been checked/set?
	 */
	public function prefToggle(identifier:String)
	{
		var value:Bool = getPref(identifier);
		value = !value;
		preferences.set(identifier, value);
		savePrefs();
		checkboxes[items.selectedIndex].daValue = value;
		prefUpdate(identifier);
	}

	public static function prefUpdate(identifier:String)
	{
		switch (identifier)
		{
			#if desktop
			case 'auto-pause':
				FlxG.autoPause = getPref(identifier);
			#end
			#if !mobile
			case 'fps-counter':
				if (Main.fpsCounter != null)
					Main.fpsCounter.showFPS = getPref(identifier);
			case 'mem-counter':
				if (Main.fpsCounter != null)
					Main.fpsCounter.showMemory = getPref(identifier);
			case 'mem-peak-counter':
				if (Main.fpsCounter != null)
					Main.fpsCounter.showMemoryPeak = getPref(identifier);
			#end
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// menuCamera.followLerp = CoolUtil.camLerpShit(0.05);

		items.forEach(function(daItem:TextMenuItem)
		{
			if (items.selectedItem == daItem)
				daItem.x = 150;
			else
				daItem.x = 120;
		});
	}

	private static function preferenceCheck(identifier:String, defaultValue:Dynamic):Void
	{
		if (getPref(identifier) == null)
			setPref(identifier, defaultValue);
	}
}

class CheckboxThingie extends FlxSprite
{
	public var daValue(default, set):Bool;

	public function new(x:Float, y:Float, daValue:Bool = false)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('checkboxThingie');
		animation.addByPrefix('static', 'Check Box unselected', 24, false);
		animation.addByPrefix('checked', 'Check Box selecting animation', 24, false);

		antialiasing = PreferencesMenu.getPref('antialiasing');

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();

		this.daValue = daValue;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		switch (animation.curAnim.name)
		{
			case 'static':
				offset.set();
			case 'checked':
				offset.set(17, 70);
		}
	}

	function set_daValue(value:Bool):Bool
	{
		if (value)
			animation.play('checked', true);
		else
			animation.play('static');

		return value;
	}
}
