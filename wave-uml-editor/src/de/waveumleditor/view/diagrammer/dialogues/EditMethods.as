package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.events.NodeMethodEvent;
	
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	
	public class EditMethods implements IEditWindow
	{
		private var controller:Controller;
		private var classDiagramNode:MClassDiagramNode;
	
		public function EditMethods()
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
		
		public function setClassData(classDiagramNode:MClassDiagramNode):void
        {
        	this.classDiagramNode = classDiagramNode;
        }
        
        public function getClassData():MClassDiagramNode
        {
        	//TODO 
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
			trace("wrong update method called");
		}
		
		/**
		 * This method calls the appropriate handler of the controller to add a new method
		 * to the edit methods dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleAdd(event:Event):void
		{
			trace("add method handler");
			var methodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER);
			controller.handleShowSingleMethod(methodEvent);
		}
		
		/**
		 * This method calls the appropriate handler of the controller to remove a method
		 * from the edit methods dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleDelete(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("delete method handler: " + buttonClicked.id);	

            var nodeMethodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, new Identifier(buttonClicked.id));
			controller.handleRemoveMethod(nodeMethodEvent);
		}
		
		/**
		 * This method calls the appropriate handler of the controller to edit a method
		 * and open an edit single method dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit method handler: " + buttonClicked.id);

			var nodeMethodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, new Identifier(buttonClicked.id));
			controller.handleShowSingleMethod(nodeMethodEvent);
			
		}
		
		/**
		 * This method calls the appropriate handler of the controller to edit a constructor
		 * and open an edit single method dialog
		 *  
		 * @param event
		 * 
		 */
		public function handleAddConstructor(event:Event):void
		{
			//TODO
			trace("handleAddConstructor");
			
			var methodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER);
			controller.handleShowSingleMethod(methodEvent);
		}
		
		public function handleRemoveConstructor(event:Event):void
		{
			//TODO
			trace("handleRemoveConstructor");
		}
		
		public function getTitleWindow():TitleWindow
		{
			return null;
		}

	}
}