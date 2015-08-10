package 
{
	public class Config 
	{
	    public static var DEBUG:Boolean = false;
	    
	    /* 
	        whether the SWF is playing within the IDE or not (useful 
	        for making sure certain things only happen in the browser.
	    */
        public static var PLAYING_IN_IDE:Boolean = true;
        
        /* 
            Just a neat storage place for the Flash Vars so I can 
            remember where they are and so I can put the code in.
	    */
        public static var FLASH_VARS:Object = new Object;
        
        /**
        *   a good thing to store the URL start for any files you're requesting from the 
        *   server. Also this can then be overridden i the IDE to provide a local place
        *   for getting files during deveopment.
        */
        public static var REQUEST_URL:String = '/';
        
        /**
        *   The Google Analytics code which is required for tracking from Flash.
        */
        public static var GA_CODE:String = '';
	}
}

