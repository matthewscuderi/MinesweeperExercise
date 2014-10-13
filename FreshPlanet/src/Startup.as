package  
{
	import flash.display.Sprite;
	import starling.core.Starling;
	

	[SWF(width="850", height="650", frameRate="60", backgroundColor="#ffffff")]
	public class Startup extends Sprite
	{
		private var _starling:Starling;

		public function Startup()
		{
			_starling = new Starling(Game, stage);
			_starling.start();
			
		}
	}

}