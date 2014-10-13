package  
{
	import Screens.MainMenu;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	
	import feathers.themes.AeonDesktopTheme;
	import feathers.system.DeviceCapabilities;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import flash.text.TextFormat;
	
	import NavigationEvent;
	import Screens.GameBoard;
	import Screens.GameOverScreen;
	
	public class Game extends Sprite
	{
		private var mainMenu:MainMenu;
		private var gameBoard:GameBoard;
		private var gameOver:GameOverScreen;
		
		public function Game()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, changeScreen);
		}
		
		public function addedToStage(event:Event):void
		{
			new AeonDesktopTheme();
			
			gameOver = new GameOverScreen();
			gameOver.hideScreen();
			this.addChild(gameOver);
			
			gameBoard = new GameBoard()
			gameBoard.x = 0;
			gameBoard.y = 0;
			gameBoard.hideScreen();
			this.addChild(gameBoard);
			
			mainMenu = new MainMenu();
			this.addChild(mainMenu);
		}
		
		private function changeScreen(event:NavigationEvent):void
		{
			switch(event.data.id)
			{
				case "play":
					var mines:int = event.data.mines;
					var rows:int = event.data.rows;
					var col:int = event.data.col;
					gameBoard.createGameBoard(mines, rows, col);
					gameBoard.displayScreen();
					
					mainMenu.hideScreen();
					gameOver.hideScreen();
					break;
					
				case "gameOver":
					gameOver.win = event.data.win;
					gameOver.displayScreen();
					
					gameBoard.hideScreen();
					mainMenu.hideScreen();
					break;
					
				case "playAgain":
					gameBoard.hideScreen();
					gameOver.hideScreen();
					
					mainMenu.displayScreen();
					break;
			}
		}
	}

}