package dumb;

class Organ
{
	var alive:Bool = false;

	public function new(alive:Bool)
	{
		alive = true;
		this.alive = alive;
	}

	public function destroy()
	{
		alive = false;
	}
}

class Human
{
	var instance:Human;
	var exists:Bool = false;
	var heart:Organ;
	var location:String = null;
	var born:Bool = true;
	var hasChildren:Bool = false;
	var name:String = ' ';
	var hasWife:Bool = false;
	var brain:Organ;
	var lungs:Organ;
	var gender:String = 'male';
	var age:Float = null; // idfk anymore :/
	var stomach:Organ;
	var skin:Organ;
	var bones:Organ;
	var limbAmount:Int = 4;
	var mood:Dynamic = null;
	
	var dateOfBirth:Array<Dynamic> = [1, 1, 1969];

	public var iq:Int = null;

	public function new(gender:String, name:String, location:String)
	{
		if (iq != null)
			iq = 89;

		brain = new Organ(true);
		lungs = new Organ(true);
		heart = new Organ(true);
		stomach = new Organ(true);
		skin = new Organ(true);
		bones = new Organ(true);

		this.gender = gender;
		this.name = name;
		this.location = location;
	}

	public function update() {};
}

class YTChannel
{
	public var instance:YTChannel;
	public var name:String = '';
	var videos:Dynamic = null;
	public var deleted:Bool = false;
	var hasUploadedAnything:Bool = false;
	public var subscribers:Int = 0;

	var bio:String = null;

	public var notUnusualPlanets:Bool = true;

	public function new()
	{
		if (!deleted)
			name = "It's AumSum Time";
	}

	public var views:Int;
	public var likes:Int;

	private var dislikes:Int;

	public function uploadVideo(videoName:String = ' ', isBad:Bool = false):Void
	{
		hasUploadedAnything = true;
		videos = videoName;
		subscribers++;
		if (!isBad)
		{
			likes++;
			dislikes--;
		}
	}
}

class ChinmayShah extends Human
{
	private var rebrandedAumSum:Bool = false;
	var startRuiningIt:Bool = false;
	public var characterList:Array<String> = ['Mr. Smart', 'AumSum', 'AumBraino', 'ChiVi', 'Arnold', 'Narrator'];

	private var cringe:Float = 0.1;

	public var channel:YTChannel;

	public static var channelsOwned:Array<String> = ["It's AumSum Time", 'AumBraino', 'AumSum - Hindi'];

	private function exist()
	{
		exists = true;
		mood = 'nice';
	}

	public function new()
	{
		trace("It's AumSum Time!");
		exist();
		if (exists)
		{
			iq = 82;
			hasWife = true;
			name = 'Chinmay Shah';
			born = true;
			hasChildren = true;
		}
		channel = new YTChannel();

		update();

		channelsOwned = ['It\'s AumSum Time', 'AumSum - What If', 'AumSum - Imagine'];
		cringe += 12.2;

		channel.uploadVideo("What If AumSum Disappeared?", true);

		makeUnusualPlanets();

		super('male', 'Chinmay Shah', 'India');
	}

	public override function update()
	{
        @:privateAccess
		if (!startRuiningIt)
		{
			iq++;
			cringe += 5.7;
		}

		super.update();
	}

	var sawSolarBalls:Bool = false;
	var unusualPlanets:YTChannel;
	var madeItWorse:Bool = false;

	var killOffMostOfTheirShorts:Bool = false;

	public function makeUnusualPlanets():Void
	{
		sawSolarBalls = true;
		iq--; // now dumber.
		trace('kill everyone, freaking hell');
		startRuiningIt = true;
		channelsOwned = ['It\'s AumSum Time', 'AumSum - What If', 'Unusual Planets'];

		unusualPlanets = new YTChannel();
		unusualPlanets.notUnusualPlanets = false;
		unusualPlanets.subscribers++;
		unusualPlanets.likes++;
		var onlyMakeDumbWhatIfs:Bool = true;
		// I wish, I wish...
		rebrandedAumSum = true;
		if (rebrandedAumSum)
		{
			while (onlyMakeDumbWhatIfs)
				madeItWorse = true; // Oh oh.
			channelsOwned = [
				'It\'s AumSum Time',
				'AumSum - What If',
				'Unusual Planets',
				'Unusual Guyz',
				'Unusual Shortz',
				'Jeah Zoey',
				'Baloo Bruce',
				'SuperheroesClub',
				'Daisy Dean'
			];

			// what if, what if, the moon exploded?

			// that'd be crazy, aumsum. aumsum, let me explain.
			if (madeItWorse)
			{
				noMoreJeah();
			}
			var suicide:Bool = false;
			if (suicide)
			{
				destroy();
			}
		}
	}

	function noMoreJeah():Void
	{
		trace('cry about it!');
		channelsOwned = [
			'It\'s AumSum Time',
			'AumSum - What If',
			'Unusual Planets',
			'Unusual Guyz',
			'Unusual Shortz',
			'Baloo Bruce'
		];

		killOffMostOfTheirShorts = true; // IM SO EVIL >:D

		trace("He's never gonna get it.");
		return; // he's never gonna get it.
	}

	var dead:Bool = false;

	public function destroy()
	{
		trace('suffocating...');
		dead = true;
		if (dead)
		{
			channel.deleted = true;
			unusualPlanets.deleted = true;
		}
	}
}
