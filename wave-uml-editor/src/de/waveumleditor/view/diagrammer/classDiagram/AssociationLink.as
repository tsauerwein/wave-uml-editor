package de.waveumleditor.view.diagrammer.classDiagram
{
	import flash.geom.Point;
	

	public class AssociationLink extends ClassLink
	{
		
		public function AssociationLink()
		{
			super();
		}
		
		override protected function createLinkContextPanel():void 
		{
			this.linkContextPanel = new AssociationLinkContextPanel;
			this.linkContextPanel.addEventListener("removeLink", handleRemoveLink);				
		}
		
		override protected function drawEndSymbol(point1:Point, point2:Point, bottomColor:Number, topColor:Number):void 
		{}
		
	}
}