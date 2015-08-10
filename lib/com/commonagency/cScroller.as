package com.commonagency
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import com.commonagency.cMath;
	import com.greensock.TweenMax;
	import com.commonagency.cButton;
	
	public class cScroller
	{
	    public var mask:Sprite;
	    public var slider:*;
	    public var content:*;
	    private var _parent:DisplayObjectContainer;
	    
	    private var _pad:Number = 5;
	    private var _dragRect:Rectangle;
	    private var _dragging:Boolean = false;
	    private var _contentBottomY:Number;
	    private var _startY:Number;
	    private var _sliderHeight:Number;
	    
		public function cScroller(c:DisplayObject, s:*)
		{
		    content = c;
		    slider = s;
			_parent = content.parent;
			
			_startY = slider.thumb.y;
			_sliderHeight = slider.height;
			
			slider.thumb.x = (slider.width - slider.thumb.width) / 2;
			trace("cScroller::cScroller() - ", slider.width, slider.thumb.width);
			slider.thumb.buttonMode = true;
			
			mask = new Sprite();			
			_parent.addChild(mask);

		    var dragHeight = slider.height - slider.thumb.height - 2 * slider.thumb.y;
			_dragRect = new Rectangle(slider.thumb.x, slider.thumb.y, 0, dragHeight);
			
			slider.thumb.addEventListener(MouseEvent.MOUSE_DOWN, onThumbDown);
			slider.thumb.addEventListener(MouseEvent.MOUSE_UP, onThumbUp);
			
			content.addEventListener(Event.ENTER_FRAME, onEnter);
			
			cButton.make(slider.thumb, function(){});
		}
		
		public function reset():void
		{		    
		    slider.thumb.height = _sliderHeight * _sliderHeight / content.height; 		    
		    slider.thumb.y = _startY;
		    
		    if (slider.thumb.height >= _sliderHeight) TweenMax.to(slider, 0.5, {alpha:0});
		    else TweenMax.to(slider, 0.5, {alpha:1});
		    
		    var dragHeight = slider.height - slider.thumb.height - 2 * slider.thumb.y;
			_dragRect = new Rectangle(slider.thumb.x, slider.thumb.y, 0, dragHeight);
		    
		 	var g = mask.graphics;
		 	g.clear();
			g.beginFill(0xFF0000);
			g.drawRect(content.x-_pad,slider.y,content.width+(2*_pad),slider.height);
			g.endFill(); 
			
            content.mask = mask;
			
			_contentBottomY = slider.height - content.height;  
		}
		
		public function onThumbDown(e:MouseEvent):void
		{
		    slider.thumb.startDrag(false, _dragRect);
		    _parent.stage.addEventListener(MouseEvent.MOUSE_UP, onThumbUp);
		    _dragging = true;
		}
		
		public function onThumbUp(e:MouseEvent):void
		{
		    _dragging = false;
		    slider.thumb.stopDrag();
		}
		
		public function onEnter(e:Event):void
		{
            var dy = cMath.map(slider.thumb.y, _dragRect.y,_dragRect.height, slider.y,_contentBottomY);
            var vy = (content.y - dy);
            if (Math.abs(vy) > 1) content.y -= vy/10;
		}
		
		public function set pad(value:Number):void
	    {
	       _pad = value;
	    }
	}
}