package de.waveumleditor.view.diagrammer.classDiagram
{
	import flash.geom.Point;
	
	
	public class InheritanceLink extends ClassLink
	{
		public function InheritanceLink()
		{
			super();
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