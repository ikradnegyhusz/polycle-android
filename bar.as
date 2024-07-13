package
{
	import flash.display.Sprite;
	import iShare.eGraph;
	import flash.events.Event;

	public class bar extends Sprite
	{
		//obj
		private var b1:Sprite = new Sprite();
		public var b2:Sprite = new Sprite();
		
		public function bar()
		{
			setup(b1);
			b1.alpha = 0.2;
			setup(b2);
			addEventListener(Event.ADDED_TO_STAGE,init_);
		}
		private function init_(e:Event):void
		{
			this.alpha = 0;
			eGraph.fadeI(this,60,0,1);
		}
		private function setup(b:Sprite,c:uint=0xFFFFFF):void
		{
			b.graphics.lineStyle(2,c);
			b.graphics.lineTo(100,0);
			addChild(b);
		}
		public function setcolor(c:uint):void
		{
			b1.graphics.clear();
			b2.graphics.clear();
			setup(b1,c);
			setup(b2,c);
		}
	}
}