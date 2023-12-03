package dumb;

class Human
{
	var instance:Human;
	final exists:Bool = true;
	var heart:Dynamic;
	var born:Bool = true;
	var hasChildren:Bool = false;
	var name:String = ' ';
	var hasWife:Bool = false;
	var brain:Dynamic;
	var iq:Int = 85;

	public function new() {}
}

class Channel
{
	var name:String = '';
	var videos:Dynamic = null;
	var deleted:Bool = false;
	var hasUploadedAnything:Bool = false;
	var subscribers:Int = 0;
	var notUnusualPlanets:Bool = true;
}

class ChinmayShah extends Human
{
	var rebrandedAumSum:Bool = false;
	var startRuiningIt:Bool = false;
	var characterList:Array<String> = ['Mr. Smart', 'AumSum', 'AumBraino', 'ChiVi', 'Arnold', 'Narrator'];

	public static var channelsOwned:Array<String> = ['It\'s AumSum Time', 'AumBraino', 'AumSum - Hindi'];

	public function new()
	{
		trace("It's AumSum Time!");
		if (exists)
		{
			iq = 82;
			hasWife = true;
			name = 'Chinmay Shah';
			born = true;
			hasChildren = true;
		}

		update();

		channelsOwned = ['It\'s AumSum Time', 'AumSum - What If', 'AumSum - Imagine'];

		makeUnusualPlanets();

		super();
	}

	public function update()
	{
        @:privateAccess
		if (!startRuiningIt)
			iq++;
	}

	var sawSolarBalls:Bool = false;
	var madeItWorse:Bool = false;

	var killOffMostOfTheirShorts:Bool = false;

	public function makeUnusualPlanets():Void
	{
		sawSolarBalls = true;
		iq--;
		startRuiningIt = true;
		channelsOwned = ['It\'s AumSum Time', 'AumSum - What If', 'Unusual Planets'];

		var onlyMakeDumbWhatIfs:Bool = true;
		rebrandedAumSum = true;
		if (rebrandedAumSum)
		{
			while (onlyMakeDumbWhatIfs)
				madeItWorse = true;
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

			if (madeItWorse)
			{
				noMoreJeah();
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

        return;
	}
}
