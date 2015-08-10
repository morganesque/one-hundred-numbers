package com.commonagency
{
    import flash.display.Sprite;
    import nl.demonsters.debugger.MonsterDebugger;
    import com.asual.swfaddress.SWFAddress;
    import flash.events.StatusEvent;
    import flash.events.Event;
    import com.commonagency.GoogleAnalytics;
    import flash.external.ExternalInterface;
    
    public class cDocClass extends Sprite 
    {
        private var debugger:MonsterDebugger;

        public function cDocClass() 
        {
            debugger = new MonsterDebugger(this);    
            
            addEventListener(Event.ENTER_FRAME, checkStage);
        }
        
        public function checkStage(e:Event):void
        {
            if (!stage) return;            
            removeEventListener(Event.ENTER_FRAME, checkStage);
                        
            Config.PLAYING_IN_IDE = stage.loaderInfo.url.indexOf("file") == 0;
            if (!Config.PLAYING_IN_IDE) Config.FLASH_VARS = stage.loaderInfo.parameters;
            
            if (Config.FLASH_VARS.path) Config.REQUEST_URL = Config.FLASH_VARS.path;
            if (Config.FLASH_VARS.debug) Config.DEBUG = Boolean(Number(Config.FLASH_VARS.debug));

            MonsterDebugger.trace(this,'debug: '+Config.DEBUG);
            MonsterDebugger.trace(this,'path: '+Config.REQUEST_URL);
            
            // initialise the Google Analytics code which will track the page views.
            /*
			if (!Config.PLAYING_IN_IDE && Config.GA_CODE != '')
			{
			    try {
                    GoogleAnalytics.i.init(this, Config.GA_CODE, 'Bridge', Config.DEBUG);  
                } catch (e:Error) {
                    MonsterDebugger.trace(this,e);
                    Config.DO_GA = false;
                }
			}
            SWFAddress.onChange = onPageChanged;   
            addEventListener('changePage', changePage); // use a StatusEvent so you can pass the value.
			*/
			            
            ExternalInterface.addCallback('getVersion', getVersion);
            
            init();
        }       
    
        public function init():void{}
        
        public function onPageChanged():void
        {
            var val = SWFAddress.getValue();
            trace("cDocClass::onPageChanged() - ", val);
            MonsterDebugger.trace(this, val);
        }
        
        public function changePage(e:StatusEvent):void
        {
            SWFAddress.setValue(e.code);
        }
        
        public function getVersion():String
        {
            try {
                return 'swf version: '+String(this.loaderInfo.swfVersion)+ "\n" + 'actionscript: '+String(this.loaderInfo.actionScriptVersion);
            } catch (e:Error) {
                MonsterDebugger.trace(this,e);
            }
            
            return 'Sorry version data was to retrieved.';
        }
    }
}