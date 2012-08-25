package  
{
	import org.flixel.*;
	
	public class MainMenu extends FlxState 
	{
		
		private var _txtTitle:FlxText;
		private var _btnWhat:FlxButton;
		private var _btnPlay:FlxButton;
		private var _btnOptions:FlxButton;
		private var _btnCredits:FlxButton;
		
		override public function create():void 
		{
			super.create();
			
			FlxG.bgColor = FlxG.BLUE;
			FlxG.mouse.show();
			
			_txtTitle = new FlxText( 0, 20, FlxG.width, "The Underglen" );
			_txtTitle.setFormat( null, 24, 0xFFCA28, "center", 0x002828 );
			_txtTitle.shadow = 0xFF914A17;
			add( _txtTitle );
			
			var nBtnHeight:int = 50;
			_btnWhat = new FlxButton( FlxG.width * 0.5, nBtnHeight += 30, "What?" );
			_btnWhat.x -= _btnWhat.width * 0.5;
			add( _btnWhat );
			
			_btnPlay = new FlxButton( FlxG.width * 0.5, nBtnHeight += 30, "Play", playButtonPressed);
			_btnPlay.x -= _btnPlay.width * 0.5;
			add( _btnPlay );
			
			_btnOptions = new FlxButton( FlxG.width * 0.5, nBtnHeight += 30, "Options" );
			_btnOptions.x -= _btnOptions.width * 0.5;
			add( _btnOptions );
			
			_btnCredits = new FlxButton( FlxG.width * 0.5, nBtnHeight += 30, "Credits" );
			_btnCredits.x -= _btnCredits.width * 0.5;
			add( _btnCredits );
		}
		
		private function playButtonPressed():void
		{
			FlxG.flash( 0xFF000000 );
			FlxG.switchState( new Game() );
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}

}