package de.waveumleditor.view.diagrammer.classDiagram.links
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	
	import flash.geom.Point;
	
	/**
	 * This class provides functionality for dependency-links
	 */
	public class VDependencyLink extends VClassLink
	{
		public function VDependencyLink()
		{
			super();
		}
		
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			return true;
		}
		
		override public function update(linkData:MClassLink):void
		{
			if (linkData is MDependencyLink)
			{
				var depLink:MDependencyLink = linkData as MDependencyLink;
				this.linkName = depLink.getName();
				
				invalidateDisplayList();
			}
		}
		
		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new VDependencyLinkContextPanel;
			this.linkContextPanel.setLink(this);
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}
		
		override protected function drawLineBetween(point1:Point, point2:Point):void 
		{
			dashLine(point1.x, point1.y, point2.x, point2.y, 3, 5);
		}

	}
}