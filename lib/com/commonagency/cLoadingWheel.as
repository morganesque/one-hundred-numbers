package com.commonagency
{    
    import flash.display.Sprite;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    
    public class cLoadingWheel extends Sprite
    {
        private var wheel:Sprite;

        private var _bith:int = 10;
        private var _bitw:int = 5;
        private var _segs:int = 48;
        private var _size:int = 190;
        private var _hollow:int = 50;
        private var _color:uint = 0x000000;
        
        private var _timer:Timer;
        private var _drawn:Boolean = false;
        
        public function cLoadingWheel()
        {    
            _timer = new Timer(50);
            _timer.addEventListener(TimerEvent.TIMER, updateLoading);
            
            mouseEnabled = false;
            mouseChildren = false;
        }
        
        public function init(w:int,h:int,s:int,z:int,g:int):void
        {
            _bitw = w;        // width of the segments.
            _bith = h;        // height of the segements.
            _segs = s;        // the number of segements to include.
            _size = z;        // size of the circle.
            _hollow = g;    // size of the hollow in the middle.
        }
        
        public function set color(value:uint):void
        {
            _color = value;
        }
        
        public function draw():void
        {
            wheel = new Sprite();
            for (var i:int = 0; i<_segs; i++)
            {                
                var s:Sprite = new Sprite();
                s.graphics.beginFill(_color);
                s.graphics.drawRect(-_bitw/2,_hollow,_bitw,_bith);
                s.graphics.endFill();
                s.rotation = (360/_segs) * i;
                s.alpha = (1/_segs) * i;
                wheel.addChild(s);
            }
            addChild(wheel);
            
            width = _size;
            height = _size;
            
            _drawn = true;
        }
        
        public function updateLoading(t:TimerEvent):void
        {
            if (wheel) wheel.rotation += (360/_segs);
        }
        
        override public function set alpha(value:Number):void
        {
            super.alpha = value;
            
            if (value > 0) _timer.start();
            else _timer.reset();
        }
    }
}