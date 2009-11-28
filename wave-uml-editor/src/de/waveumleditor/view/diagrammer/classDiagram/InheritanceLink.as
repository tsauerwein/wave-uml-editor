package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;
	
	
	public class InheritanceLink extends ClassLink
	{
		public function InheritanceLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			if (fromNode is InterfaceNode && toNode is InterfaceNode)
			{
				return true;
			} else if (fromNode is ClassNode && toNode is ClassNode)
			{
				return true;
			}
			
			return false;
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new InheritanceLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);				
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void
		{
			drawTriangle(point1.x, point1.y, point2.x, point2.y, bottomColor, topColor);
		}
	}
}