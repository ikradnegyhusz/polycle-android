//CURRENT TASK:		none.
package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	public class store extends MovieClip
	{
		//help
		private var Help:help = new help();
		//ints/nums
		private var sbSize:int = 70;
		private var bbSize:int = 120;
		private var sw:int; private var sh:int;
		private var space:Number = 1.2;
		private var BPlace:int;
		//sound
		private var stM:store_music = new store_music();
		private var soundManager:sMan = new sMan(0);
		//Array
		private var pBs:Array = new Array();
		private var uBs:Array = new Array();
		private var BFuncs:Array = new Array();
		private var Bnames:Array = new Array();
		private var BPics:Array = new Array();
		private var prices:Array = new Array();
		private var maxLvl:Array = new Array();
		//graphics
		private var backPic:backP = new backP();
		private var powsPic:powsP = new powsP();
		private var upsPic:upsP = new upsP();
		private var qP:quesPic = new quesPic();
			//power
		private var boP:boomP = new boomP();
		private var buP:bulletP = new bulletP();
		private var pP:progressP = new progressP();
		private var imP:immortalP = new immortalP();
		private var lvlP:levelupP = new levelupP();
		private var hP:healthP = new healthP();
		private var frP:freezeP = new freezeP();
		private var shrP:shrinkP = new shrinkP();
		private var cP:coinsP = new coinsP();
		private var magP:magnetP = new magnetP();
			//upgrade
		private var sP:speedP = new speedP();
		private var daP:dashP = new dashP();
		private var huP:healthUpP = new healthUpP();
		private var poP:pointsP = new pointsP();
		private var imtP:imTP = new imTP();
		
		private var holder:Bitmap;
		//text
		private var dispText:txt=new txt();
		//buttons
		private var backB:button=new button();
		private var upB:button;
		private var abB:button;
		private var qB:button=new button();
		//sh
		//private var sharedStoreData=SharedObject.getLocal("2");

		public function store(w:int=640,h:int=360){sw=w;sh=h;setup(null, true);staticSetup();
			addEventListener(Event.ADDED_TO_STAGE,init_);}
		private function init_(e:Event):void
		{	
			soundManager.SetMusic(stM,0);
			soundManager.Play(0,0);
			if (!MovieClip(parent).sharedData.data.music){soundManager.Mute(0)}
			else {soundManager.unMute(0)}
			//'upgrade points: '+MovieClip(parent).sharedData.data.upPoints;
			if(MovieClip(parent).sharedData.data.boughtPArray==null){
				MovieClip(parent).sharedData.data.boughtPArray=new Array();
				for(var i:int = 0; i < 10; i++)
				{
					var b:Boolean = new Boolean();
					MovieClip(parent).sharedData.data.boughtPArray.push(b);
				}
			}
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, goBack);
		}
		private function spawn(ob:Sprite,X:Number,Y:Number):void
		{
			ob.x=X;ob.y=Y;
			addChild(ob);
		}
		public function setup(event:KeyboardEvent=null, first:Boolean=false):void
		{
			if ((event && event.keyCode == Keyboard.BACK)){
				event.preventDefault();event.stopImmediatePropagation();}
			Help.destroy(this);
			if(this.contains(backB)){removeChild(backB);}
			holder=new Bitmap(backPic);
			backB = new button(false,sbSize,holder);
			holder=new Bitmap(upsPic);
			upB = new button(true,bbSize,holder);
			holder=new Bitmap(powsPic);
			abB = new button(true,bbSize,holder);
			if(this.contains(qB)){this.removeChild(qB)};
			holder = new Bitmap(qP);
			qB = new button(false,sbSize/1.5,holder);
			spawn(backB,sw/2-backB.width/2,sh-sh/25-backB.height);
			abB.setClick(lPowers);
			upB.setClick(lUpgrades);
			upB.settext('Upgrades');
			abB.settext('Powers');
			//dels
			if(pBs.length>0){rmObArray(pBs);}pBs=[];
			if(uBs.length>0){rmObArray(uBs);}uBs=[];
			//spawn n further
			spawn(upB,sw/3-upB.width/2,sh/2-upB.height/2);
			spawn(abB,sw-sw/3-abB.width/2,sh/2-abB.height/2);
			//text
			dispText.text.text='Store';
			//listeners
			//backB.addEventListener(MouseEvent.CLICK, goBack);
			if(backB.hasEventListener(MouseEvent.CLICK)){backB.removeClick(setup);}
			if (!first){
				if(NativeApplication.nativeApplication.hasEventListener(KeyboardEvent.KEY_DOWN)){
					NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, goBack);
					NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, setup);
				}
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, goBack);
			}
			backB.setClick(goBack);
		}
		private function staticSetup():void
		{
			
			//text
			dispText = new txt(sw,30);
			dispText.text.width=400;
			dispText.text.text='Store';
			spawn(dispText,sw/2-dispText.width/2,sh/40);
			//int
			BPlace = sh/8;
			//arr
			for(var i:int = 0; i < 2;i++)
			{
				var nA:Array = new Array();
				var fA:Array = new Array();
				var pA:Array = new Array();
				var picA:Array = new Array();
				if(i==0)
				{
					nA.push('Boom');
					nA.push('Bullets');
					nA.push('Progress');
					nA.push('Immortal');
					nA.push('Level Up');
					nA.push('Health');
					nA.push('Freeze');
					nA.push('Shrink');
					nA.push('Coins');
					nA.push('Magnet');
					
					fA.push(beam);
					fA.push(bullets);
					fA.push(progress);
					fA.push(immortal);
					fA.push(lvlup);
					fA.push(health);
					fA.push(freeze);
					fA.push(shrink);
					fA.push(coins);
					fA.push(magnet);
					
					pA.push(500);
					pA.push(2300);
					pA.push(800);
					pA.push(900);
					pA.push(5000);
					pA.push(6000);
					pA.push(0);
					pA.push(200);
					pA.push(1500);
					pA.push(4000);
					
					picA.push(boP);
					picA.push(buP);
					picA.push(pP);
					picA.push(imP);
					picA.push(lvlP);
					picA.push(hP);
					picA.push(frP);
					picA.push(shrP);
					picA.push(cP);
					picA.push(magP);
				}
				else if(i==1)
				{
					nA.push('Speed');
					nA.push('Dash');
					nA.push('Health');
					nA.push('Points');
					nA.push('Immortal\nTime');
					
					fA.push(speed);
					fA.push(dash);
					fA.push(healthUp);
					fA.push(points);
					fA.push(imtime);
					
					maxLvl.push(15);
					maxLvl.push(15);
					maxLvl.push(5);
					maxLvl.push(10);
					maxLvl.push(5);
					
					picA.push(sP);
					picA.push(daP);
					picA.push(huP);
					picA.push(poP);
					picA.push(imtP);
				}
				Bnames.push(nA);
				BFuncs.push(fA);
				prices.push(pA);
				BPics.push(picA);
			}
		}
		private function rmMain():void
		{
			removeChild(abB);removeChild(upB);
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, goBack);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, setup);
			backB.removeClick(goBack);
			backB.setClick(setup);
		}
		//----------------powers-------------------
		private function lPowers():void
		{
			qB.setClick(PowerHelp);
			spawn(qB,sw-sw/10,sh-sh/6);
			dispText.text.text='coins: '+MovieClip(parent).sharedData.data.coins;
			rmMain();
			//--------------
			for (var i:int = 0;i<10;i++)
			{
				holder = new Bitmap(BPics[0][i]);
				var pB:button = new button(true,sbSize,holder);
				pB.setBoxSize(-1,50);
				if(MovieClip(parent).sharedData.data.boughtPArray[i] == true)
				{
					if(MovieClip(parent).sharedData.data.powerArray[i]==false)
					{
						setP(pB,i,false);
					}
					else if(MovieClip(parent).sharedData.data.powerArray[i]==true)
					{
						setP(pB,i,true);
					}
				}
				else
				{
					pB.setAlpha(0.6);
					pB.settext(Bnames[0][i]+'\n'+prices[0][i]);
				}
				if(i<5){spawn(pB,pB.width/1.1+i*pB.width*space+BPlace,BPlace);}
				else{spawn(pB,pB.width/1.1+(i-5)*pB.width*space+BPlace,BPlace+pB.height);}
				pB.setClick(BFuncs[0][i]);
				pBs.push(pB);
			}
			if(MovieClip(parent).sharedData.data.PUhelp){Help.showPic(this,12);MovieClip(parent).sharedData.data.PUhelp=false;}
		}
		private function setP(b:button,i:int,p:Boolean,swi:Boolean = false):void
		{
			if(p==false)
			{
				if(swi){MovieClip(parent).sharedData.data.powerArray[i]=!MovieClip(parent).sharedData.data.powerArray[i];}
				b.settext(Bnames[0][i]+'\nOFF');
				b.setAlpha(0.6);
			}
			else if(p==true)
			{
				if(swi){MovieClip(parent).sharedData.data.powerArray[i]=!MovieClip(parent).sharedData.data.powerArray[i];}
				b.settext(Bnames[0][i]+'\nON');
				b.setAlpha(1);
			}
		}
		private function beam():void{purchasePower(0,prices[0][0]);}
		private function bullets():void{purchasePower(1,prices[0][1]);}
		private function progress():void{purchasePower(2,prices[0][2]);}
		private function immortal():void{purchasePower(3,prices[0][3]);}
		private function lvlup():void{purchasePower(4,prices[0][4]);}
		private function health():void{purchasePower(5,prices[0][5]);}
		private function freeze():void{purchasePower(6,prices[0][6]);}
		private function shrink():void{purchasePower(7,prices[0][7]);}
		private function coins():void{purchasePower(8,prices[0][8]);}
		private function magnet():void{purchasePower(9,prices[0][9]);}
		//-------------------------upgrades---------------------------
		private function lUpgrades():void
		{
			qB.setClick(UpgradeHelp);
			spawn(qB,sw-sw/10,sh-sh/6);
			dispText.text.text = 'upgrade points: '+MovieClip(parent).sharedData.data.upPoints;
			rmMain();
			//-----------------
			for (var i:int = 0;i<5;i++)
			{
				holder = new Bitmap(BPics[1][i])
				var uB:button = new button(true,sbSize,holder);
				if(MovieClip(parent).sharedData.data.upgradeArray[i]==maxLvl[i])
				{
					uB.settext(Bnames[1][i]+'\nMAX');
				}
				else
				{
					uB.settext(Bnames[1][i]+'\n'+'lvl '+MovieClip(parent).sharedData.data.upgradeArray[i]);
				}
				uB.setBoxSize(-1,50);
				spawn(uB,uB.width/1.1+i*uB.width*space+BPlace,sh/2-uB.height/2);
				uB.setClick(BFuncs[1][i]);
				uBs.push(uB);
			}
			if(MovieClip(parent).sharedData.data.PUhelp){Help.showPic(this,12);MovieClip(parent).sharedData.data.PUhelp=false;}
		}
		
		private function speed():void{purchaseUpgrade(0);}
		private function dash():void{purchaseUpgrade(1);}
		private function healthUp():void{purchaseUpgrade(2);}
		private function points():void{purchaseUpgrade(3);}
		private function imtime():void{purchaseUpgrade(4);}
		//----------------------------purchase-----------------------
		public function purchasePower(i:int,cost:int):void
		{
			if(MovieClip(parent).sharedData.data.coins>=cost&&MovieClip(parent).sharedData.data.boughtPArray[i] == false)
			{
				MovieClip(parent).sharedData.data.coins -= cost;
				MovieClip(parent).sharedData.data.powerArray[i] = true;
				pBs[i].settext(Bnames[0][i]+'\nON');
				MovieClip(parent).sharedData.data.boughtPArray[i] = true;
				pBs[i].setAlpha(1);
				dispText.text.text='coins: '+MovieClip(parent).sharedData.data.coins;
			}
			else if(MovieClip(parent).sharedData.data.boughtPArray[i] == true)
			{
				if(MovieClip(parent).sharedData.data.powerArray[i]==true)
				{
					setP(pBs[i],i,false,true);
				}
				else if(MovieClip(parent).sharedData.data.powerArray[i]==false)
				{
					setP(pBs[i],i,true,true);
				}
			}
		}
		public function purchaseUpgrade(i:int):void
		{
			if(MovieClip(parent).sharedData.data.upPoints>=1&&MovieClip(parent).sharedData.data.upgradeArray[i]<maxLvl[i])
			{
				MovieClip(parent).sharedData.data.upPoints-=1;
				MovieClip(parent).sharedData.data.upgradeArray[i]+=1;
				dispText.text.text='upgrade points: '+MovieClip(parent).sharedData.data.upPoints;
				uBs[i].settext(Bnames[1][i]+'\n'+'lvl '+MovieClip(parent).sharedData.data.upgradeArray[i]);	
			}
			if(MovieClip(parent).sharedData.data.upgradeArray[i]==maxLvl[i])
			{
				uBs[i].settext(Bnames[1][i]+'\nMAX');
			}
		}
		//------------------------remove array------------------------
		private function rmObArray(a:Array,rm:Boolean=true):void
		{
			for(var i:int = 0; i < a.length; i++)
			{
				if(this.contains(a[i])&&rm){removeChild(a[i]);}
				a.splice(i,0);
			}
		}
		//--------------------------------help-----------------------------
		private function PowerHelp():void
		{
			Help.showPic(this,11);
			Help.setNexts([8,9]);
		}
		private function UpgradeHelp():void
		{
			Help.showPic(this,10);
		}
		//---------------------------go back-----------------------
		private function goBack(event:KeyboardEvent=null):void
		{
			if (!event || (event && event.keyCode == Keyboard.BACK)){
				if (event){event.preventDefault();event.stopImmediatePropagation()};
				NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, goBack);
				Help.destroy(this);
				soundManager.Stop(0);
				MovieClip(parent).checkAvPowers();
				MovieClip(parent).addChild(MovieClip(parent).co1);
				MovieClip(parent).addChild(MovieClip(parent).mid);
				MovieClip(parent).addChild(MovieClip(parent).co2);
				//MovieClip(parent).staticSetup();
				MovieClip(parent).setup();
				MovieClip(parent).menu();
				MovieClip(parent).setupMusic();
				MovieClip(parent).removeChild(this);
			}
		}
	}
}
