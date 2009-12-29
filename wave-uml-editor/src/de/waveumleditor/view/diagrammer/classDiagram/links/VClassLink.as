package de.waveumleditor.view.diagrammer.classDiagram.links
{
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.EAssociationType;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	import mx.events.ResizeEvent;
	
	public class VClassLink extends Link implements IIdentifiable
	{
		
		private var key:Identifier;
		
		public function VClassLink()
		{
			super();
		}

		public function update(linkData:MClassLink):void
		{
			// can be overriden in child-classes
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

		protected function performTriangleDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void 
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

		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function setIdentifier(key:Identifier):void
		{
			this.key = key;
		}
		
		protected function getLineStartPoint():Point
		{
			var x:Number = 0;
			var y:Number = 0;
			var ptr:Point;
			
			if(this.fromNode != null && this.toNode != null)
			{
			
				if (this.fromNode == this.toNode) 
				{
					x = this.fromNode.x + this.fromNode.width + 20;
					y = this.fromNode.y + this.fromNode.height + 20;
				} 
				else 
				{
					
					var fromNodeCenterPoint:Point = new Point(this.fromNode.x+this.fromNode.width/2, this.fromNode.y+this.fromNode.height/2);
					var toNodeCenterPoint:Point = new Point(this.toNode.x + this.toNode.width/2, this.toNode.y + this.toNode.height/2);
					var point1:Point = this.getBoundary(fromNodeCenterPoint, toNodeCenterPoint, this.fromNode);
					var point2:Point = this.getBoundary(toNodeCenterPoint,fromNodeCenterPoint, this.toNode);
					
					ptr = Point.interpolate(point2,point1,0.02);
					x = ptr.x;
					y = ptr.y;
				}
			
			}	
			
			return new Point(x,y);		
		}
		
		protected function getLineEndPoint():Point
		{
			var x:Number = 0;
			var y:Number = 0;
			var ptr:Point;
			
			if(this.fromNode != null && this.toNode != null)
			{
				if (this.fromNode == this.toNode) {
					x = this.fromNode.x + this.fromNode.width + 20;
					y = this.fromNode.y + this.fromNode.height + 20;
				} 
				else 
				{
					var fromNodeCenterPoint:Point = new Point(this.fromNode.x+this.fromNode.width/2, this.fromNode.y+this.fromNode.height/2);
					var toNodeCenterPoint:Point = new Point(this.toNode.x + this.toNode.width/2, this.toNode.y + this.toNode.height/2);
					var point1:Point = this.getBoundary(fromNodeCenterPoint, toNodeCenterPoint, this.fromNode);
					var point2:Point = this.getBoundary(toNodeCenterPoint,fromNodeCenterPoint, this.toNode);
					
					ptr = Point.interpolate(point1,point2,0.02);
					x = ptr.x;
					y = ptr.y;
				}
			}
			return new Point(x,y);
					
		}
		
		protected function setLabelStyle(lab:Label):void
		{
			lab.setStyle("fontFamily", this.getStyle("labelFontFamily"));
			lab.setStyle("fontSize", "12");
			lab.setStyle("color",this.getStyle("labelFontColor"));
			lab.setStyle("fontWeight","bold");
			lab.setStyle("align","left");
		}
		
				
		
	}
}