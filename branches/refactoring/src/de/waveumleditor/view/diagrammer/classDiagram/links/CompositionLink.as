package de.waveumleditor.view.diagrammer.classDiagram.links
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VInterfaceNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	
	//TODO delete
	
	public class CompositionLink extends VClassLink
	{
		public function CompositionLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			if (fromNode == toNode) 
			{
				return false;
			}
			else if (fromNode is VInterfaceNode || toNode is VInterfaceNode)
			{
				return true;
			} 
			else if (fromNode is VClassNode && toNode is VClassNode)
			{
				return true;
			}
			
			return false;
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new VInheritanceLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);				
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void
		{
			var x1:Number = point1.x;
			var y1:Number = point1.y;
			var x2:Number = point2.x;
			var y2:Number = point2.y;
			
			this.graphics.lineStyle(this.getStyle("lineThickness"),topColor,0.70);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			
			var angle:Number = Math.atan2(y2-y1, x2-x1);
			
			
			graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  				y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			  				
			graphics.lineTo(x2, y2);
			
			graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  				y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));
			
			graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),	
			  				y2+arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			
		}
	}
}