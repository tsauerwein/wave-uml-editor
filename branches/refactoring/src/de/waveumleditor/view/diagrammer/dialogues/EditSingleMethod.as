package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	import flash.events.Event;
	
	public class EditSingleMethod
	{

		public var controller:Controller;
		private var classData:MClassDiagramNode;
		public var isConstructor:Boolean;
		public var editMethodsWindow:EditMethodsWindow;

		
		public function EditSingleMethod():void
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
        	this.classData = classData;
        }
        
        public function getClassData():MClassDiagramNode
        {
        	return this.classData;
        }
        
        public function setEditMethodsWindow(editMethodsWindow:EditMethodsWindow):void
        {
        	this.editMethodsWindow = editMethodsWindow;
        }
        
        public function getEditMethodsWindow():EditMethodsWindow
        {
        	return this.editMethodsWindow;
        }
        
        public function handleDeleteParameter(event:Event):void
        {
        	
        }
        

	}
}