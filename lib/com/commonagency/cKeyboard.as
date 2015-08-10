package com.commonagency
{
    import flash.events.EventDispatcher;
    import flash.display.Stage;
    import flash.events.KeyboardEvent;

    public class cKeyboard extends EventDispatcher 
    {
        private var _stage:Stage;
        private var _funcs:Array = [];
        
        public var last:int;
        
        public function set stage(value:Stage):void
        {
            _stage = value;
        }
        
        private function onKeyDown(e:KeyboardEvent):void
        {
            var c = e.keyCode;
            var f = _funcs[c];
            
            last = c;
            
            if (f) f(e);
            // else trace(e.keyCode);
        }
        
        public function register(n:uint, f:Function):void
        {
           _funcs[n] = f;
           if (_funcs.length && _stage) _stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
           else throw new Error('cKeyboard:: No "_stage" property set, you need to set the stage property first!!');
        }
        
        public function remove(n:uint):void
        {
           _funcs[n] = undefined;
           //trace('releasing key: '+n);
           if (_funcs.length == 0) _stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }
        
        /* SINGLETON FUNCTIONS */
        
        private static var _instance:cKeyboard;
    
        public static function get i():cKeyboard
        {
            return initialize();
        }
    
        public static function initialize():cKeyboard
        {
            if (_instance == null){
                _instance = new cKeyboard();
            }
            return _instance;
        }
    
        public function cKeyboard()
        {
            super();
            if( _instance != null ) throw new Error( "Error:cKeyboard already initialised." );
            if( _instance == null ) _instance = this;
        }
    
    }

}