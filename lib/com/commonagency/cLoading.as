/*
This is for dealing with loading bars.

It's a Singleton and  you need to pass in the loading bar clip to init().
You loading bar clip must contain a clip called 'bar' (this is what is scaled).

Also you then give this class a _target and it'll monitor it's download progress
using normal ProgressEvent events. You can fake ProgressEvent's for multiple 
downloads via a function a bit like what's below. Keep track of everything that
needs to load (_loading) and increment each time something is loaded (_loaded).
Then construct a new ProgressEvent and dispatch it to this class.

public function countLoading(e:Event):void
{        
    _loaded++;
    
    var p = new ProgressEvent('progress');
    p.bytesLoaded = _loaded;
    p.bytesTotal = _loading;
    dispatchEvent(p)
    
    if (_loaded == _loading) doneLoading(); // everything's done.
}

Because it's a Singleton _target can be set from anywhere you like!

*/
package com.commonagency
{
    import flash.events.EventDispatcher;
    import flash.events.ProgressEvent;
    import flash.text.TextField;
    
    public class cLoading extends EventDispatcher {
    
        private static var _instance:cLoading;
        private var _loadBar:*;
        private var _target:*;
        private var _callbacks:Array = [];
        private var _before:String;
        private var _after:String;
        private var _textfield:TextField;
    
        public static function get i():cLoading
        {
            return initialize();
        }
    
        public static function initialize():cLoading
        {
            if (_instance == null){
                _instance = new cLoading();
            }
            return _instance;
        }
    
        public function cLoading()
        {
            super();
            if( _instance != null ) throw new Error( "Error:cLoading already initialised." );
            if( _instance == null ) _instance = this;
        }
        
        public function set loadBar(d:*):void
        {
            _loadBar = d;
            _loadBar.visible = false;
        }
        
        public function setTextField(tf:TextField, before:String='', after:String=''):void
        {
            _textfield = tf;
            _before = before;
            _after = after;
        }
            
        public function set listenTo(value:*):void
        {            
            _target = value;
            _target.addEventListener(ProgressEvent.PROGRESS, onProgress)
            _loadBar.visible = true;
            _loadBar.bar.scaleX = 0;
            
            // Logger.debug("cLoading::set target() - start");
        }
        
        public function addProgessCallBack(f:Function):void
        {
            _callbacks.push(f);
        }
    
        private function onProgress(e:ProgressEvent):void
        {
            var perc = e.bytesLoaded / e.bytesTotal;
            _loadBar.bar.scaleX = perc;
            
            for each (var cb in _callbacks) cb(perc);
            
            if (_textfield) _textfield.text = _before + Math.round(100 - 100*perc) + _after;
            
            if (perc >= 1) 
            {
                _target.removeEventListener(ProgressEvent.PROGRESS, onProgress);
                // _loadBar.visible = false;
                _loadBar.bar.scaleX = 1;
                // Logger.debug("cLoading::onProgress() - done");
            }
        }
    }

}