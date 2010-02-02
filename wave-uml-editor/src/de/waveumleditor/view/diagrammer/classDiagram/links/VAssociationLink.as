package de.waveumleditor.view.diagrammer.classDiagram.links
{
	import com.anotherflexdev.diagrammer.BaseNode;
	import com.anotherflexdev.diagrammer.Diagram;
	
	import de.waveumleditor.model.classDiagram.links.EAssociationType;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	import mx.controls.Label;
	import mx.events.ResizeEvent;
	
	/**
	 * This class provides additional functionality and attributes for assoziation-links
	 */
	public class VAssociationLink extends VClassLink
	{
		[Bindable] public var linkMultiplicityFrom:String;
		[Bindable] public var linkMultiplicityTo:String;
		
		[Bindable] public var linkAttributeFrom:String;
		[Bindable] public var linkAttributeTo:String;
		
		[Bindable] public var linkNavigableFrom:Boolean;
		[Bindable] public var linkNavigableTo:Boolean;
		
		[Bindable] public var linkAssociationType:EAssociationType;
		
		protected var labelMultiplicityFrom:Label;
		protected var labelMultiplicityTo:Label;
		protected var labelAttributeFrom:Label;
		protected var labelAttributeTo:Label;
		
		public function VAssociationLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			return true;
		}
		
		override public function update(linkData:MClassLink):void
		{			
			if (linkData is MAssociationLink)
			{
				var association:MAssociationLink = linkData as MAssociationLink;
				
				// linkName is an attribute from Link.as
				this.linkName = association.getName();
				
				this.linkAttributeFrom = association.getFromName();
				this.linkMultiplicityFrom = association.getFromMultiplicity();
				this.linkNavigableFrom = association.getFromNavigable();
				
				this.linkAttributeTo = association.getToName();
				this.linkMultiplicityTo = association.getToMultiplicity();
				this.linkNavigableTo = association.getToNavigable();
				
				this.linkAssociationType = association.getType();
				
				invalidateDisplayList();
			}
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new VAssociationLinkContextPanel();
			this.linkContextPanel.setLink(this);
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}
		
		/**
		 * Creates the linkContextPanel for the Assoziation Link and if the Strings have been setted 
		 * the corresponding Labels for link discription will be created 
		 **/
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
		
		/**
		 * This method is call every Time when the link is moving. 
		 * It is responsable for the Label positioning at the assoziation-link.
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
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
				var pointFromNode:Point = this.getLineStartPoint();
				var pointToNode:Point = this.getLineEndPoint();
				var drawDirection:String = getDrawDirection(this.fromNode,this.toNode);
				var point:Point;
				
				//Positioning of the label in the middle position of the line
				if(this.linkName != null && this.linkName != "") 
				{
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
						if(drawDirection == "TOP")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width - 10;
							this.labelMultiplicityFrom.y = pointFromNode.y;
						}
						else if(drawDirection == "LEFT")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height - 10;
						}
						else if(drawDirection == "BOTTOM")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x + 10;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height;
						}
						else if(drawDirection == "RIGHT")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height - 10;
						}
						else if(drawDirection == "RIGHT_TOP")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width - 15;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height + 10;
						}
						else if(drawDirection == "LEFT_BOTTOM")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height - 20;	
						}
						else if(drawDirection == "LEFT_TOP")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x + 20;
							this.labelMultiplicityFrom.y = pointFromNode.y - 10;		
						}
						else if(drawDirection == "RIGHT_BOTTOM")
						{
							this.labelMultiplicityFrom.x = pointFromNode.x - labelMultiplicityFrom.width;
							this.labelMultiplicityFrom.y = pointFromNode.y - labelMultiplicityFrom.height - 20;
						}
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
						if(drawDirection == "TOP")
						{
							this.labelAttributeFrom.x = pointFromNode.x + 10;
							this.labelAttributeFrom.y = pointFromNode.y;
						}
						else if(drawDirection == "LEFT")
						{
							this.labelAttributeFrom.x = pointFromNode.x;
							this.labelAttributeFrom.y = pointFromNode.y + 10;
						}
						else if(drawDirection == "BOTTOM")
						{
							this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width - 10;
							this.labelAttributeFrom.y = pointFromNode.y - labelAttributeFrom.height;
						}
						else if(drawDirection == "RIGHT")
						{
							this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width;
							this.labelAttributeFrom.y = pointFromNode.y + 10;
						}
						else if(drawDirection == "RIGHT_TOP")
						{
							this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width;
							this.labelAttributeFrom.y = pointFromNode.y + 10;
						}
						else if(drawDirection == "LEFT_BOTTOM")
						{
							this.labelAttributeFrom.x = pointFromNode.x + 15;
							this.labelAttributeFrom.y = pointFromNode.y - 7;
						}
						else if(drawDirection == "LEFT_TOP")
						{
							this.labelAttributeFrom.x = pointFromNode.x;
							this.labelAttributeFrom.y = pointFromNode.y + 20;	
						}
						else if(drawDirection == "RIGHT_BOTTOM")
						{
							this.labelAttributeFrom.x = pointFromNode.x - labelAttributeFrom.width - 15;
							this.labelAttributeFrom.y = pointFromNode.y - 5;
						}
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
						if(drawDirection == "TOP")
						{
							this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width - 10;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height;
						}
						else if(drawDirection == "LEFT")
						{
							this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height - 10;
						}
						else if(drawDirection == "BOTTOM")
						{
							this.labelMultiplicityTo.x = pointToNode.x + 10;
							this.labelMultiplicityTo.y = pointToNode.y;
						}
						else if(drawDirection == "RIGHT")
						{
							this.labelMultiplicityTo.x = pointToNode.x;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height - 10;
						}
						else if(drawDirection == "RIGHT_TOP")
						{
							this.labelMultiplicityTo.x = pointToNode.x;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height - 10;
						}
						else if(drawDirection == "LEFT_BOTTOM")
						{
							this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height + 5;
						}
						else if(drawDirection == "LEFT_TOP")
						{
							this.labelMultiplicityTo.x = pointToNode.x - labelMultiplicityTo.width;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height - 10;	
						}
						else if(drawDirection == "RIGHT_BOTTOM")
						{
							this.labelMultiplicityTo.x = pointToNode.x;
							this.labelMultiplicityTo.y = pointToNode.y - labelMultiplicityTo.height + 5;
						}
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
						if(drawDirection == "TOP")
						{
							this.labelAttributeTo.x = pointToNode.x + 10;
							this.labelAttributeTo.y = pointToNode.y - labelAttributeTo.height;
						}
						else if(drawDirection == "LEFT")
						{
							this.labelAttributeTo.x = pointToNode.x - labelAttributeTo.width;
							this.labelAttributeTo.y = pointToNode.y + 10;
						}
						else if(drawDirection == "BOTTOM")
						{
							this.labelAttributeTo.x = pointToNode.x - labelAttributeTo.width - 10;
							this.labelAttributeTo.y = pointToNode.y;
						}
						else if(drawDirection == "RIGHT")
						{
							this.labelAttributeTo.x = pointToNode.x;
							this.labelAttributeTo.y = pointToNode.y + 10;
						}
						else if(drawDirection == "RIGHT_TOP")
						{
							this.labelAttributeTo.x = pointToNode.x;
							this.labelAttributeTo.y = pointToNode.y - 10;
						}
						else if(drawDirection == "LEFT_BOTTOM")
						{
							this.labelAttributeTo.x = pointToNode.x - labelAttributeTo.width;
							this.labelAttributeTo.y = pointToNode.y;
						}
						else if(drawDirection == "LEFT_TOP")
						{
							this.labelAttributeTo.x = pointToNode.x - labelAttributeTo.width;
							this.labelAttributeTo.y = pointToNode.y - 10;	
						}
						else if(drawDirection == "RIGHT_BOTTOM")
						{
							this.labelAttributeTo.x = pointToNode.x;
							this.labelAttributeTo.y = pointToNode.y;
						}
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
		
		/**
		 * Method to remove labels and link
		 */
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
		}
		
		/**
		 * This method draws the startsymbol of the link depending on the association-type 
		 */
		override protected function drawStartSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkAssociationType == EAssociationType.ASSOCIATION)
			{
				if(linkNavigableFrom)
				{
					super.drawEndSymbol(point2, point1, bottomColor, topColor);
				}
			}
			
			if(linkAssociationType == EAssociationType.AGGREGATION)
			{
				drawVoidDiamond(point2.x, point2.y, point1.x, point1.y, bottomColor, topColor);
			}
			
			if(linkAssociationType == EAssociationType.COMPOSITION)
			{
				drawDiamond(point2.x, point2.y, point1.x, point1.y, bottomColor, topColor);
			}
			
		}

		/**
		 * This method draws the endsymbol of the link depending on the association-type 
		 */
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkAssociationType == EAssociationType.ASSOCIATION)
			{
				if(linkNavigableTo)
				{
					super.drawEndSymbol(point1, point2, bottomColor, topColor);
				}
			}
		}
		
		/**
		 * Method to draw the symbol of an composition-link
		 */
		protected function drawDiamond(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void
		{
			var graphic:Graphics = this.graphics;
			this.performDiamondDrawing(graphic,x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);	
			graphics.beginFill(0xFFFFFF,1.0);	
			this.performDiamondDrawing(graphic,x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
			graphics.beginFill(0xFFFFFF,1.0);
	  	}

		/**
		 * Method to draw the symbol of an aggregation-link 
		 */
		protected function drawVoidDiamond(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void
		{
			var graphic:Graphics = this.graphics;
			this.performDiamondDrawing(graphic,x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);	
			graphic.beginFill(0x7E949F,0.8);	
			this.performDiamondDrawing(graphic,x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
			graphic.beginFill(0x7E949F,0.8);
	  	}		
		
		protected function performDiamondDrawing(graphic:Graphics, x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void
		{
			graphic.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var point1:Point = new Point(x1,y1);
			var point2:Point = new Point(x2,y2);
			var pt3:Point;
			var distance:Number;
			var angle:Number = Math.atan2(y2-y1, x2-x1);
		    var drawDirection:String = getDrawDirection(this.fromNode,this.toNode);
			
			graphic.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			graphic.lineTo(x2, y2);
			graphic.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));				
			
			
			if(this.toNode == this.fromNode)
			{
				graphic.lineTo(x2+20, y2);
				graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  				y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			}
			else
			{
				distance = Point.distance(point1,point2);
				var factor:Number = 21 / distance;
				
				if (drawDirection == "RIGHT_TOP")
				{
					pt3 = Point.interpolate(point1,point2,factor);
				 				
					graphic.lineTo(pt3.x,pt3.y);
			  		graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "RIGHT")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "RIGHT_BOTTOM")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
		  	  		graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "BOTTOM")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
		  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "LEFT_BOTTOM")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "LEFT_TOP")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    
			    else if (drawDirection == "TOP")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
			    else if (drawDirection == "LEFT")
			    {
			    	pt3 = Point.interpolate(point1,point2,factor);
				
					graphic.lineTo(pt3.x,pt3.y);	
			    	graphic.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
				  					y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			    }
		 	}									
		}

	}
}