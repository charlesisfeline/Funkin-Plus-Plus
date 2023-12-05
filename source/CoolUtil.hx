package;

#if cpp
import cpp.NativeGc;
#elseif hl
import hl.Gc;
#elseif java
import java.vm.Gc;
#elseif neko
import neko.vm.Gc;
#end
import flixel.FlxG;
import flixel.math.FlxMath;
import haxe.CallStack;
import lime.utils.Assets;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	inline public static function quantize(f:Float, snap:Float)
	{
		// changed so this actually works lol
		var m:Float = Math.fround(f * snap);
		trace(snap);
		return (m / snap);
	}

	/* -- codename engine functions i stole!!!! you should check it out tho..... when its done. */
	/**
	 * Deletes a folder recursively
	 * @param delete Path to the folder.
	 */
	public static function deleteFolder(delete:String)
	{
		#if sys
		if (!sys.FileSystem.exists(delete))
			return;
		var files:Array<String> = sys.FileSystem.readDirectory(delete);
		for (file in files)
		{
			if (sys.FileSystem.isDirectory(delete + "/" + file))
			{
				deleteFolder(delete + "/" + file);
				sys.FileSystem.deleteDirectory(delete + "/" + file);
			}
			else
			{
				try
				{
					sys.FileSystem.deleteFile(delete + "/" + file);
				}
				catch (e)
				{
					trace("Could not delete " + delete + "/" + file);
				}
			}
		}
		#end
	}

	/**
	 * Shortcut to parse JSON from an Asset path
	 * @param assetPath Path to the JSON asset.
	 */
	public static function parseJson(assetPath:String)
	{
		return Json.parse(Assets.getText(assetPath));
	}

	/**
	 * Add several zeros at the beginning of a string, so that `2` becomes `02`.
	 * @param str String to add zeros
	 * @param num The length required
	 */
	public static inline function addZeros(str:String, num:Int)
	{
		while (str.length < num)
			str = '0${str}';
		return str;
	}

	/**
	 * Returns a string representation of a size, following this format: `1.02 GB`, `134.00 MB`
	 * @param size Size to convert ot string
	 * @return String Result string representation
	 */
	public static function getSizeString(size:Float):String
	{
		var labels = ["B", "KB", "MB", "GB", "TB", "PB"];
		var rSize:Float = size;
		var label:Int = 0;
		while (rSize > 1024 && label < labels.length - 1)
		{
			label++;
			rSize /= 1024;
		}
		return '${Std.int(rSize) + "." + addZeros(Std.string(Std.int((rSize % 1) * 100)), 2)}${labels[label]}';
	}

	/**
	 * Shortcut to parse a JSON string
	 * @param str Path to the JSON string
	 * @return Parsed JSON
	 */
	public inline static function parseJsonString(str:String)
		return Json.parse(str);

	/**
	 * Whenever a value is NaN or not.
	 * @param v Value
	 */
	public static inline function isNaN(v:Dynamic)
	{
		if (v is Float || v is Int)
			return Math.isNaN(cast(v, Float));
		return false;
	}

	/**
	 * Returns the last of an Array
	 * @param array Array
	 * @return T Last element
	 */
	public static inline function last<T>(array:Array<T>):T
	{
		return array[array.length - 1];
	}

	public static function dashToSpace(string:String):String
		return string.replace("-", " ");

	public static function spaceToDash(string:String):String
		return string.replace(" ", "-");

	public static function swapSpaceDash(string:String):String
		return StringTools.contains(string, '-') ? dashToSpace(string) : spaceToDash(string);

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	function getIntArray(max:Int):Array<Int>
	{
		var arr:Array<Int> = [];
		for (i in 0...max)
		{
			arr.push(i);
		}
		return arr;
	}

	inline public static function listFromString(string:String):Array<String>
	{
		var daList:Array<String> = [];
		daList = string.trim().split('\n');

		for (i in 0...daList.length)
			daList[i] = daList[i].trim();

		return daList;
	}

	public static inline function coolStringFile(path:String):Array<String>
		return [for (i in path.trim().split('\n')) i];

	public static function floorDecimal(value:Float, decimals:Int):Float
	{
		if (decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;
		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	inline public static function runGC():Void
	{
		#if cpp
		NativeGc.compact();
		NativeGc.run(true);
		#elseif hl
		Gc.major();
		#elseif (java || neko)
		Gc.run(true);
		#end
	}

	/**
		Lerps camera, but accountsfor framerate shit?
		Right now it's simply for use to change the followLerp variable of a camera during update
		TODO LATER MAYBE:
			Actually make and modify the scroll and lerp shit in it's own function
			instead of solely relying on changing the lerp on the fly
	 */
	public static function camLerpShit(lerp:Float):Float
	{
		return lerp * (FlxG.elapsed / (1 / 60));
	}

	/*
	 * just lerp that does camLerpShit for u so u dont have to do it every time
	 */
	public static function coolLerp(a:Float, b:Float, ratio:Float):Float
	{
		return FlxMath.lerp(a, b, camLerpShit(ratio));
	}

	inline public static function browserLoad(site:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static function getLastExceptionStack():String
	{
		return CallStack.toString(CallStack.exceptionStack());
	}
}
