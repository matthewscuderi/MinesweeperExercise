package Screens 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class BaseScreen extends Sprite 
	{
		
		public function BaseScreen() 
		{
			super();
			
		}
		
		public function hideScreen():void
		{
			this.visible = false;
		}
		
		public function displayScreen():void
		{
			this.visible = true;
		}
		
	}

}