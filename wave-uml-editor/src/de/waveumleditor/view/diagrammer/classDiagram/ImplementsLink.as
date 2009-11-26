package de.waveumleditor.view.diagrammer.classDiagram
{
	
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;

	public class ImplementsLink extends ClassLink
	{
		public function ImplementsLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			return false;
		}
		
		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new ImplementsLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void
		{
			drawTriangle(point1.x, point1.y, point2.x, point2.y, bottomColor, topColor);
		}

		override protected function drawLineBetween(point1:Point, point2:Point):void 
		{
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);
		}
	}
}