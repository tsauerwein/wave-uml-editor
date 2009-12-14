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
			this.linkContextPanel = new AssociationLinkContextPanel();
			this.linkContextPanel.setLink(this);
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);
		}
		
		override protected function drawStartSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkNavigableFrom)
			{
				super.drawEndSymbol(point2, point1, bottomColor, topColor);
			}
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{
			if(linkNavigableTo)
			{
				super.drawEndSymbol(point1, point2, bottomColor, topColor);
			}
		}
	}
}