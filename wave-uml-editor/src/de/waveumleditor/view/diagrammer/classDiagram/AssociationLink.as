package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.Diagram;
	
	import de.waveumleditor.model.classDiagram.link.EAssociationType;
	
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	import mx.events.ResizeEvent;
	
	public class AssociationLink extends ClassLink
	{
		[Bindable] public var linkMultiplicityFrom:String;
		[Bindable] public var linkMultiplicityTo:String;
		[Bindable] public var linkAttributeFrom:String;
		[Bindable] public var linkAttributeTo:String;
		[Bindable] public var linkNavigableFrom:Boolean;
		[Bindable] public var linkNavigableTo:Boolean;
		[Bindable] public var linkAssoziationType:EAssociationType;
		
		protected var labelMultiplicityFrom:Label;
		protected var labelMultiplicityTo:Label;
		protected var labelAttributeFrom:Label;
		protected var labelAttributeTo:Label;
		
		public function AssociationLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			return true;
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new AssociationLinkContextPanel();
			this.linkContextPanel.setLink(this);
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
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
				//Positioning of the label in the middle position of the line
				if(this.linkName != null && this.linkName != "") 
				{
					var point:Point;
					if(this.toNode == this.fromNode)
					{
						point = new Point(fromNode.x + fromNode.width, fromNode.y + fromNode.height);
						this.label.x = point.x - this.label.width/2;
						this.label.y = point.y + 24;
					}
					else
					{
						point = this.getMidlePoint();
						this.label.x = point.x - this.label.width/2;
						this.label.y = point.y - this.label.height;
					}
					
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
				
				//Positioning of the Label from the node at the position above the line
				if(this.linkMultiplicityFrom != null && this.linkMultiplicityFrom != "") 
				{
					point = null;
					if(this.toNode == this.fromNode)
					{
						point = new Point(fromNode.x + fromNode.width, fromNode.y + fromNode.height);
						this.labelMultiplicityFrom.x = point.x + 16;
						this.labelMultiplicityFrom.y = point.y - 25 - labelMultiplicityFrom.height;
					}
					else
					{
						if(pointFromNode.x > pointToNode.x)
						{
							this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width - 10;
						}
						else
						{
							this.labelMultiplicityFrom.x = pointFromNode.x;
						}
						this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height;
					}
					
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
				
				//Positioning of the Label from the node at the position under the line
				if(this.linkAttributeFrom != null && this.linkAttributeFrom != "") 
				{
					point = null;
					if(this.toNode == this.fromNode)
					{
						point = new Point(fromNode.x + fromNode.width, fromNode.y + fromNode.height);
						this.labelAttributeFrom.x = point.x + 30;
						this.labelAttributeFrom.y = point.y - 8 - labelAttributeFrom.height;
					}
					else
					{
						if(pointFromNode.x > pointToNode.x)
						{
							this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width - 10;
						}
						else
						{
							this.labelAttributeFrom.x = pointFromNode.x;
						}
						this.labelAttributeFrom.y = pointFromNode.y + labelAttributeFrom.height;
					}
					
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
				
				//Positioning of the Label to the node at the position above the line
				if(this.linkMultiplicityTo != null && this.linkMultiplicityTo != "") 
				{
					point = null;
					if(this.toNode == this.fromNode)
					{
						point = new Point(fromNode.x + fromNode.width, fromNode.y + fromNode.height);
						this.labelMultiplicityTo.x = point.x - 35 - labelMultiplicityTo.width;
						this.labelMultiplicityTo.y = point.y - 3;
					}
					else
					{
						if(pointFromNode.x > pointToNode.x)
						{
							this.labelMultiplicityTo.x = pointToNode.x;
						}
						else
						{
							this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width - 10;
						}
						this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height;
					}
					
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
				
				//Positioning of the Label to the node at the position under the line
				if(this.linkAttributeTo != null && this.linkAttributeTo != "") 
				{
					point = null;
					if(this.toNode == this.fromNode)
					{
						point = new Point(fromNode.x + fromNode.width, fromNode.y + fromNode.height);
						this.labelAttributeTo.x = point.x - 15;
						this.labelAttributeTo.y = point.y - 3;
					}
					else
					{
						if(pointFromNode.x > pointToNode.x)
						{
							this.labelAttributeTo.x = pointToNode.x;
						}
						else
						{
							this.labelAttributeTo.x = pointToNode.x - this.labelAttributeTo.width - 10;
						}
						this.labelAttributeTo.y = pointToNode.y + labelAttributeTo.height;
					}
					
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
		
		override protected function drawStartSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkAssoziationType == EAssociationType.ASSOCIATION)
			{
				if(linkNavigableFrom)
				{
					super.drawEndSymbol(point2, point1, bottomColor, topColor);
				}
			}
			
			if(linkAssoziationType == EAssociationType.AGGREGATION)
			{
				drawVoidDiamond(point2.x, point2.y, point1.x, point1.y, bottomColor, topColor);
			}
			
			if(linkAssoziationType == EAssociationType.COMPOSITION)
			{
				drawDiamond(point2.x, point2.y, point1.x, point1.y, bottomColor, topColor);
			}
			
		}
		
		/**
		 * Helper Method for calculate the angle between two points
		 * 
		 */
		protected function lineAngle(point1:Point, point2:Point):Number
		{ 
			var angle:Number;
			var rad:Number = 180 / Math.PI;

			angle = Math.atan2(point2.y - point1.y, point2.x - point1.x);
			
			return angle * rad;
		}

		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkAssoziationType == EAssociationType.ASSOCIATION)
			{
				if(linkNavigableTo)
				{
					super.drawEndSymbol(point1, point2, bottomColor, topColor);
				}
			}
		}

		protected function drawVoidDiamond(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void
		{
			this.performVoidDiamondDrawing(x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);		
			this.performVoidDiamondDrawing(x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
	  	}		
		
		protected function performVoidDiamondDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void
		{
			this.graphics.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var point1:Point = new Point(x1,y1);
			var point2:Point = new Point(x2,y2);
			var pt3:Point;
			var distance:Number;
			var angle:Number = Math.atan2(y2-y1, x2-x1);
			var boxFromX2:int = fromNode.x+fromNode.width;
		    var boxFromY2:int = fromNode.y+fromNode.height;
		    var boxToX2:int = toNode.x+toNode.width;
		    var boxToY2:int = toNode.y+toNode.height;
			
			graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			graphics.lineTo(x2, y2);
			graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));				
			
			
			if(this.toNode == this.fromNode)
			{
				graphics.lineTo(x2+20, y2);
				graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  				y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
				graphics.beginFill(0x7E949F,0.8);
			}
			else
			{
				if (fromNode.x>boxToX2 && boxFromY2<toNode.y)
				{
					pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);
			  		graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT_TOP";
			    }
			    else if (fromNode.x>boxToX2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);
					graphics.lineTo(pt3.x,pt3.y);
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT";
			    }
			    else if (fromNode.x>boxToX2 && fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
		  	  		graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT_BOTTOM";
			    }
			    else if (fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"BOTTOM";
			    }
			    else if (boxFromX2<toNode.x && fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));//"LEFT_BOTTOM";
			    }
			    else if (boxFromX2<toNode.x && boxFromY2<toNode.y)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"LEFT_TOP";
			    }
			    
			    else if (boxFromY2<toNode.y)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"TOP";
			    }
			    else if (boxFromX2<toNode.x)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"LEFT";
			    }
		 	}
		    
		    graphics.beginFill(0x7E949F,0.8);
												
		}
		
		
		protected function drawDiamond(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void
		{
			this.performDiamondDrawing(x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);		
			this.performDiamondDrawing(x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
	  	}		
		
		protected function performDiamondDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void
		{
			this.graphics.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var point1:Point = new Point(x1,y1);
			var point2:Point = new Point(x2,y2);
			var pt3:Point;
			var angle:Number = Math.atan2(y2-y1, x2-x1);
			var boxFromX2:int = fromNode.x+fromNode.width;
		    var boxFromY2:int = fromNode.y+fromNode.height;
		    var boxToX2:int = toNode.x+toNode.width;
		    var boxToY2:int = toNode.y+toNode.height;
			
			graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			graphics.lineTo(x2, y2);
			graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));				
			
			
			if(this.toNode == this.fromNode)
			{
				graphics.lineTo(x2+20, y2);
				graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  				y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
				graphics.beginFill(0xFFFFFF,1.0);
			}
			else
			{
				if (fromNode.x>boxToX2 && boxFromY2<toNode.y)
				{
					pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);
			  		graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT_TOP";
			    }
			    else if (fromNode.x>boxToX2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
					graphics.lineTo(pt3.x,pt3.y);
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT";
			    }
			    else if (fromNode.x>boxToX2 && fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
		  	  		graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"RIGHT_BOTTOM";
			    }
			    else if (fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"BOTTOM";
			    }
			    else if (boxFromX2<toNode.x && fromNode.y>boxToY2)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));//"LEFT_BOTTOM";
			    }
			    else if (boxFromX2<toNode.x && boxFromY2<toNode.y)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"LEFT_TOP";
			    }
			    
			    else if (boxFromY2<toNode.y)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"TOP";
			    }
			    else if (boxFromX2<toNode.x)
			    {
			    	pt3 = Point.interpolate(point1,point2,0.08);
				
					graphics.lineTo(pt3.x,pt3.y);	
			    	graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));//"LEFT";
			    }
		 	}
		    
		    graphics.beginFill(0xFFFFFF,1.0);
												
		}
		
	}
}