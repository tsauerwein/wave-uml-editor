package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Link;
	
	public class InheritanceLink extends Link
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
		
		override protected function drawSymbols(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void {
			drawTriangle(x1, y1, x2, y2,bottomColor, topColor);
		}
		
		private function drawTriangle(x1:Number, y1:Number, x2:Number, y2:Number, bottomColor:Number, topColor:Number):void{
			this.performTriangleDrawing(x1,y1,x2,y2,this.getStyle("lineThickness")+2,bottomColor,0.70);		
			this.performTriangleDrawing(x1,y1,x2,y2,this.getStyle("lineThickness"),topColor,0.70);		
		}	
		
		private function performTriangleDrawing(x1:Number, y1:Number, x2:Number, y2:Number, lineThickness:Number, color:Number, alpha:Number):void 
		{
			this.graphics.lineStyle(lineThickness, color, alpha);
			var arrowHeight:Number = 10;
			var arrowWidth:Number = 10;
			var angle:Number = Math.atan2(y2-y1, x2-x1);
			graphics.moveTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			this.graphics.lineTo(x2, y2);
			this.graphics.lineTo(x2-arrowHeight*Math.cos(angle)+arrowWidth*Math.sin(angle),	
			  							y2-arrowHeight*Math.sin(angle)-arrowWidth*Math.cos(angle));	
			this.graphics.lineTo(x2-arrowHeight*Math.cos(angle)-arrowWidth*Math.sin(angle),
			  							y2-arrowHeight*Math.sin(angle)+arrowWidth*Math.cos(angle));
			this.graphics.beginFill(0xFFFFFF,1.0);
		} 
	}
}