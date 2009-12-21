package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.view.diagrammer.events.NodeMethodEvent;
	
	import flash.events.Event;
	
	import mx.controls.Button;
	
	public class EditMethods implements IEditWindow
	{
		private var controller:Controller;
		private var classDiagramNode:ClassDiagramNode;
		
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
		
		public function setClassData(classDiagramNode:ClassDiagramNode):void
        {
        	this.classDiagramNode = classDiagramNode;
        }
        
        public function getClassData():ClassDiagramNode
        {
        	//TODO 
        	return this.classDiagramNode;
        }

		public function update(nodeData:ClassDiagramNode):void 
		{
			
		}
		
		public function handleAdd(event:Event):void
		{
			trace("add method handler");
			
			var methodEvent:NodeMethodEvent = new NodeMethodEvent(getClassData(), null, this, WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER);
			controller.handleShowSingleMethod(methodEvent);
			/* var newMethod:ClassMethod = new ClassMethod(new Identifier("default_meth"), "", EVisibility.PUBLIC, Type.STRING);
                
            var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
            editSingleMethod.update(newMethod);//TODO Methode über Id holen
            editSingleMethod.popUp(); */
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
            
            //Mockup Methode
			//var mockupMethod:ClassMethod = new ClassMethod(new Identifier("meth004"), "getMyString", EVisibility.PUBLIC, Type.STRING);

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
		
	}
}