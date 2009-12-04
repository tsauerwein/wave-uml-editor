package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.model.classDiagram.IClassElement;
	import de.waveumleditor.view.diagrammer.classDiagram.Formatter;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Button;
	import mx.controls.Label;

	public class EditClassNodeElement extends GridRow
	{
		private var element:IClassElement;
		
		public function EditClassNodeElement(element:IClassElement)
		{
			super();
			this.element = element;
			
			var label:Label = new Label();
			Formatter.formatLabelOfClassElement(element, label);
			
			var gridItem:GridItem = new GridItem();
			gridItem.width=200;
			
			gridItem.addChild(label);
			this.addChild(gridItem);
			
			var editGridItem:GridItem = new GridItem();
			editGridItem.addChild(getEditButtonOfElement(this.element));
			this.addChild(editGridItem);
			
			var deleteGridItem:GridItem = new GridItem();
			deleteGridItem.addChild(getDeleteButtonOfElement(this.element));
			this.addChild(deleteGridItem);
		}
		
		public static function getEditButtonOfElement(element:IClassElement):Button
		{
			var editButton:Button = new Button();
			editButton.label="edit";
			editButton.height=15;
			//TODO id des edit buttons setzen
			
			return editButton;
		}
		
		public static function getDeleteButtonOfElement(element:IClassElement):Button
		{
			var deleteButton:Button = new Button();
			deleteButton.label="-";
			deleteButton.height=15;
			deleteButton.width=30;
			//TODO id des delete buttons setzen
			
			return deleteButton;
		}
		
	}
}