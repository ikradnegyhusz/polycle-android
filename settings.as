package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	//import flash.desktop.NativeApplication;

	public class settings extends MovieClip
	{
		private var backB:button;
		private var bP:backP = new backP();
		private var holder:Bitmap;
		private var partString:String;
		private var tiltString:String;
		private var partText:txt;
		private var shakeText:txt;
		private var textText:txt;
		private var tiltText:txt;
		private var musicText:txt;
		private var soundText:txt;
		private var dispText:txt;
		private var creditText:txt
		private var sw:int;
		private var sh:int;
		private var spaceY:int = 25;
		private var Xpos:int;
		private var textWidths:int = 300;
		private var textHeights:int = 30;
		private var textSize:int = 22;
		private var Ypos:int = 20;
		//---credits
		private var creditSprite:Sprite = new Sprite();
		private var black:fullFill = new fullFill();
		private var dCredits:txt;
		private var zCredits:txt;
		private var yt_btn:button;
		private var tw_btn:button;
		private var r_btn:button;
		private var yt_logo:youtube_logo = new youtube_logo;
		private var tw_logo:twitter_logo = new twitter_logo;
		private var r_logo:reddit_logo = new reddit_logo;
		
		public function settings(sW:int=640,sH:int=360)
		{
			sw=sW;sh=sH;
			addEventListener(Event.ADDED_TO_STAGE,init_)
			setup();
		}
		private function init_(e:Event):void
		{
			updatePartS();
			updateShake();
			updateTextT();
			updateTilt();
			updateMusic();
			updateSound();
			//NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, goBack);
			/*backB.setcolor(MovieClip(parent).uiColor);
			partText.setcolor(MovieClip(parent).uiColor);
			textText.setcolor(MovieClip(parent).uiColor);
			shakeText.setcolor(MovieClip(parent).uiColor);*/
		}
		private function setup():void
		{
			dispText=new txt(sw,30);
			dispText.text.text = 'Settings';
			spawn(dispText,sw/2-dispText.width/2,sh/40);
			
			//bakcB
			holder=new Bitmap(bP);
			backB = new button(false,70,holder);
			spawn(backB,sw/2-backB.width/2,sh-sh/25-backB.height);
			backB.setClick(goBack);
			
			Xpos=sw/4-textWidths/2;

			musicText=new txt(sw, textSize);
			musicText.text.width = textWidths;
			musicText.text.height = textHeights;
			spawn(musicText, Xpos, Ypos+(sh/2-musicText.height*3.5-spaceY));
			
			soundText=new txt(sw, textSize);
			soundText.text.width = textWidths;
			soundText.text.height = textHeights;
			spawn(soundText, Xpos,Ypos+(musicText.y+spaceY));
			
			partText=new txt(sw, textSize);
			partText.text.width=textWidths;
			partText.text.height=textHeights;
			spawn(partText,Xpos,Ypos+(soundText.y+spaceY));
			
			Xpos=sw/4*3-textWidths/2;

			tiltText=new txt(sw, textSize);
			tiltText.text.width = textWidths;
			tiltText.text.height = textHeights;
			spawn(tiltText, Xpos, Ypos+(sh/2-tiltText.height*3.5-spaceY));
			
			shakeText=new txt(sw, textSize);
			shakeText.text.width=textWidths;
			shakeText.text.height=textHeights;
			spawn(shakeText,Xpos,Ypos+(tiltText.y+spaceY));
			
			textText=new txt(sw, textSize);
			textText.text.width=textWidths;
			textText.text.height=textHeights;
			spawn(textText,Xpos,Ypos+(shakeText.y+spaceY));
			
			creditText = new txt(sw, textSize);
			creditText.text.width = textWidths;
			creditText.text.height = textHeights;
			creditText.text.text = "Credits"
			creditText.setcolor(0xFFFAAA);
			spawn(creditText, sw/2-creditText.width/2, Ypos+(textText.y+spaceY*1.5));
			
			//events
			partText.addEventListener(MouseEvent.CLICK,setPart);
			shakeText.addEventListener(MouseEvent.CLICK,setShake);
			textText.addEventListener(MouseEvent.CLICK,setGameText);
			tiltText.addEventListener(MouseEvent.CLICK,setTilt);
			musicText.addEventListener(MouseEvent.CLICK,setMusic);
			soundText.addEventListener(MouseEvent.CLICK,setSound);
			creditText.addEventListener(MouseEvent.CLICK,showCredits);
			
			
			var bg=new Bitmap(black);
			dCredits=new txt(sw, 25);
			dCredits.text.width = sw;
			dCredits.text.height = sh/4;
			dCredits.x = sw/2-dCredits.width/2;
			dCredits.y = sh/4-dCredits.height/2;
			dCredits.text.text = "Code, design, ideas, test, music&sounds:\n@D__Media";
			
			zCredits=new txt(sw-1, 25);
			zCredits.text.width = sw;
			zCredits.text.height = sh/4;
			zCredits.x = sw/2-zCredits.width/2;
			zCredits.y = sh/4*3-zCredits.height/2;
			zCredits.text.text = "Additional code, ideas, test:\nu/zoldalma999";
			
			holder=new Bitmap(yt_logo);
			yt_btn = new button(false, 50, holder, false);
			yt_btn.x = sw/2 - yt_btn.width
			yt_btn.y = dCredits.y + dCredits.height/1.5;
			yt_btn.setClick(openYt);
			holder=new Bitmap(tw_logo);
			tw_btn = new button(false, 50, holder, false);
			tw_btn.x = sw/2 + tw_btn.width/2
			tw_btn.y = dCredits.y + dCredits.height/1.5;
			tw_btn.setClick(openTw);
			holder=new Bitmap(r_logo);
			r_btn = new button(false, 50, holder, false);
			r_btn.x = sw/2-r_btn.width/4;
			r_btn.y = zCredits.y+ zCredits.height/1.5;
			r_btn.setClick(openR);


			creditSprite.addChild(bg);
			creditSprite.addChild(dCredits);
			creditSprite.addChild(zCredits);
			creditSprite.addChild(tw_btn);
			creditSprite.addChild(yt_btn);
			creditSprite.addChild(r_btn);
			
			
			creditSprite.addEventListener(MouseEvent.CLICK, hideCredits);
		}

		private function showCredits(m:MouseEvent):void{
			addChild(creditSprite);
		}
		private function hideCredits(m:MouseEvent):void{
			removeChild(creditSprite);
		}
		public function openYt(){
			var request: URLRequest = new URLRequest("https://www.youtube.com/channel/UCIeSk8Yj2mucuuHgPTotnjw");
			navigateToURL(request);
			//NativeApplication.nativeApplication.exit();
		}
		public function openTw(){
			var request: URLRequest = new URLRequest("https://twitter.com/D__Media");
			navigateToURL(request);
			//NativeApplication.nativeApplication.exit();
		}
		public function openR(){
			var request: URLRequest = new URLRequest("https://www.reddit.com/user/zoldalma999");
			navigateToURL(request);
			//NativeApplication.nativeApplication.exit();
		}
		//----------------------------------particles---------------------------------
		private function setPart(m:MouseEvent):void
		{
			if(partString!='VERY HIGH')MovieClip(parent).sharedData.data.pNum+=5;
			else{MovieClip(parent).sharedData.data.pNum=0};
			updatePartS();
		}
		private function updatePartS():void
		{
			if(MovieClip(parent).sharedData.data.pNum==0){partString='NONE'}
			else if(MovieClip(parent).sharedData.data.pNum==5){partString='LOW'}
			else if(MovieClip(parent).sharedData.data.pNum==10){partString='HIGH'}
			else if(MovieClip(parent).sharedData.data.pNum==15){partString='VERY HIGH'}
			partText.text.text='Effects: '+partString;
			changeColor(MovieClip(parent).sharedData.data.pNum!=0,partText);
		}
		//----------------------------------ingame text---------------------------------
		private function setGameText(m:MouseEvent):void
		{
			if (MovieClip(parent).sharedData.data.inGameText != 2){MovieClip(parent).sharedData.data.inGameText += 1}
			else {MovieClip(parent).sharedData.data.inGameText = 0}
			updateTextT();
		}
		private function updateTextT():void
		{	
			var temp_text:String;
			if (MovieClip(parent).sharedData.data.inGameText == 2){temp_text = "On"}
			if (MovieClip(parent).sharedData.data.inGameText == 1){temp_text = "Reduced"}
			if (MovieClip(parent).sharedData.data.inGameText == 0){temp_text = "Off"}
			textText.text.text = 'In game text: '+temp_text;
			changeColor(MovieClip(parent).sharedData.data.inGameText!=0,textText);
		}
		//----------------------------------shake---------------------------------
		private function setShake(m:MouseEvent):void
		{
			MovieClip(parent).sharedData.data.shake=!MovieClip(parent).sharedData.data.shake;
			updateShake();
		}
		private function updateShake():void
		{
			var temp_text:String;
			if (MovieClip(parent).sharedData.data.shake){temp_text = "On"}
			else{temp_text = "Off"};
			shakeText.text.text = 'Screen shake: '+temp_text;
			changeColor(MovieClip(parent).sharedData.data.shake,shakeText);
		}
		
		
		//--------------------------------------controls text--------------------------------------
		private function setTilt(m:MouseEvent):void{
			MovieClip(parent).sharedData.data.tilt=!MovieClip(parent).sharedData.data.tilt;
			updateTilt();
		}
		private function updateTilt():void{
			if (MovieClip(parent).sharedData.data.tilt){tiltString = "Tilt"}
			else {tiltString = "Touch"};
			tiltText.text.text = "Controls: "+tiltString;
			tiltText.setcolor(0xFFFAAA);
		}
		
		//--------------------------------------music text--------------------------------------
		private function setMusic(m:MouseEvent):void{
			MovieClip(parent).sharedData.data.music=!MovieClip(parent).sharedData.data.music;
			updateMusic();
		}
		private function updateMusic():void{
			var temp_text:String;
			if (MovieClip(parent).sharedData.data.music){temp_text = "On"}
			else{temp_text = "Off"};
			musicText.text.text = "Music: "+temp_text
			changeColor(MovieClip(parent).sharedData.data.music,musicText);
		}
		//--------------------------------------sound text--------------------------------------
		private function setSound(m:MouseEvent):void{
			MovieClip(parent).sharedData.data.sound=!MovieClip(parent).sharedData.data.sound;
			updateSound();
		}
		private function updateSound():void{
			var temp_text:String;
			if (MovieClip(parent).sharedData.data.sound){temp_text = "On"}
			else{temp_text = "Off"};
			soundText.text.text = "Sound: "+temp_text
			changeColor(MovieClip(parent).sharedData.data.sound,soundText);
		}
		//-------------------------------------------other------------------------------------------
		private function changeColor(b:Boolean,t:txt):void
		{
			if(b){t.setcolor(0xFFFAAA)}
			else{t.setcolor(0xFFFFFF)}
		}
		private function spawn(s:Sprite,X:Number=0,Y:Number=0):void
		{
			if(this.contains(s)){removeChild(s);}
			s.x=X;
			s.y=Y;
			addChild(s);
		}
		private function goBack(event:KeyboardEvent=null):void{
			if (!event || (event && event.keyCode == Keyboard.BACK)){
				if (event){event.preventDefault();event.stopImmediatePropagation()};
				//NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, goBack);
				if(this.contains(creditSprite)){removeChild(creditSprite);}
				MovieClip(parent).addChild(MovieClip(parent).co1);
				MovieClip(parent).addChild(MovieClip(parent).mid);
				MovieClip(parent).addChild(MovieClip(parent).co2);
				MovieClip(parent).setup();
				MovieClip(parent).menu();
				MovieClip(parent).setupMusic();
				MovieClip(parent).removeChild(this);
			}
		}
	}
}