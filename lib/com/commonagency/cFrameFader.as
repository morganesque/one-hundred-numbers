package com.commonagency
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.utils.Dictionary;
    import com.greensock.TweenMax;
    import com.greensock.easing.Quint;
    
    public class cFrameFader extends Sprite 
    {
        public var _mc:MovieClip;
        private var _bmd:BitmapData;
        private var _bm:Bitmap;
        private var dict:Dictionary = new Dictionary();
        private var _frame:Object;
        
        private static var FILL:uint = 0x00FF0000;
        
        public function cFrameFader(mc:MovieClip, startFrame:Object=null)
        {
            _mc = mc;
            addChild(mc);
            
            buttonMode = true;
            
            x = _mc.x; _mc.x = 0;
            y = _mc.y; _mc.y = 0;
            
            _bmd = new BitmapData(_mc.width, _mc.height, true, 0x00FFFF00);
            _bm = new Bitmap(_bmd);
            
            if (startFrame) _mc.gotoAndStop(startFrame);
            
            _bmd.draw(_mc);
            
            _mc.alpha = 0;
            addChildAt(_bm,0);
        }
        
        public function manualChange(frame:Object):void
        {
            if (_frame == frame) return;
            
            swap();
            
            _frame = frame;
            _mc.gotoAndStop(frame);
            this.transition();
        }
        
        public function eventChange(e:Event):void
        {
            var frame = dict[e.type];
            if (_frame == frame) return;
            
            swap();
            
            _frame = frame;
            _mc.gotoAndStop(frame);
            
            this.transition();
        }
        
        public function addEventFrame(event:String, frame:Object):void
        {
            dict[event] = frame;
            removeEventListener(event, eventChange);
            addEventListener(event, eventChange);
        }
        
        public function swap():void
        {
            this.afterTransition();
            _bmd.fillRect(_bmd.rect, FILL);
            _bmd.draw(_mc);
            _bm.alpha = 1;
            _mc.alpha = 0;
        }
        
        public function transition():void
        {
            TweenMax.killTweensOf(_bm);
            TweenMax.killTweensOf(_mc);
            TweenMax.to(_bm, 0.2, {alpha:1, ease:Quint.easeOut, onComplete:swap});
            TweenMax.to(_mc, 0.2, {alpha:1, ease:Quint.easeOut});
        }
        
        public function afterTransition():void
        {
            TweenMax.killTweensOf(_bm);
            TweenMax.killTweensOf(_mc);
        }
    }
}