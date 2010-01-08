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
		
		//public static const DEFAULT_IDENTIFIER:Identifier = new Identifier("default_meth");

		
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

		public function update(nodeData:MClassDiagramNode):void 
		{
			
		}
		
		public function handleAdd(event:Event):void
		{
			trace("add method handler");
			var methodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER);
			controller.handleShowSingleMethod(methodEvent);
		}
		
		public function handleDelete(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("delete method handler: " + buttonClicked.id);	

            var nodeMethodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, new Identifier(buttonClicked.id));
			controller.handleRemoveMethod(nodeMethodEvent);
		}
		
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit method handler: " + buttonClicked.id);

			var nodeMethodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, new Identifier(buttonClicked.id));
			controller.handleShowSingleMethod(nodeMethodEvent);
			
            /*var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
            editSingleMethod.update(mockupMethod);//TODO Attribut über Id holen
            editSingleMethod.popUp(); */
		}
		
		public function handleAddConstructor(event:Event):void
		{
			//TODO
			trace("handleAddConstructor");
			
			var methodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER);
			controller.handleShowSingleMethod(methodEvent);
		}
		
		public function handleEditConstructor(event:Event):void
		{
			//TODO DELETE -> wird mit handleEdit aufgerufen
/*			trace("handleEditConstructor");
			var buttonClicked:Button = event.currentTarget as Button;
			
			var nodeMethodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, new Identifier(buttonClicked.id));
			controller.handleShowSingleConstructor(nodeMethodEvent);*/
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