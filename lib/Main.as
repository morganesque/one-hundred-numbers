package
{
    import com.commonagency.cDocClass;
    import com.commonagency.cDisplay;
    import com.commonagency.cMath;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    import com.greensock.TweenMax;
    import com.commonagency.cText;
    import flash.display.MovieClip;
    import com.greensock.TimelineMax;
    
    public class Main extends cDocClass
    {
        var grid:Array = [];
        var left:Array = [];
        var cols:Array = [];
        
        var hit1:HitCircle;
        var hit2:HitCircle;
        var hitline:Sprite;        
        var hundred:Sprite;
        var numone:*
        var numtwo:*
        var form:Formula;
        
        var startY = 25;
        
        public var allnothing:MovieClip;
        
        public var colNum:uint = 10;
        
        /**
        *   See cDocClass for stage checker and how all that gets started.
        *   Put things in Main() which need sorting immediately as the 
        *   movie starts i.e. placement of graphics, initial values.
        */
        public function Main() 
        {
            super();
        }
          
        /**
        *   Is called once .stage is available (prevents problems in 
        *   various browsers when live) so stick thigs in here that you
        *   want to happen once everything is up and running i.e. attaching
        *   event listeners and starting up loading sequences etc.
        */
        override public function init():void
        {
            // container 
            hundred = new Sprite();
            addChild(hundred);
            
            // fill in the hundred squares.
            var i:int, n:NumberSquare;
            for (i = 0; i < 100; i++)
            {
                n = new NumberSquare();
                n.num.text = String(i);                
                cDisplay.grid(i, n, colNum, 5, [90,startY]);
                grid.push(n);
                hundred.addChild(n);
                /*n.toggleSquare('1',0x999999);*/
            }
            
            // make the controller squares down the side.
            for (i = 2; i < 10; i++)
            {
                n = new NumberSquare();
                n.num.text = String(i);
                
                cDisplay.grid(i-1, n, 1, 5, [10,startY]);
                
                var t = convHSLtoRGB((i-2)*360/8, 0.5, 0.5);
                var r = dec2hex(String(Math.round(t[0]))).substr(2);
                var g = dec2hex(String(Math.round(t[1]))).substr(2);
                var b = dec2hex(String(Math.round(t[2]))).substr(2);
                var col = uint('0x'+r+g+b);
                
                n.addSquare(String(i),col);                
                n.addEventListener(MouseEvent.CLICK, onNumberClick);
                /*n.addEventListener(MouseEvent.ROLL_OVER, onNumberOver);*/
                /*n.addEventListener(MouseEvent.ROLL_OUT, onNumberOut);*/
                n.buttonMode = true;
                addChild(n);
                
                addLittleSquares(i);
                
                left.push(n);
            }
            
            allnothing.x = 10;
            allnothing.y = i * 51.5;
            allnothing.all.buttonMode = true;
            allnothing.nothing.buttonMode = true;
            allnothing.all.addEventListener(MouseEvent.CLICK, onAllNothingClick);
            allnothing.nothing.addEventListener(MouseEvent.CLICK, onAllNothingClick);      
            
            for (i = 0; i < 15; i++)
            {
                var c = new butColumn();
                c.alpha = 0.2;
                c.buttonMode = true;
                c.addEventListener(MouseEvent.CLICK, onColumnButtonClick);
                cDisplay.grid(i,c,16,6.2,[90,(startY-23)]);
                addChild(c);
                
                if (i + 1 == colNum) c.alpha = 0.5;
                
                cols.push(c);
            }
        }
        
        public function onColumnButtonClick(e:MouseEvent):void
        {            
            var cur = e.currentTarget;
            var num = cols.indexOf(cur) + 1;
         
            var i:int;
            for (i = 0; i < 15; i++)
            {
                cols[i].alpha = 0.2;
            }
            
            cur.alpha = 0.5;
             
            for (i = 0; i < 100; i++)
            {                
                var p:Point = cDisplay.returnGrid(i, grid[i], num, 5, [90,startY]);
                
                var tl = new TimelineMax({delay:i/100});
                if (num > colNum)
                {
                    tl.append(TweenMax.to(grid[i],0.5,{x:p.x}));
                    tl.append(TweenMax.to(grid[i],0.5,{y:p.y}));                
                } else {
                    tl.append(TweenMax.to(grid[i],0.5,{y:p.y}));
                    tl.append(TweenMax.to(grid[i],0.5,{x:p.x}));
                }
            }
            
            colNum = num;
        }
        
        public function onAllNothingClick(e:MouseEvent):void
        {
            var cur = e.currentTarget;
            
            var i:int;
            for (i = 0; i < left.length; i++)
            {
                var l = left[i];
                
                if (cur.name == 'all') l.state = 'on';
                if (cur.name == 'nothing') l.state = 'off';
                
                var j:int;
                for (j = 0; j < grid.length; j++)
                {
                    if (cur.name == 'all') grid[j].grow(String(i+2));
                    if (cur.name == 'nothing') grid[j].shrink(String(i+2));
                }
            }
        }
        
        public function onNumberClick(e:MouseEvent):void
        {
            var cur = e.currentTarget;
            cur.toggleState();
            
            var i:uint;
            for (i = 0; i < grid.length; i++)
            {
                if (cur.state == 'on') grid[i].grow(cur.num.text);
                else grid[i].shrink(cur.num.text);
            }           
        }
        
        public function addLittleSquares(num:Number):void
        {
            var i:int;
            for (i = 0; i < grid.length; i++)
            {
                var a = grid[i];
                var n = a.num.text;
                if (n%num == 0)
                {
                    var t = convHSLtoRGB((num-2)*360/8, 0.5, 0.5);
                    var r = dec2hex(String(Math.round(t[0]))).substr(2);
                    var g = dec2hex(String(Math.round(t[1]))).substr(2);
                    var b = dec2hex(String(Math.round(t[2]))).substr(2);
                    var col = uint('0x'+r+g+b);

                    a.toggleSquare(num,col);
                    // a.grow(num);
                }
            }
        }
        
        /**
        *   hue = 0-360
        *   sat = 0-1
        *   lig = 0-1
        */
        public function convHSLtoRGB(hue:Number, sat:Number, lig:Number):Array
        {
            var red:Number, green:Number, blue:Number, t1:Number,t2:Number,rt:Number,gt:Number,bt:Number;
            
            // If S=0, define R, G, and B all to L
            if (sat == 0) red = green = blue = 255 * lig;
            
            if (lig < 0.5) t2 = lig * (1.0 + sat);
            else t2 = lig + sat - lig * sat;
            
            t1 = 2.0 * lig - t2;
            
            hue = hue/360;
            
            rt = hue + 1.0/3.0;     if (rt < 0) rt += 1; if (rt > 1) rt -= 1;
            gt = hue;               if (gt < 0) gt += 1; if (gt > 1) gt -= 1;
            bt = hue - 1.0/3.0;     if (bt < 0) bt += 1; if (bt > 1) bt -= 1;
            
            if (6 * rt < 1) red = t1 + (t2-t1) * 6 * rt;
            else if (2 * rt < 1) red = t2;
            else if (3 * rt < 2) red = t1 + (t2-t1) * ((2/3)-rt) * 6;
            else red = t1;
            
            if (6 * gt < 1) green = t1 + (t2-t1) * 6 * gt;
            else if (2 * gt < 1) green = t2;
            else if (3 * gt < 2) green = t1 + (t2-t1) * ((2/3)-gt) * 6;
            else green = t1;
            
            if (6 * bt < 1) blue = t1 + (t2-t1) * 6 * bt;
            else if (2 * bt < 1) blue = t2;
            else if (3 * bt < 2) blue = t1 + (t2-t1) * ((2/3)-bt) * 6;
            else blue = t1;        
            
            red = 255 * red;
            green = 255 * green;
            blue = 255 * blue;
            
            return new Array(red,green,blue);
        }

        public function hex2dec( hex:String ) : String {
        	var bytes:Array = [];
        	while( hex.length > 2 ) {
        		var byte:String = hex.substr( -2 );
        		hex = hex.substr(0, hex.length-2 );
        		bytes.splice( 0, 0, int("0x"+byte) );
        	}
        	return bytes.join(" ");
        }

        private function d2h( d:int ) : String {
        	var c:Array = [ '0', '1', '2', '3', '4', '5', '6', '7', '8',
        			'9', 'A', 'B', 'C', 'D', 'E', 'F' ];
        	if( d > 255 ) d = 255;
        	var l:int = d / 16;
        	var r:int = d % 16;
        	return c[l]+c[r];
        }

        public function dec2hex( dec:String ) : String {
        	var hex:String = "0x";
        	var bytes:Array = dec.split(" ");
        	for( var i:int = 0; i < bytes.length; i++ )
        		hex += d2h( int(bytes[i]) );
        	return hex;
        }
    }
}