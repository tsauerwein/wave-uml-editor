package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.IClassElement;
	import de.waveumleditor.view.diagrammer.classDiagram.Formatter;
	
	import flash.events.MouseEvent;
	
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
			this.percentWidth=100;
			
			var label:Label = new Label();
			Formatter.formatLabelOfClassElement(element, label);
			
			var gridItem:GridItem = new GridItem();
			gridItem.minWidth=200;
			gridItem.percentWidth=100;
			
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
			editButton.id= element.getIdentifier().getId();
			if(element is ClassAttribute){
				editButton.addEventListener(MouseEvent.CLICK, EditAttributesWindow.editAttributeHandler);
			}
			if(element is ClassMethod){
				editButton.addEventListener(MouseEvent.CLICK, EditMethodsWindow.editMethodHandler);
			}
			
			
			
			return editButton;
		}
		
		public static function getDeleteButtonOfElement(element:IClassElement):Button
		{
			var deleteButton:Button = new Button();
			deleteButton.label="-";
			deleteButton.height=15;
			deleteButton.width=35;
			deleteButton.id= element.getIdentifier().getId();
			
			return deleteButton;
		}
		
	}
}