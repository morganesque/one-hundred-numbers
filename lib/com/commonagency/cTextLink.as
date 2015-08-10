package com.commonagency 
{
    import flash.text.TextField;
    import flash.utils.Dictionary;
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    import com.greensock.TweenMax;
    
	public class cTextLink 
	{
	    private static var cols:Dictionary = new Dictionary();
	    
	    /**
	    *  @param tf - the text field you want to make into 
	    *  @param hc - hover color
	    *  @param cf - click function
	    */
        public static function make(tf:TextField, hc:uint, cf:Function):void
        {
            var s = new Sprite();
            s.x = tf.x;
            s.y = tf.y;
            tf.x = 0;
            tf.y = 0;
            
            tf.parent.addChild(s);
            s.addChild(tf);
            
            s.buttonMode = true;
            s.mouseChildren = false;
            s.addEventListener(MouseEvent.ROLL_OVER, onLinkOver);
            s.addEventListener(MouseEvent.ROLL_OUT, onLinkOut);
            s.addEventListener(MouseEvent.CLICK, cf);
            
            cols[s] = hc;
        }
        
        public static function onLinkOver(e:MouseEvent):void
		{
		    var t = e.currentTarget;
		    TweenMax.to(t, 0.42, {tint:cols[t]});
		}

        public static function onLinkOut(e:MouseEvent):void
        {
            var t = e.currentTarget;
		    TweenMax.to(t, 0.2, {removeTint:true});
        }
	}
}