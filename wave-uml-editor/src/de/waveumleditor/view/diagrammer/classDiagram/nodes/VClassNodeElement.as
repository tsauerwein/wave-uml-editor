package de.waveumleditor.view.diagrammer.classDiagram.nodes
{
	import de.waveumleditor.model.classDiagram.nodes.IClassElement;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Label;
	import mx.core.*;
	import de.waveumleditor.view.diagrammer.classDiagram.Formatter;

	public class VClassNodeElement extends GridRow
	{
		
		public function VClassNodeElement(element:IClassElement)
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