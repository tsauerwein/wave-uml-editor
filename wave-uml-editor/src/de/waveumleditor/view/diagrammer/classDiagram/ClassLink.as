package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.LabelLinkEvent;
	import com.anotherflexdev.diagrammer.Link;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	import mx.events.ResizeEvent;
	
	public class ClassLink extends Link
	{
		[Bindable] public var linkMultiplicityFrom:String;
		[Bindable] public var linkMultiplicityTo:String;
		[Bindable] public var linkAttributeFrom:String;
		[Bindable] public var linkAttributeTo:String;
		[Bindable] public var linkNavigableFrom:Boolean;
		[Bindable] public var linkNavigableTo:Boolean;
		
		protected var labelMultiplicityFrom:Label;
		protected var labelMultiplicityTo:Label;
		protected var labelAttributeFrom:Label;
		protected var labelAttributeTo:Label;
		
		private var key:Identifier;
		
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
		
		override protected function createChildren():void 
		{
			super.createChildren();
			if(!this.linkContextPanel) 
			{
				this.createLinkContextPanel();
			}		
			if(!this.label) 
			{
				this.label = new Label();
				this.label.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
				BindingUtils.bindProperty(this.label, "text", this, "linkName");
			}
			if(!this.labelMultiplicityFrom) 
			{
				this.labelMultiplicityFrom = new Label();
				this.labelMultiplicityFrom.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
				BindingUtils.bindProperty(this.labelMultiplicityFrom, "text", this, "linkMultiplicityFrom");		
			}
			if(!this.labelMultiplicityTo) 
			{
				this.labelMultiplicityTo = new Label();
				this.labelMultiplicityTo.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
				BindingUtils.bindProperty(this.labelMultiplicityTo, "text", this, "linkMultiplicityTo");
			}	
			if(!this.labelAttributeFrom) 
			{
				this.labelAttributeFrom = new Label();
				this.labelAttributeFrom.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
				BindingUtils.bindProperty(this.labelAttributeFrom, "text", this, "linkAttributeFrom");
			}
			if(!this.labelAttributeTo) 
			{
				this.labelAttributeTo = new Label();
				this.labelAttributeTo.addEventListener(ResizeEvent.RESIZE, handleLabelResize);
				BindingUtils.bindProperty(this.labelAttributeTo, "text", this, "linkAttributeTo");
			}	
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			var pointFromNode:Point = this.getLineStartPoint();
			var pointToNode:Point = this.getLineEndPoint();
			
			if(!this.fromNode && !this.toNode) 
			{
				return;
			}
			
			if(this.toNode == null)
			{
				this.drawTemplate();
			} 
			else 
			{
				this.draw();
			}
			if(this.linkContextPanel.parent != null) 
			{
				this.setLinkContextPanelPosition();
			}
			
			if(this.fromNode != null && this.toNode != null)
			{
				if(this.linkName != null && this.linkName != "") 
				{
					var point:Point = this.getMidlePoint();
					
					this.label.x = point.x;
					this.label.y = point.y;
					this.label.x -= this.label.width/2;
					this.label.y -= this.label.height;
					
					setLabelStyle(label);
					
					if(this.label.parent == null && this.parent != null) 
					{
						Diagram(parent).addChild(this.label);
					}
				} 
				else 
				{
					if(this.label.parent != null) 
					{
						Diagram(parent).removeChild(this.label);
					}
				}
				
				
				if(this.linkMultiplicityFrom != null && this.linkMultiplicityFrom != "") 
				{
					if(pointFromNode.x >= pointToNode.x)
					{
						this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width - 10;
					}
					else
					{
						this.labelMultiplicityFrom.x = pointFromNode.x;
					}
					this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height;
					
					setLabelStyle(labelMultiplicityFrom);
					
					if(this.labelMultiplicityFrom.parent == null && this.parent != null) 
					{
						Diagram(parent).addChild(this.labelMultiplicityFrom);
					}
				} 
				else 
				{
					if(this.labelMultiplicityFrom.parent != null) 
					{
						Diagram(parent).removeChild(this.labelMultiplicityFrom);
					}
				}
				
				if(this.linkAttributeFrom != null && this.linkAttributeFrom != "") 
				{
					
					if(pointFromNode.x >= pointToNode.x)
					{
						this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width - 10;
					}
					else
					{
						this.labelAttributeFrom.x = pointFromNode.x;
					}
					this.labelAttributeFrom.y = pointFromNode.y + labelAttributeFrom.height;
					
					setLabelStyle(labelAttributeFrom);
					
					if(this.labelAttributeFrom.parent == null && this.parent != null) 
					{
						Diagram(parent).addChild(this.labelAttributeFrom);
					}
				} 
				else 
				{
					if(this.labelAttributeFrom.parent != null) 
					{
						Diagram(parent).removeChild(this.labelAttributeFrom);
					}
				}
				
				if(this.linkMultiplicityTo != null && this.linkMultiplicityTo != "") 
				{
					if(pointFromNode.x >= pointToNode.x)
					{
						this.labelMultiplicityTo.x = pointToNode.x;
					}
					else
					{
						this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width - 10;
					}
					this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height;
					
					setLabelStyle(labelMultiplicityTo);
					
					if(this.labelMultiplicityTo.parent == null && this.parent != null) {
						Diagram(parent).addChild(this.labelMultiplicityTo);
					}
				
				} 
				else 
				{
					if(this.labelMultiplicityTo.parent != null) 
					{
						Diagram(parent).removeChild(this.labelMultiplicityTo);
					}
				}
				
				if(this.linkAttributeTo != null && this.linkAttributeTo != "") 
				{
					if(pointFromNode.x >= pointToNode.x)
					{
						this.labelAttributeTo.x = pointToNode.x;
					}
					else
					{
						this.labelAttributeTo.x = pointFromNode.x - this.labelAttributeTo.width - 10;
					}
					this.labelAttributeTo.y = pointFromNode.y + labelAttributeTo.height;
					
					setLabelStyle(labelAttributeTo);
					
					if(this.labelAttributeTo.parent == null && this.parent != null) 
					{
						Diagram(parent).addChild(this.labelAttributeTo);
					}
				} 
				else 
				{
					if(this.labelAttributeTo.parent != null) 
					{
						Diagram(parent).removeChild(this.labelAttributeTo);
					}
				}
			}
		}
		
		override protected function handleRemove(event:Event):void 
		{
			if(this.label.parent != null) {
				Diagram(parent).removeChild(this.label);
			}
			if(this.labelMultiplicityFrom.parent != null) {
				Diagram(parent).removeChild(this.labelMultiplicityFrom);
			}
			if(this.labelMultiplicityTo.parent != null) {
				Diagram(parent).removeChild(this.labelMultiplicityTo);
			}
			if(this.labelAttributeFrom.parent != null) {
				Diagram(parent).removeChild(this.labelAttributeFrom);
			}
			if(this.labelAttributeTo.parent != null) {
				Diagram(parent).removeChild(this.labelAttributeTo);
			}
			if(this.linkContextPanel.parent != null) {
				Diagram(parent).removeChild(this.linkContextPanel);
			}
			trace("AssoziationLink -> override protected function handleRemove()");
		}
		
		protected function getLineStartPoint():Point
		{
			var x:Number = 0;
			var y:Number = 0;
			
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
					var point2:Point = this.getBoundary(toNodeCenterPoint, fromNodeCenterPoint, this.toNode);
					x = point1.x;
					y = point1.x == point2.x ? point1.y + (point2.y - point1.y)/2 : this.getYBoundary(x, point2.x, point2.y, this.fromNode);
				}
			
			}	
			
			return new Point(x,y);		
		}
		
		protected function getLineEndPoint():Point
		{
			var x:Number = 0;
			var y:Number = 0;
			
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
					var point2:Point = this.getBoundary(toNodeCenterPoint, fromNodeCenterPoint, this.toNode);
					x = point2.x;
					y = point1.x == point2.x ? point1.y + (point2.y - point1.y)/2 : this.getYBoundary(x, point2.x, point2.y, this.fromNode);
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
		}
		
				
		
	}
}