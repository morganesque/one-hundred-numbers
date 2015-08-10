package com.commonagency
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class cMovieClip extends MovieClip
	{
		private static const FORE:String = 'forward';
		private static const BACK:String = 'backward';

		public static const DONE:String = 'arrived';
		
		private var _playing:Boolean = false;
		private var _direction:String = FORE;
		private var _destination:uint;
		
		public function cMovieClip()
		{
			super();
			stop();
			addEventListener(Event.ENTER_FRAME, onEnterFrame)
		}
		
		public function get playing():Boolean
		{
			return _playing;
		}
		
		public function set playing(value:Boolean):void
		{
			_playing = value;
		}
		
		public function playTo(f:uint):void
		{
			if (currentFrame == f) { 
				Logger.debug("cMovieClip::playTo() - already there!"); 
				return; 
			}

			_destination = f;

			if (f > currentFrame) _direction = FORE;
			else _direction = BACK;
			
			_playing = true;
			Logger.debug("cMovieClip::playTo() - starting "+currentFrame+" - play to - "+_destination+" "+_direction);
		}
		
		public function gotoAndPlayTo(frame:Object, to:uint):void
		{
			gotoAndStop(frame);
			playTo(to);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (_playing)
			{
				switch(_direction)
				{
					case FORE: nextFrame(); break;
					case BACK: prevFrame(); break;
				}
				if (currentFrame == _destination) 
				{
					dispatchEvent(new Event(DONE));
					_playing = false;
				}
			}
		}
		
		override public function stop():void
		{
			super.stop();
			_playing = false;	
		}
		
		override public function play():void
		{
			super.play();
			_playing = true;
		}
		
		override public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			gotoAndStop(frame,scene);
			// if (direction) _direction = direction;
			_playing = true;
		}
		
		override public function gotoAndStop(frame:Object, scene:String = null):void
		{
			super.gotoAndStop(frame,scene);
			_playing = false;
		}
	}
}

