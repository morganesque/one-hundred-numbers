package com.commonagency
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class cError extends EventDispatcher 
	{
		private static var 
						_main:DisplayObjectContainer,
						_movieclip:MovieClip,
						_message:String,
						_instance:cError;
	
		public function set movieclip(value:MovieClip):void
		{
			_movieclip = value;
			_movieclip.buttonMode = true;
			_movieclip.mouseChildren = false;
			_movieclip.visible = false;
			_movieclip.alpha = 0;
			_movieclip.addEventListener(MouseEvent.CLICK, onErrorMouseClick);
			_movieclip.field.text = 'You shouldn\'t ever see this message. If you can see it there\'s definitely a problem.'
			_movieclip.x = _movieclip.stage.stageWidth/2;
			_movieclip.y = _movieclip.stage.stageHeight/2;
		}
		
		public function set main(value:DisplayObjectContainer):void
		{
			_main = value;
		}
		
		private function onErrorMouseClick(e:MouseEvent):void
		{
		    if (_movieclip)
		    {
		        _movieclip.hide();
		    }
		}
		
		public function set message(value:String):void
		{
			_message = value;
			if (_movieclip) 
			{
			    _movieclip.show();
				_movieclip.field.text = _message;
			} else {
				var tf = new TextField();
				tf.border = true;
				tf.borderColor = 0x000000;
				tf.backgroundColor = 0xFFFFFF;
				tf.textColor = 0x000000;
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.wordWrap = false;
				tf.text = _message;
				if (_main) _main.addChild(tf);
				else throw new Error(_message);
			}
			throw new Error(_message);
		}
	
		public static function get i():cError
		{
			return initialize();
		}
	
		public static function initialize():cError
		{
			if (_instance == null){
				_instance = new cError();
			}
			return _instance;
		}
	
		public function cError()
		{
			super();
			if( _instance != null ) throw new Error( "Error:cError already initialised." );
			if( _instance == null ) _instance = this;
		}
		
		public function reposition(px:Number, py:Number):void
		{
			_movieclip.x = px;
			_movieclip.y = py;
		}
	}
}