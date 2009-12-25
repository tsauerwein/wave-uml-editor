package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flash.events.MouseEvent;
	
	import mx.containers.GridItem;
	import mx.containers.GridRow;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.TextInput;

	public class EditParameterElement extends GridRow
	{
		public var variable:MVariable;
		private var editWindow:EditSingleMethod;
		private static var idCounter:int = 0;
		
		public var cbType:ComboBox;
		public var tiName:TextInput;
		public var tiDefaultValue:TextInput;
		
		//types Combo-Box Data provider
		[Bindable]
        public var type:Array = new Array(
              "String", 
              "boolean", 
              "int",
              "double" );
		
		public function EditParameterElement(variable:MVariable, editWindow:EditSingleMethod)
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
			cbType = new ComboBox();
			cbType.editable = true;
			cbType.dataProvider = type;
			giType.addChild(cbType);
			this.addChild(giType);
			//Typ
			var current_type:String = variable.getType().getName();
			if(type.indexOf(current_type)<0)
			{
				type.push(current_type);
			}
			cbType.selectedItem = current_type;
			
			//Name
			var giName:GridItem = new GridItem();
			tiName = new TextInput();
			tiName.maxChars = 20;
			tiName.width = 100;
			tiName.text = variable.getName();
			giName.addChild(tiName);
			this.addChild(giName);
			
			//Default Wert
			var giDefaultValue:GridItem = new GridItem();
			tiDefaultValue = new TextInput();
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
		
		public function getVariable():MVariable
		{
			var newType:MType;
			if(type.indexOf(cbType.selectedItem)<0)
			{
				newType = new MType(cbType.text);
			}
			else
			{
				newType = new MType(cbType.selectedItem.toString());
			}
			this.variable.setType(newType);
			this.variable.setName(tiName.text);
			this.variable.setDefaultValue(tiDefaultValue.text);
			
			return this.variable;
		}
		
		public function getDeleteButtonOfElement(variable:MVariable):Button
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
			if(this.tiName.text=="")
			{
				return false;
			}
			
			return true;
		}
	}
}