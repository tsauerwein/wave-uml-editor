package de.waveumleditor.view.diagrammer.classDiagram
{
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Label;

	public class ClassNodeElement extends GridRow
	{
		
		public function ClassNodeElement(elementContent:String)
		{
			super();
			var label:Label = new Label();
			label.htmlText = elementContent;
			label.setVisible(true);
			
			var gridItem:GridItem = new GridItem();
			gridItem.setActualSize(100, 100);
			
			gridItem.addChild(label);
			this.addChild(gridItem);
		}
		
	}
}