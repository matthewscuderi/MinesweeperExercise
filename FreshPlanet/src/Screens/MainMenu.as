package Screens 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import feathers.controls.Label;
	import feathers.controls.Button;
	
	import Screens.GameBoard;
	
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class MainMenu extends BaseScreen 
	{
		private var easyBtn:Button;
		private var medBtn:Button;
		private var hardBtn:Button;
		private var titleLabel:TextField;
		private var instructLabel:TextField;
		
		public function MainMenu() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		public function addedToStage(event:Event):void
		{
			trace("Main menu added to stage");
			
			this.titleLabel = new TextField(150, 40, "Minesweeper", "Verdana", 30);
			this.titleLabel.autoScale = true;
			this.titleLabel.x = (this.stage.stageWidth - this.titleLabel.width) / 2;
			this.titleLabel.y = 60;
			
			this.addChild(titleLabel);
			
			this.instructLabel = new TextField(320, 400, "");
			this.instructLabel.x = (this.stage.stageWidth - this.instructLabel.width) / 2;
			this.instructLabel.y = (this.stage.stageHeight - this.instructLabel.height) / 2 - 100;
			this.instructLabel.hAlign = HAlign.LEFT;
			
			this.instructLabel.text = "Instructions:\nClick on a tile to open it and surrounding tiles up.\nNumbers give you a hint to how many mines are next to the tile.\nShift-click on a tile to mark it with a flag.\nYou lose when you click on a mine.\nTo win, you need to flag all the mines.";
			this.addChild(instructLabel);
			
			setUpMenu();
			
		}
		
		private function setUpMenu():void
		{
			var buttonWidth:int = 150;
			var buttonHeight:int = 40;
			
			this.easyBtn = new Button();
			this.easyBtn.label = "Easy - 10 mines 9x9";
			this.easyBtn.setSize(buttonWidth, buttonHeight);
			
			this.easyBtn.validate();
			this.easyBtn.x = (this.stage.stageWidth - this.easyBtn.width) / 2;
			this.easyBtn.y = 60 + (this.stage.stageHeight - this.easyBtn.height) / 2;
			this.easyBtn.addEventListener(Event.TRIGGERED, buttonPressed);
			this.addChild( easyBtn );
			
			this.medBtn = new Button();
			this.medBtn.label = "Medium - 30 mines 15x10";
			this.medBtn.setSize(buttonWidth, buttonHeight);
			
			this.medBtn.validate();
			this.medBtn.x = (this.stage.stageWidth - this.medBtn.width) / 2;
			this.medBtn.y = 100 + (this.stage.stageHeight - this.medBtn.height) / 2;
			this.medBtn.addEventListener(Event.TRIGGERED, buttonPressed);
			this.addChild( medBtn );
			
			this.hardBtn = new Button();
			this.hardBtn.label = "Hard - 60 mines 20x15";
			this.hardBtn.setSize(buttonWidth, buttonHeight);
			
			this.hardBtn.validate();
			this.hardBtn.x = (this.stage.stageWidth - this.hardBtn.width) / 2;
			this.hardBtn.y = 140 + (this.stage.stageHeight - this.hardBtn.height) / 2;
			this.hardBtn.addEventListener(Event.TRIGGERED, buttonPressed);
			this.addChild( hardBtn );
		}
		
		private function buttonPressed(event:Event):void
		{
			var btn:Button = Button(event.currentTarget);
			if (btn == easyBtn)
				createGame(10, 9, 9);
			else if (btn == medBtn)
				createGame(30, 10, 15);
			else if (btn == hardBtn)
				createGame(60, 15, 20);
		}
		
		private function createGame(numMines:int, rows:int, col:int):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { id:"play", mines:numMines, rows:rows, col:col } ));
		}
		
	}

}