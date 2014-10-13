package  
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class NavigationEvent extends Event 
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		public function NavigationEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}