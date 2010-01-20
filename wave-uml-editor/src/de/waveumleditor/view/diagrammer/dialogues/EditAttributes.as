package de.waveumleditor.view.diagrammer.dialogues
{
	
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.events.NodeAttributeEvent;
	
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	
	public class EditAttributes implements IEditWindow
	{
		private var classDiagramNode:MClassDiagramNode;
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
            
        public function setClassData(classData:MClassDiagramNode):void
        {
        	this.classDiagramNode = classData;
        }
        
        public function getClassData():MClassDiagramNode
        {
        	return this.classDiagramNode;
        }
        
		
		/**
		 * This method updates the dialog according to the content of the given MClassDiagramNode object.
		 * It should be implemented by the derived class.
		 *  
		 * @param nodeData
		 * 
		 */
        public function update(nodeData:MClassDiagramNode):void
        {
        	trace("wrong update editAttributesWindow method called");
        }

		
		/**
		 * This method calls the appropriate handler of the controller to add a new attribte
		 * to the edit attributes dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleAdd(event:Event):void
		{
			trace("add attribute handler");
			
			var attributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData() as MClassNode, null, this, WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER);
			controller.handleShowSingleAttribute(attributeEvent);
		}
		
		/**
		 * This method calls the appropriate handler of the controller to remove an attribte
		 * from the edit attributes dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleDelete(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("delete class element handler " + buttonClicked.id);
            var nodeAttributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData() as MClassNode, null, this , new Identifier(buttonClicked.id));
            controller.handleRemoveAttribute(nodeAttributeEvent);
		}
		
		/**
		 * This method calls the appropriate handler of the controller to edit an attribute
		 * and open an edit single attribute dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit attribute handler:" + buttonClicked.id);

            var nodeAttributeEvent:NodeAttributeEvent = new NodeAttributeEvent(getClassData() as MClassNode, null, this , new Identifier(buttonClicked.id));
            controller.handleShowSingleAttribute(nodeAttributeEvent);
			
		}
		
		public function getTitleWindow():TitleWindow
		{
			return null;
		}
	}
}