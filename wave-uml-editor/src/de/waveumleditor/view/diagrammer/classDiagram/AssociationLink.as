package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import de.waveumleditor.model.classDiagram.link.EAssociationType;
	
	import flash.geom.Point;
	
	public class AssociationLink extends ClassLink
	{
		
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