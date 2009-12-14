package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;
	
	public class DependencyLink extends ClassLink
	{
		public function DependencyLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			return true;
		}
		
		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new DependencyLinkContextPanel;
			this.linkContextPanel.setLink(this);
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}

		override protected function drawLineBetween(point1:Point, point2:Point):void 
		{
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);
		}

	}
}