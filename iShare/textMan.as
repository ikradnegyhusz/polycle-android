package iShare
{
	import flash.display.MovieClip;
	public class textMan
	{
		public function textMan()
		{};
		public static function renderText(disp:MovieClip,X:Number=0,Y:Number=0,t:String = 'txt',sw:int = 640,size:int=20,col:uint=0xFFFFFF):void
		{
			var rText:txt = new txt(sw,size);
			rText.text.text = t;
			rText.setcolor(col);
			rText.x=X-rText.width/2;rText.y=Y-rText.height/2;disp.addChild(rText);
			eGraph.fadeO(disp,rText,5,1,0,true);
			rText=null;
		}
	}
}
		