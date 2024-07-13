package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	import iShare.arrMan;

	public class xtras extends Sprite
	{
		private var rpArray:Array = new Array();
		private var nArray:Array = new Array();
		private var fArray:Array = new Array();
		private var txtArray:Array = new Array();
		
		private var sw:int=640;
		private var sh:int=360;
		
		private var bP:backP = new backP();
		private var holder:Bitmap;
		private var backB:button;
		
		private var dispText:txt=new txt();
		
		private var black:fullFill = new fullFill();
		private var warnText:txt;
		private var upL:Sprite = new Sprite();
		
		public function xtras()
		{
			addEventListener(Event.ADDED_TO_STAGE,init_);
			warnText=new txt(sw,30);
			warnText.text.text = 'EPILEPSY WARNING!\nIf this extra is enabled\nit might be harmful\nto those with epilepsy!';
			holder=new Bitmap(black);
			upL.addChild(holder);
			upL.addChild(warnText);
			upL.addEventListener(MouseEvent.MOUSE_DOWN,remEp);
			holder=new Bitmap(bP);
			backB = new button(false,70,holder);
			addChild(backB);
			backB.setClick(goBack);
			//if(this.contains(dispText)){removeChild(dispText)}
			dispText = new txt(sw,30);
			dispText.text.height=30;
			dispText.x=sw/2-dispText.width/2;dispText.y=sh/40;
			dispText.text.text = 'Themes';
			addChild(dispText);
		}
		private function init_(e:Event):void
		{
			setup();
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, goBack);
			//backB.setcolor(MovieClip(parent).uiColor);
			//warnText.setcolor(MovieClip(parent).uiColor);
		}
		private function setup():void
		{	
			warnText.x=0;
			warnText.y=sh/4;
			warnText.text.width = sw;
			warnText.text.height = sh/2;
			
			backB.x=sw/2-backB.width/2;backB.y=sh-sh/25-backB.height;
			
			nArray=[];
			nArray.push('Cool');
			nArray.push('Hot');
			nArray.push('Unicorn');
			nArray.push('Light');
			nArray.push('LSD');
			
			rpArray=[];
			rpArray.push(0);
			rpArray.push(500);
			rpArray.push(1000);
			rpArray.push(1500);
			rpArray.push(2000);
			
			fArray=[];
			fArray.push(cool);
			fArray.push(hot);
			fArray.push(uni);
			fArray.push(nocol);
			fArray.push(LSD);
			
			for(var i:int=0; i < 5;i++)
			{
				txtArray[i]=new txt(sw,-1);
				if(rpArray[i]>MovieClip(parent).sharedData.data.high)
				{
					txtArray[i].text.alpha=0.4;
					txtArray[i].settext(nArray[i]+':reach '+rpArray[i]+' points');
				}
				else
				{
					txtArray[i].text.alpha=1;
					txtArray[i].settext(nArray[i]+':'+getString(MovieClip(parent).sharedData.data.XonArray[i]));
				}
				//txtArray[i].setcolor(MovieClip(parent).uiColor);
				txtArray[i].text.width=400;
				txtArray[i].text.height=30;
				txtArray[i].y=60+i*(txtArray[i].height+10);
				txtArray[i].x=sw/2-txtArray[i].width/2;
				if(MovieClip(parent).sharedData.data.XonArray[i]){txtArray[i].setcolor(0xFFFAAA);}
				else{txtArray[i].setcolor(0xFFFFFF);}
				txtArray[i].addEventListener(MouseEvent.CLICK,fArray[i]);
				//txtArray[i].addEventListener(MouseEvent.CLICK,fArray[i]);
				addChild(txtArray[i]);
			}
		}
		
		private function cool(m:MouseEvent):void{enableE(0);}
		private function hot(m:MouseEvent):void{enableE(1);}
		private function uni(m:MouseEvent):void{enableE(2);}
		private function nocol(m:MouseEvent):void{enableE(3);}
		private function LSD(m:MouseEvent):void
		{
			enableE(4);
			if(MovieClip(parent).sharedData.data.XonArray[4]){epilepsy();}
		}
		
		private function epilepsy():void
		{
			addChild(upL);
		}
		private function remEp(m:MouseEvent):void
		{
			removeChild(upL);
		}
		private function enableE(i:int):void
		{
			if(rpArray[i]<=MovieClip(parent).sharedData.data.high){
			MovieClip(parent).sharedData.data.XonArray[i]=!MovieClip(parent).sharedData.data.XonArray[i];
			for(var m:int = 0; m < MovieClip(parent).sharedData.data.XonArray.length;m++)
			{
				if(m!=i)
				{
					MovieClip(parent).sharedData.data.XonArray[m]=false;
					if(MovieClip(parent).sharedData.data.XonArray[m]){txtArray[m].setcolor(0xFFFAAA);}
					else{txtArray[m].setcolor(0xFFFFFF);}
					if(rpArray[m]>MovieClip(parent).sharedData.data.high)
					{
						txtArray[m].text.alpha=0.4;
						txtArray[m].settext(nArray[m]+':reach '+rpArray[m]+' points');
					}
					else
					{
						txtArray[m].settext(nArray[m]+':'+getString(MovieClip(parent).sharedData.data.XonArray[m]));
					}
				}
			}
			if(MovieClip(parent).sharedData.data.XonArray[i]){txtArray[i].setcolor(0xFFFAAA);}
			else{txtArray[i].setcolor(0xFFFFFF);}
			txtArray[i].settext(nArray[i]+':'+getString(MovieClip(parent).sharedData.data.XonArray[i]));}
		}
		//-------------------------getstring----------------------
		private function getString(b:Boolean):String
		{
			if(b){return 'Enabled'}
			else{return 'Disabled'}
		}
		//---------------------------go back-----------------------
		private function goBack(event:KeyboardEvent=null):void
		{
			if (!event || (event && event.keyCode == Keyboard.BACK)){
				if (event){event.preventDefault();event.stopImmediatePropagation()};
				arrMan.rmArray(this,txtArray);txtArray=[];
				NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, goBack);
				MovieClip(parent).addChild(MovieClip(parent).co1);
				MovieClip(parent).addChild(MovieClip(parent).mid);
				MovieClip(parent).addChild(MovieClip(parent).co2);
				MovieClip(parent).setup();
				MovieClip(parent).menu();
				MovieClip(parent).removeChild(this);
			}
		}
	}
}