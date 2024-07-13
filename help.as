package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class help
	{
		private var hp:holdhelp = new holdhelp();
		private var dp:dashhelp = new dashhelp();
		private var ap:storehelp = new storehelp();
		private var lp:lvlhelp = new lvlhelp();
		private var sp:shapehelp = new shapehelp();
		private var wp:wavehelp = new wavehelp();
		private var scp:scorehelp = new scorehelp();
		private var kp:killhelp = new killhelp();
		private var p1p:phelp1 = new phelp1();
		private var p2p:phelp2 = new phelp2();
		private var up:uphelp = new uphelp();
		private var cp:collhelp = new collhelp();
		private var hhp:helphelp = new helphelp();
		private var clrp:colorhelp = new colorhelp();
		private var holder:Bitmap=new Bitmap();
		private var cont:Sprite = new Sprite();
		public var clear:Boolean = true;
		private var next:int = -1;
		private var nextArray:Array = new Array();
		private var clicknum:int = 0;
		private var p:MovieClip;
		private var sec:int = 0;
		private var clickable:Boolean = true;
		
		public function help()
		{
			cont.addChild(holder);
			cont.addEventListener(MouseEvent.MOUSE_DOWN,dis);
		}
		public function showPic(par:MovieClip,pic:int):void
		{
			sec = 0;
			p=par;
			clear=false;
			if(cont.contains(holder)){cont.removeChild(holder);}
			if(MovieClip(p).contains(cont)){MovieClip(p).removeChild(cont);}
			switch(pic)
			{
				case 0:
					holder=new Bitmap(hp);
					break;
				case 1:
					holder=new Bitmap(dp);
					break;
				case 2:
					holder=new Bitmap(ap);
					break;
				case 3:
					holder=new Bitmap(sp);
					break;
				case 4:
					holder=new Bitmap(lp);
					break;
				case 5:
					holder=new Bitmap(wp);
					break;
				case 6:
					holder=new Bitmap(scp);
					break;
				case 7:
					holder=new Bitmap(kp);
					break;
				case 8:
					holder=new Bitmap(p1p);
					break;
				case 9:
					holder=new Bitmap(p2p);
					break;
				case 10:
					holder=new Bitmap(up);
					break;
				case 11:
					holder=new Bitmap(cp);
					break;
				case 12:
					holder=new Bitmap(hhp);
					break;
				case 13:
					holder=new Bitmap(clrp);
					break;
			}
			trace(holder.width);
			cont.x = (640-holder.width)/2;
			cont.y = (360-holder.height)/2;
			cont.addChild(holder);
			MovieClip(p).addChild(cont);
			clickable = false;
			p.addEventListener(Event.ENTER_FRAME, countDown);
		}
		public function setNexts(a:Array):void
		{
			for(var i:int = 0; i< a.length; i++)
			{
				nextArray[i]=a[i];
			}
		}
		public function is_active():Boolean{
			return !clear
		}
		public function destroy(p:MovieClip):void
		{
			if(MovieClip(p).contains(cont)){MovieClip(p).removeChild(cont);}
		}
		private function dis(m:MouseEvent):void{
			if (clickable){
				if(clicknum<nextArray.length){next=nextArray[clicknum];clicknum+=1;}
				else{clicknum=0;next=-1;nextArray=[]}
				if(next==-1){MovieClip(p).removeChild(cont);
				clear=true;}
				else
				{
					showPic(p,next);
				}
			}
		}
		private function countDown(e:Event=null):void{
			sec += 1;
			if (sec >= 45){
				clickable = true
				p.removeEventListener(Event.ENTER_FRAME, countDown);
			}
		}
	}
}