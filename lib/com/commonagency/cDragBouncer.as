package com.commonagency 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	import com.greensock.easing.*;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class cDragBouncer extends Sprite 
	{
	    public static var positions:Dictionary = new Dictionary();
	    public static var dragged:MovieClip;
	    public static var offset:Point;
	    
        public static function make(mc:MovieClip):void
        {
            mc.buttonMode = true;
            
            var p = new Point(mc.x, mc.y);
            positions[mc] = p;
            
            mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            mc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        }
        
        public static function onMouseDown(e:MouseEvent):void
        {
            dragged = MovieClip(e.currentTarget);
            
            offset = new Point(dragged.stage.mouseX-dragged.x, dragged.stage.mouseY-dragged.y)
            dragged.addEventListener(Event.ENTER_FRAME, onDragEnter);
            
            if (dragged.stage) dragged.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            else throw new Error('Movieclip must be added to stage before using this (I need a stage property)');
        }
        
        public static function onMouseUp(e:MouseEvent):void
        {
            if (dragged)
            {
                var pos = positions[dragged];
                dragged.removeEventListener(Event.ENTER_FRAME, onDragEnter);
                TweenMax.to(dragged, 2, {x:pos.x, y:pos.y, ease:Elastic.easeOut});
                dragged = null;
            }
        }
        
        public static function onDragEnter(e:Event):void
        {
            dragged.x = dragged.stage.mouseX - offset.x;
            dragged.y = dragged.stage.mouseY - offset.y
        }
	}
}