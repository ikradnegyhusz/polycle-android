package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	import iShare.eGraph;
	import flash.display.MovieClip;

	public class txt extends Sprite
	{
		//int n number
		private var sw:int;
		private var ts:int;
		//text
		public var text;
		//format n font
		public var Format;
		public var font;

		public function txt(i:int=1280,TS:int=-1)
		{
			sw=i;
			if(TS==-1){TS=sw/25};
			ts=TS;
			setup();
			makeText();
			addEventListener(Event.ADDED_TO_STAGE, init_);
		}

		private function init_(e:Event):void
		{
			anim();
		}

		private function setup():void
		{
			text = new TextField();
			Format = new TextFormat();
			font = new proFont();
		}

		private function makeText():void
		{
			Format.align = TextFormatAlign.CENTER;
			Format.size = ts;
			Format.font = font.fontName;
			Format.color = 0xFFFFFF;

			text.defaultTextFormat = Format;
			text.selectable = false;
			text.embedFonts = true;
			text.width = 250;
			//text.autoSize = 'center';
			addChild(text);
		}
		public function setcolor(c:uint):void
		{
			Format.color = c;
			text.setTextFormat(Format);
		}
		public function settext(s:String):void
		{
			text.text = s;
			text.setTextFormat(Format);
		}
		/*public function Flash():void
		{
			eGraph.fadeO(MovieClip(parent),this,30,0.5,false);
			eGraph.fadeO(MovieClip(parent),this,30,0.5,false);
		}*/
		private function anim():void
		{
			eGraph.fadeI(this,20,0,1);
		}
	}
}
