package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	public class EditSingleAttribute
	{

		public var controller:Controller;
		public var classData:UMLClass;
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
		
		public function setClassData(classData:UMLClass):void
        {
        	this.classData = classData;
        }
        
        public function getClassData():UMLClass
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