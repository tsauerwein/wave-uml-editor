package de.waveumleditor.view.diagrammer.classDiagram
{
	import de.waveumleditor.model.classDiagram.IClassElement;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Label;
	import mx.core.*;

	public class ClassNodeElement extends GridRow
	{
		
		public function ClassNodeElement(element:IClassElement)
		{
			super();
			var label:Label = new Label();
			Formatter.formatLabelOfClassElement(element, label);
			
			var gridItem:GridItem = new GridItem();
			gridItem.setActualSize(100, 100);
			
			gridItem.addChild(label);
			this.addChild(gridItem);
		}
		
	}
}