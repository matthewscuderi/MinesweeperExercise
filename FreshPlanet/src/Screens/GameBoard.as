package Screens 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	import Tile;
	
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class GameBoard extends BaseScreen 
	{
		private var mines:int;
		private var rows:int;
		private var cols:int;
		private var tiles:Array;
		
		private var minesLeftToFlag:int;
		private var minesLeftText:TextField;
		
		public function GameBoard() 
		{
			super();
		}
		
		public function createGameBoard(numMines:int, numRows:int, numCols:int):void
		{
			mines = numMines;
			minesLeftToFlag = numMines;
			rows = numRows;
			cols = numCols;
			tiles = new Array();
			
			trace ("making game with " + mines + " mines " + rows  + " rows " + cols + " cols."); 
			
			minesLeftText = new TextField(400, 100, "Mines Left: " + minesLeftToFlag, "Verdana", 14);
			minesLeftText.x = (stage.stageWidth - minesLeftText.width) / 2;
			minesLeftText.y = stage.stageHeight - minesLeftText.height;
			this.addChild(minesLeftText);
			
			for(var i:Number = 0; i < rows; i++){
				var rowTiles:Array = new Array();
				tiles[i] = rowTiles;
				for(var j:Number = 0; j < cols; j++){
					var tile:Tile = new Tile(j, i);
					tiles[i][j] = tile;
					
					tiles[i][j].x = j*40 + 20;
					tiles[i][j].y = i * 40 + 20;
					this.addChild(tiles[i][j]);
				}
			}
			
			generateMines();
			setTileValues();
		}
		
		private function generateMines():void
		{
			var numberOfMinesLeftToPlace:int = mines;
			while(numberOfMinesLeftToPlace > 0){
				var randomNumber:Number = Math.round(Math.random()* ((cols * rows) - 1));
				var rowCount:Number = Math.floor(randomNumber / cols);
				var columnCount:Number = randomNumber % cols;
				if(!tiles[rowCount][columnCount].isMine){
					tiles[rowCount][columnCount].isMine = true;
					numberOfMinesLeftToPlace--;
				}
			}
		}
		
		public function getTileNeighbors(tile:Tile):Array
		{
			var neighbors:Array = new Array();
			
			//A tile has a potential of 8 Neighboring tiles.
			//First check if the tile is in the top row of the board (Ycoord == 0) so that it has tiles beneath it.
			if (tile.ycoord == 0) 
			{
				neighbors.push(tiles[tile.ycoord + 1][tile.xcoord]);
				
				if (tile.xcoord == 0) // Top row, left corner tile
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord + 1]);
				}
				else if (tile.xcoord == cols - 1) // Top Row, right corner tile
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord - 1]);
				}
				else // Top row, tiles inbetween the corners
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord - 1]);
				}
			}
			else if (tile.ycoord == (rows - 1)) // Checks the tiles on the bottom row
			{
				neighbors.push(tiles[tile.ycoord - 1][tile.xcoord]);
				
				if (tile.xcoord == 0) // Bottom row, left corner tile
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord + 1]);
				}
				else if (tile.xcoord == cols - 1) // Bottom Row, right corner tile
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord - 1]);
				}
				else // Bottom row, tiles inbetween the corners
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord - 1]);
				}
			}
			else // Tile in rows between the top and bottom
			{
				neighbors.push(tiles[tile.ycoord + 1][tile.xcoord]);
				neighbors.push(tiles[tile.ycoord - 1][tile.xcoord]);
				
				if (tile.xcoord == 0) // Tiles in left column
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord + 1]);
				}
				else if (tile.xcoord == cols - 1) // Tiles in right column
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord - 1]);
				}
				else // Tiles in the middle
				{
					neighbors.push(tiles[tile.ycoord][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord - 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord - 1]);
					
					neighbors.push(tiles[tile.ycoord][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord + 1][tile.xcoord + 1]);
					neighbors.push(tiles[tile.ycoord - 1][tile.xcoord + 1]);
				}
			}
			
			return neighbors;
		}
		
		//Gets the values for the tiles with neighboring mines
		private function setTileValues():void
		{
			for (var i:int = 0; i < rows; ++i)
			{
				for (var j:int = 0; j < cols; ++j)
				{
					var tile:Tile = Tile(tiles[i][j]);
					
					tile.setNeighbors( getTileNeighbors(tile));
					
				}
			}
		}
		
		public function checkTile(tile:Tile):void
		{
			if (tile.flagged && tile.isMine)
			{
				--minesLeftToFlag;
				if (minesLeftToFlag == 0)
				{
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { id:"gameOver", win:true } ));
				}
			}
			else if (!tile.flagged && tile.isMine)
			{
				++minesLeftToFlag;
			}
			
			minesLeftText.text = "Mines Left: " + minesLeftToFlag;
		}
		
		//Hide the screen and resets the game
		override public function hideScreen():void
		{
			this.visible = false;
			for (var i:int = 0; i < rows; ++i)
			{
				for (var j:int = 0; j < cols; ++j)
				{
					this.removeChild(tiles[i][j]);
				}
			}
			mines = 0;
			rows = 0;
			cols = 0;
			this.removeChild(minesLeftText);
		}
		
	}

}