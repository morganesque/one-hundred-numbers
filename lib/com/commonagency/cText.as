package com.commonagency
{
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class cText
    {
        public static function uFo(params:Object, field:TextField)
        {
            var tf:TextFormat = new TextFormat();
            
            for(var i in params)
            {
                if (field.hasOwnProperty(i)) field[i] = params[i];
                else if (tf.hasOwnProperty(i)) tf[i] = params[i];
            }
            
            field.defaultTextFormat = tf;
            field.setTextFormat(tf);
        }
        
        public static function applyHTMLFormatting(tf:TextField, btf:TextFormat):void
        {        
            // grab the text
            var c = tf.text;
            // split it on the start and end tags
            var bits:Array = c.split(/<\/?b>/);
            // join it back up without the tags.
            tf.text = bits.join('');
            // loop through the bits changing the formatting to the sections enclosed in tag.            
            var i:int, s:uint = 0;
            for (i = 0; i < bits.length - 1; i+=2)
            {
                // find where this section starts.
                var _sta:uint = s + bits[i].length;
                // find where this section ends.
                var _end:uint = _sta + bits[(i+1)].length;
                // apply the format.
                tf.setTextFormat(btf, _sta, _end);
                // find where to start the next search.
                s = _end;
            }
        }
    }
}