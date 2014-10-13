package  
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Matthew Scuderi
	 */
	public class Assets 
	{
		
		[Embed(source = "../media/tile.png")]
		public static const Tile:Class;
		
		[Embed(source = "../media/tile_bg.png")]
		public static const TileBG:Class;
		
		[Embed(source = "../media/tile_flag.png")]
		public static const TileFlag:Class;
		
		[Embed(source = "../media/mine.png")]
		public static const Mine:Class;
		
		[Embed(source = "../media/transparent.png")]
		public static const transparent:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}

}