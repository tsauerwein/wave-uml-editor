package de.waveumleditor.view.diagrammer.dialogues
{
	
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	import flash.events.Event;
	
	import mx.controls.Button;
	
	public class EditAttributes implements IEditWindow
	{
		private var classData:UMLClass;
		
		
		public function EditAttributes()
		{
		}
		
		private var controller:Controller;
        
        public function setController(controller:Controller):void
        {
        	this.controller = controller;
        }
        
        public function getController():Controller
        {
        	return this.controller;
        }
            
        public function setClassData(classData:UMLClass):void
        {
        	this.classData = classData;
        }
        
        public function getClassData():UMLClass
        {
        	return this.classData;
        }

		public function handleAdd(event:Event):void
		{
			trace("add attribute handler");
/*		    var defaultVariable:Variable = new Variable("", Type.STRING);
        	var newAttribute:ClassAttribute = new ClassAttribute(new Identifier("default_attr"), defaultVariable, EVisibility.PUBLIC, false);
            
            var editSingleAttribute:EditSingleAttributeWindow = new EditSingleAttributeWindow();
            editSingleAttribute.update(newAttribute);//TODO Attribut über Id holen
            editSingleAttribute.popUp();
            */
		}
		
		public function handleDelete(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("delete class element handler " + buttonClicked.id);
		}
		
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit attribute handler:" + buttonClicked.id);
            
            var editSingleAttribute:EditSingleAttributeWindow = new EditSingleAttributeWindow();
            //TODO
            //editSingleAttribute.update(classData.getAttributeById(buttonClicked.id));
            editSingleAttribute.popUp();
			
		}
	}
}