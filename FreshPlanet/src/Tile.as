package  
{
	import flash.events.MouseEvent;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.text.TextField;
	
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	import NavigationEvent;
	
	import Screens.GameBoard;
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class Tile extends Sprite 
	{
		public var isMine:Boolean;
		public var isOpen:Boolean;
		public var flagged:Boolean;
		public var hasValue:int;
		public var xcoord:int;
		public var ycoord:int;
		
		private var mine:Image;
		private var tile:Image;
		private var tileFlag:Image;
		private var tileBG:Image;
		private var valueTextField:TextField;
		private var button:Button;
		
		private var isShiftPressed:Boolean;
		private var neighborTiles:Array;
		private var gameBoard:GameBoard;
		
		public function Tile(coordx:int = 0, coordy:int = 0) 
		{
			super();
			
			isMine = false;
			isOpen = false;
			hasValue = 0;
			
			xcoord = coordx;
			ycoord = coordy;
			
			this.width = 10;
			this.height = 10;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		private function addedToStage(event:Event):void 
		{
			gameBoard = GameBoard(this.parent);
			
			var tileSize:int = 40;
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			tileBG = new Image(Assets.getTexture("TileBG"));
			tileBG.width = tileSize;
			tileBG.height = tileSize;
			this.addChild(tileBG);
			
			valueTextField = new TextField(tileSize, tileSize, " ");
			this.addChild(valueTextField);
			
			mine = new Image(Assets.getTexture("Mine"));
			mine.visible = false;
			this.addChild(mine);
			
			tile = new Image(Assets.getTexture("Tile"));
			this.addChild(tile);
			
			tileFlag = new Image(Assets.getTexture("TileFlag"));
			tileFlag.visible = false;
			this.addChild(tileFlag);
			
			mine.width = tileSize;
			mine.height = tileSize;
			tile.width = tileSize;
			tile.height = tileSize;
			tileFlag.width = tileSize;
			tileFlag.height = tileSize;
			
			button = new Button(Assets.getTexture("transparent"));
			button.width = tileSize;
			button.height = tileSize;
			button.addEventListener(Event.TRIGGERED, onTileClick);
			this.addChild(button);
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onTileClick(event:Event):void
		{
			if (isShiftPressed)
			{
				tile.visible = !tile.visible;
				tileFlag.visible = !tileFlag.visible;
				flagged = !flagged;
				gameBoard.checkTile(this);
				return;
			}
			
			if (!flagged)
			{
				if (isMine)
				{
					tile.visible = false;
					mine.visible = true;
					
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { id:"gameOver", win:false } ));
				}
				else
				{
					openTile();
				}
			}
			
		}
		
		public function openTile():void
		{
			isOpen = true;
			tile.visible = false;
			this.removeChild(button);
			if (hasValue == 0)
			{
				openNeighbors();
			}
		}
		
		public function openNeighbors():void
		{
			for (var i:int = 0; i < neighborTiles.length; ++i)
			{
				var neighbor:Tile = Tile(neighborTiles[i]);
				if (!neighbor.isMine && !neighbor.isOpen)  // checks to make sure the neighbor isn't a mine and hasn't been opened
					neighbor.openTile();
			}
		}
		
		//Gets an array of the neighboring tiles and counts how many tiles have mines next to it.
		public function setNeighbors(neighbors:Array):void
		{
			this.neighborTiles = neighbors;
			
			var neighboringMines:int = 0;
			for (var i:int = 0; i < neighborTiles.length; ++i)
			{
				var nTile:Tile = Tile(neighborTiles[i]);
				if (nTile != null && nTile.isMine )
					++neighboringMines;
			}
			this.hasValue = neighboringMines;
			if(this.hasValue > 0)
				this.valueTextField.text = "" + this.hasValue;
			else
				this.valueTextField.text = " ";
		}
		
		public function onKeyDown(kbEvent:KeyboardEvent):void
		{
			if (kbEvent.shiftKey && !isShiftPressed)
				isShiftPressed = true;
		}
		
		public function onKeyUp(kbEvent:KeyboardEvent):void
		{
			if(isShiftPressed)
				isShiftPressed = false;
		}
		
		private function removedFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			mine = null;
			tile = null;
			tileFlag = null;
			tileBG = null;
		}
		
	}

}