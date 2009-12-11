package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.BaseNode;
	
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
			this.linkContextPanel = new AssociationLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
			this.linkContextPanel.addEventListener("describeLink", handleDescribeLink);
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
		}
		
	}
}