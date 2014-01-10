﻿/** * general display object and layout helpers */package com.johannesneumeier.utils {		import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.display.MovieClip;	import flash.display.Shape;		import fl.transitions.easing.*;	import fl.transitions.Tween;	import fl.transitions.TweenEvent;	public class DisplayHelper 	{		public static var tweens:Array = new Array();		/**		 * removed all children (any display objects) from given movieclip		 */		public static function removeChildren(dob:DisplayObjectContainer):int 		{			var numChildrenRemoved:int = 0;			while (dob.numChildren) {				dob.removeChildAt(0);				numChildrenRemoved++;			}			return numChildrenRemoved;		}		/**		 * make a mask to be used as a shape		 *		 * @param _width  - what width the mask object should be		 * @param _height - what height the mask object should be		 * @return Shape		 */		public static function makeMask(_width:Number, _height:Number, 			_color:uint = 0x00002100):Shape 		{			var sh:Shape = new Shape();			sh.graphics.beginFill(_color);			sh.graphics.drawRect(0, 0, _width, _height);			sh.graphics.endFill();			return sh;		}		/**		 * rudimentary helper to layout all movieclips inside 'holder' along a grid		 *		 * @param holder      - movieclip containing the displayobjects to lay out in a grid		 * @param columns 	  - number of columns		 * @param columnWidth - horizontal space between items		 * @param rowHeight	  - vertical space between items from one row to the next		 */		public static function spreadContentsToGrid(holder:MovieClip, columns:int = 3, 			columnWidth:int = 120, rowHeight:int = 90):void 		{						var cols:int  = columns;			var colW:int  = columnWidth;			var rowH:int  = rowHeight;			var nextX:int = 0;			var nextY:int = 0;			for (var i:int = 0; i < holder.numChildren; i++) {				var child:DisplayObject = holder.getChildAt(i);				child.x = nextX;				child.y = nextY;				if ((i + 1) % cols == 0 && i > 0) {					nextY += rowH;					nextX = 0;				} else {					nextX += colW;				}			}		}		/**		 * scales a DisplayObject to fit within the bounds provided by @param w and @param h		 */		public static function scaleToFit(dob:DisplayObject, w:Number, h:Number):void 		{			if (dob.width > w || dob.height > h) {				if (dob.width / dob.height < w / h) {					dob.height = h;					dob.scaleX = dob.scaleY;				} else {					dob.width = w;					dob.scaleY = dob.scaleX;				}			}		}		public static function fade(what:DisplayObject, to:Number = 0, duration:Number = 0.5, from:Number = -1, 			tweeningFunction:Function = Regular.easeInOut, cb:Function = null) 		{			if (from < 0) {				from = what.alpha;			}			var t:Tween = new Tween(what, "alpha", tweeningFunction, from, to, duration, true);			t.addEventListener(TweenEvent.MOTION_FINISH, function (e:TweenEvent) {					// execute callback if one was provided					if (cb !== null) {						cb();					}					// remove reference to the tween that was stored to prevent garbage collection					tweens.splice(tweens.indexOf(e.target), 1);				});			tweens.push(t);		}	}}