package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.CallStack;
import haxe.io.Path;
import lime.app.Application;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.UncaughtErrorEvent;
import openfl.media.Video;
import openfl.net.NetStream;
import sys.FileSystem;
import sys.io.File;
import ui.PreferencesMenu;

class Main extends Sprite
{
	public static var instance:Main;

	var gameWidth:Int = 1280; // Width of the game in pixels.
	var gameHeight:Int = 720; // Height of the game in pixels.
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	#if web
	var framerate:Int = 60; // How many frames per second the game should run at.
	#else
	var framerate:Int = 144; // How many frames per second the game should run at.
	#end
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();
		instance = this;

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	var video:Video;
	var netStream:NetStream;
	private var overlay:Sprite;

	#if !mobile
	public static var fpsCounter:CoolCounter;
	#end

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !debug
		initialState = TitleState;
		#end

		addChild(new FlxGame(gameWidth, gameHeight, initialState, #if (flixel < "5.0.0") zoom, #end framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsCounter = new FPSInfo(10, 3, 0xFFFFFF);
		addChild(fpsCounter);
		#end

		FlxG.save.bind('funkinamp', 'charlescatyt');
		PreferencesMenu.initPrefs();

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
	}

	#if CRASH_HANDLER
	// crash handler made by sqirra-rng
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String = "./crash/" + "cookieEngine_" + Date.now().toString().replace(" ", "_").replace(":", "'") + ".txt";

		for (stackItem in CallStack.exceptionStack(true))
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error ;

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
