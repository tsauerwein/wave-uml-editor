package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flash.geom.Point;
	
	public class ClassLink extends Link
	{
		public function ClassLink()
		{
			super();
		}

		public function update(linkData:ClassDiagramLink):void
		{
			
		}
		
		override protected function drawStartSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{}
		
		/**
		 * Helper method which can be used in child-classes to draw a triangle.
		 * 
		 */ 
		protected function drawTriangle(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void
		{
			this.performTriangleDrawing(x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);		
			this.performTriangleDrawing(x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
		}

		private function performTriangleDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void 
		{
			this.graphics.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var angle:Number = Math.atan2(y2-y1, x2-x1);
			graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			this.graphics.lineTo(x2, y2);
			this.graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));	
			this.graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			this.graphics.beginFill(0xFFFFFF,1.0);
		}
		
		/**
		 * Helper method which can be used in child-classes to draw a dashed line.
		 * 
		 */
		protected function dashLine(x1:Number, y1:Number, x2:Number, y2:Number, onLength:Number = 0, offLength:Number = 0):void
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