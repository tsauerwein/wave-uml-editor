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
/*			if (fromNode is InterfaceNode && toNode is ClassNode)
			{
				return true;
			} else if (fromNode is ClassNode && toNode is ClassNode)
			{
				return true;
			} */
			
			if (toNode is ClassNode)
			{
				return true;
			}
			
			return false;
		}
		
		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new DependencyLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}

		override protected function drawLineBetween(point1:Point, point2:Point):void 
		{
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);
		}

	}
}