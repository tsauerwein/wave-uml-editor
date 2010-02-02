package de.waveumleditor.view.diagrammer.classDiagram.links
{
	
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VInterfaceNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;

	/**
	 * This class provides functionality for implements-links
	 */
	public class VImplementsLink extends VClassLink
	{
		public function VImplementsLink()
		{
			super();
		}
		
		/**
		 * This method is called when a connection is made to the target node.
		 * Only when the target node is an Interface, the connection can be made.
		 */
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			if (fromNode is VClassNode && toNode is VInterfaceNode)
			{
				return true;
			} 
			return false;
		}
		
		override protected function createLinkContextPanel():void
		{
			this.linkContextPanel = new VImplementsLinkContextPanel;
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