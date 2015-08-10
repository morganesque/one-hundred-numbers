package 
{
	public class Old extends Object 
	{	
		public function Old()
		{
            /*
            drag and drop thing for creating sums

            hit1 = new HitCircle();
            hit1.mouseEnabled = false;
            hit1.mouseChildren = false;
            hit1.alpha = 0;
            addChild(hit1);
            
            hit2 = new HitCircle();
            hit2.mouseEnabled = false;
            hit2.mouseChildren = false;
            hit2.alpha = 0;
            addChild(hit2);
            
            hitline = new Sprite();
            addChild(hitline);
            
            hundred.addEventListener(MouseEvent.MOUSE_DOWN, onHundredDown);
            
            form = new Formula();
            form.x = 95;
            form.y = 550;
            addChild(form);
            */
		}
		
		public function onHundredDown(e:MouseEvent):void
        {            
            var i:int, c:Number = 1000, nearest:*;
            for (i = 0; i < grid.length; i++)
            {
                var d = cMath.dist(new Point(mouseX,mouseY),new Point(grid[i].x+25,grid[i].y+25));
                if (d < c)
                {
                    c = d;
                    nearest = grid[i];
                }                
            }
            hit1.x = nearest.x + 25;
            hit1.y = nearest.y + 25;
            hit2.x = nearest.x + 25;
            hit2.y = nearest.y + 25;
            
            numone = nearest;
            
            TweenMax.to(hit1, 1, {alpha:0.7});
            TweenMax.to(hit2, 1, {alpha:0.7});
            TweenMax.to(hitline, 1, {alpha:0.7});
            
            stage.addEventListener(MouseEvent.MOUSE_UP, onHundredUp);
            hundred.addEventListener(MouseEvent.MOUSE_MOVE, onHundredMove);
        }
        
        public function onHundredUp(e:MouseEvent):void
        {
            TweenMax.to(hit1, 0.3, {alpha:0.2});
            TweenMax.to(hit2, 0.3, {alpha:0.2});
            TweenMax.to(hitline, 0.3, {alpha:0.2});
            hundred.removeEventListener(MouseEvent.MOUSE_MOVE, onHundredMove);
            
            form.doFormula(numone.num.text,numtwo.num.text);
        }
        
        public function onHundredMove(e:MouseEvent):void
        {
            var i:int, c:Number = 1000, nearest:*;
            for (i = 0; i < grid.length; i++)
            {
                var d = cMath.dist(new Point(mouseX,mouseY),new Point(grid[i].x+25,grid[i].y+25));
                if (d < c)
                {
                    c = d;
                    nearest = grid[i];
                }                
            }
            hit2.x = nearest.x + 25;
            hit2.y = nearest.y + 25;
            
            numtwo = nearest;
            
            hitline.graphics.clear();
            hitline.graphics.lineStyle(10,0xCC0000);
            hitline.graphics.moveTo(hit1.x,hit1.y);
            hitline.graphics.lineTo(hit2.x,hit2.y);
            
        }
	}
}

