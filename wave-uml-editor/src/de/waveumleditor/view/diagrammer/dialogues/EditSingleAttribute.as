package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	
	public class EditSingleAttribute
	{

		public var controller:Controller;
		public var classData:MClassNode;
		public var editAttributesWindow:EditAttributesWindow;

		
		public function EditSingleAttribute()
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
		
		public function setClassData(classData:MClassNode):void
        {
        	this.classData = classData;
        }
        
        public function getClassData():MClassNode
        {
        	return this.classData;
        }
        
        public function setEditAttributesWindow(editAttributesWindow:EditAttributesWindow):void
        {
        	this.editAttributesWindow = editAttributesWindow;
        }
        
        public function getEditAttributesWindow():EditAttributesWindow
        {
        	return this.editAttributesWindow;
        }

	}
}