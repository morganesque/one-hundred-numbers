package com.commonagency 
{	
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.events.Event;
    
	public class cSound extends Object 
	{
	    public var soundObject:Object = new Object();
	    	    		
		public function play(n:Sound,loops:int=0):cSound
		{
		    soundObject.sound = n;
		    soundObject.channel = soundObject.sound.play(0,loops);
		    soundObject.channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		    
		    return this;
		}
		
		public function onSoundComplete(e:Event):void
		{
            stop();
		}
		
		public function stop():void
		{
            if (soundObject.channel)
            {
                soundObject.channel.stop();
                soundObject.channel = null;
            }
            
            if (soundObject.sound) 
            {
                /*soundObject.sound.close(); // not doing this because sounds are in library */
                delete soundObject.sound;
            }
		}
		
	}
}