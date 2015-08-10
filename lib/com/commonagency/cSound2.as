package com.commonagency 
{	
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.events.Event;
    import flash.utils.Dictionary;
    
	public class cSound extends Object 
	{
	    private var _sounds:Dictionary = new Dictionary();
	    
	    /**
	    *  Used to add a sound from the library for playing.
	    */
	    public function add(s:Sound, label:String):void
	    {
	        _sounds[label] = {sound:s};
	    }
	    
	    public function play(label:String, lf:Functio=null, loops:int=0, startTime:Number=0, sndTransform:SoundTransform=null):void
	    {
	        var s = _sounds[label];
            if (s)
            {
                s.channel = s.sound.play(startTime, loops, sndTransform);
                s.channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                if (lf) s.loadFunc = lf;
            } else {
                throw new Error('Sound '+label+' hasn\'t been added yet. Add it first!');
            }
	    }
	    
	    public function stop(label:String):void
	    {
	       var s = _sounds[label];
	       if (s.channel) 
	       {
	           s.channel.stop();
	           delete s.channel;
           }
	    }
	    
	    public function onSoundComplete(e:Event):void
	    {
	        var c = e.currentTarget;
            for each(var s in _sounds)
            {
                if (s = c && s.lf) s.lf();
            }
	    }
	    
        public function stopAll():void
        {
            for each(var s in _sounds)
            {
                if (s.channel)
                {
                    s.channel.stop;
                    delete s.channel;
                }
            }
        }
	    
	    
	    /*
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
                // soundObject.sound.close(); // not doing this because sounds are in library
                delete soundObject.sound;
            }
		}
		*/
	}
}