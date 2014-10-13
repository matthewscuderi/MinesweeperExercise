package Screens 
{
	
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class GameOverScreen extends BaseScreen 
	{
		public var win:Boolean;
		
		private var resultsTextField:TextField;
		private var playAgainButton:Button;
		
		public function GameOverScreen() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			
		}
		
		private function playAgainPressed(event:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { id:"playAgain"} ));
		}
		
		public override function displayScreen():void
		{
			this.visible = true;
			
			resultsTextField = new TextField(150, 50, "", "Verdana", 30);
			resultsTextField.autoScale = true;
			if (win)
				resultsTextField.text = "You Win!";
			else
				resultsTextField.text = "You Lose!";
				
			resultsTextField.x = (stage.stageWidth - resultsTextField.width) / 2;
			resultsTextField.y = (stage.stageHeight - resultsTextField.width) /2;
			this.addChild(resultsTextField);
			
			playAgainButton = new Button();
			playAgainButton.label = "Play Again?";
			playAgainButton.setSize(100, 50);
			playAgainButton.x = (stage.stageWidth - playAgainButton.width) / 2;
			playAgainButton.y = (stage.stageHeight - playAgainButton.height) / 2 + 150;
			
			playAgainButton.addEventListener(Event.TRIGGERED, playAgainPressed);
			this.addChild(playAgainButton);
		}
		
		public override function hideScreen():void
		{
			this.visible = false;
			this.removeChildren()
		}
	}

}