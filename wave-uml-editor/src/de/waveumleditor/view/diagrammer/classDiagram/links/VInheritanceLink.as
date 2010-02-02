package de.waveumleditor.view.diagrammer.classDiagram.links
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
	import flash.geom.Point;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VInterfaceNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	
	/**
	 * This class provides functionality for inheritance-links
	 */
	public class VInheritanceLink extends VClassLink
	{
		public function VInheritanceLink()
		{
			super();
		}
		
		/**
		 * This method is called when a connection is made to the target node.
		 * Connections can be made between :
		 * 		1. Interface and Interface
		 * 		2. Class and Class
		 */
		override public function canLink(fromNode:BaseNode, toNode:BaseNode):Boolean 
		{
			if (fromNode == toNode) 
			{
				return false;
			}
			else if (fromNode is VInterfaceNode && toNode is VInterfaceNode)
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
			drawTriangle(point1.x, point1.y, point2.x, point2.y, bottomColor, topColor);
		}
	}
}