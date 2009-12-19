package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flash.events.MouseEvent;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.TextInput;

	public class EditParameterElement extends GridRow
	{
		public var variable:Variable;
		private var editWindow:EditSingleMethod;
		private static var idCounter:int = 0;
		
		//types Combo-Box Data provider
		[Bindable]
        public var type:Array = new Array(
              "String", 
              "boolean", 
              "int",
              "double" );
		
		public function EditParameterElement(variable:Variable, editWindow:EditSingleMethod)
		{
			super();
			
			this.editWindow = editWindow;
			
			this.variable = variable;
			this.percentWidth=100;
			this.setStyle("verticalAlign", "center");
			this.name = "gr"+(idCounter).toString();
			this.id = "gr"+(idCounter).toString();
			
			
			//Typ
			var giType:GridItem = new GridItem();
			var cbType:ComboBox = new ComboBox();
			cbType.dataProvider = type;
			giType.addChild(cbType);
			this.addChild(giType);
			
			//Name
			var giName:GridItem = new GridItem();
			var tiName:TextInput = new TextInput();
			tiName.maxChars = 20;
			tiName.width = 100;
			tiName.text = variable.getName();
			giName.addChild(tiName);
			this.addChild(giName);
			
			//Default Wert
			var giDefaultValue:GridItem = new GridItem();
			var tiDefaultValue:TextInput = new TextInput();
			tiDefaultValue.maxChars = 20;
			tiDefaultValue.width = 100;
			tiDefaultValue.text = variable.getDefaultValue();
			giDefaultValue.addChild(tiDefaultValue);
			this.addChild(giDefaultValue);
			
			var emptyGridItem:GridItem = new GridItem();
			emptyGridItem.percentWidth=100;
			this.addChild(emptyGridItem);

			var deleteGridItem:GridItem = new GridItem();
			deleteGridItem.percentWidth = 100;
			deleteGridItem.setStyle("horizontalAlign", "right");
			deleteGridItem.addChild(getDeleteButtonOfElement(this.variable));
			this.addChild(deleteGridItem);
		}
		
		
		public function getDeleteButtonOfElement(variable:Variable):Button
		{
			var deleteButton:Button = new Button();
			deleteButton.label="-";
			deleteButton.width=35;
			deleteButton.height=15;
			deleteButton.id = (idCounter++).toString();
			
			deleteButton.addEventListener(MouseEvent.CLICK, editWindow.handleDeleteParameter);

			return deleteButton;
		}
		
		public function hasValidParameter():Boolean
		{
			if(this.variable == null)
			{
				return false;
			}
			if(this.variable.getName()=="")
			{
				return false;
			}
			
			return true;
		}
	}
}