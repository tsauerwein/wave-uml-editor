package de.waveumleditor.view.diagrammer.classDiagram
{
	
	import flash.geom.Point;

	public class ImplementsLink extends ClassLink
	{
		public function ImplementsLink()
		{
			super();
		}

		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new ImplementsLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}

		override protected function drawSymbols(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void {
			drawArrow(x1, y1, x2, y2,bottomColor, topColor);
		}

		protected function drawArrow(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void{
			this.performArrowDrawing(x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);
			this.performArrowDrawing(x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);
		}

		private function performArrowDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void
		{
			this.graphics.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var angle:Number = Math.atan2(y2-y1, x2-x1);

			this.graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			this.graphics.lineTo(x2, y2);
			this.graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));
		}


		override protected function drawLine(fromNodeCenterPoint:Point, toNodeCenterPoint:Point, bottomColor:uint, topColor:uint):void
		{
			var point1:Point = null;
			var point2:Point = null;

			if(this.toNode == null) {
				point1 = fromNodeCenterPoint;
				point2 = toNodeCenterPoint;
			} else {
				point1 = this.getBoundary(fromNodeCenterPoint, toNodeCenterPoint, this.fromNode);
				point2 = this.getBoundary(toNodeCenterPoint, fromNodeCenterPoint, this.toNode);
			}

			this.graphics.clear();
			//For easy event handling a transparent stronger line
			this.graphics.lineStyle(this.getStyle("lineThickness")+8, bottomColor, 0.1);
			this.graphics.moveTo(point1.x, point1.y);
			this.graphics.lineTo(point2.x, point2.y);
			//

			this.graphics.lineStyle(this.getStyle("lineThickness")+2, bottomColor, 0.70);
			this.graphics.moveTo(point1.x, point1.y);
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);

			this.graphics.lineStyle(this.getStyle("lineThickness"), topColor, 0.70);
			this.graphics.moveTo(point1.x, point1.y);
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);
			//this.graphics.

			drawSymbols(point1.x, point1.y, point2.x, point2.y, bottomColor, topColor);
		}


		private function dashLine(x1:Number, y1:Number, x2:Number, y2:Number, onLength:Number = 0, offLength:Number = 0):void
		{
			this.graphics.moveTo(x1,y1);
			if (offLength == 0)
			{
			    this.graphics.lineTo(x2,y2);
			    return;
			}

			var dx:Number = x2-x1,
			    dy:Number = y2-y1,
			    lineLen:Number = Math.sqrt(dx*dx + dy*dy),
			    angle:Number = Math.atan2(dy, dx),
			    cosAngle:Number = Math.cos(angle),
			    sinAngle:Number = Math.sin(angle),
			    ondx:Number  = cosAngle*onLength,
			    ondy:Number  = sinAngle*onLength,
			    offdx:Number = cosAngle*offLength,
			    offdy:Number = sinAngle*offLength,

			    x:Number = x1,
			    y:Number = y1;


			var fullDashCountNumber:int = Math.floor(lineLen /(onLength + offLength));

			for(var i:int=0; i < fullDashCountNumber; i++)
			{
			    this.graphics.lineTo(x += ondx, y += ondy);
			    this.graphics.moveTo(x += offdx,y += offdy);
			}

		    var remainder:Number = lineLen - ((onLength+offLength) * fullDashCountNumber);

		    if (remainder >= onLength)
		    {
		    	this.graphics.lineTo(x += ondx, y += ondy);
		    }
		    else
		    {
		        this.graphics.lineTo(x2,y2);
		    }
		}


	}
}