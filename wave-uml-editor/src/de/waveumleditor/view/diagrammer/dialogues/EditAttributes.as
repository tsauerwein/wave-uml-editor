package de.waveumleditor.view.diagrammer.dialogues
{
	
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.view.diagrammer.events.NodeAttributeEvent;
	
	import flash.events.Event;
	
	import mx.controls.Button;
	
	public class EditAttributes implements IEditWindow
	{
		private var classData:UMLClass;
		private var controller:Controller;
		
		public function EditAttributes()
		{
		}
        
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
        
        public function update(nodeData:ClassDiagramNode):void
        {
        	trace("wrong update editAttributesWindow method called");
        }

		public function handleAdd(event:Event):void
		{
			trace("add attribute handler");
			
			var attributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData(), null, this, ModelFascade.DEFAULT_ATTRIBUTE_IDENTIFIER);
			controller.handleShowSingleAttribute(attributeEvent);
			
		    //Default Attribut
		/* 	var defaultVariable:Variable = new Variable("", Type.STRING);
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
            var nodeAttributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData(), null, this , new Identifier(buttonClicked.id));
            controller.handleRemoveAttribute(nodeAttributeEvent);
		}
		
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit attribute handler:" + buttonClicked.id);

            var nodeAttributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData(), null, this , new Identifier(buttonClicked.id));
            controller.handleShowSingleAttribute(nodeAttributeEvent);
			
		}
	}
}