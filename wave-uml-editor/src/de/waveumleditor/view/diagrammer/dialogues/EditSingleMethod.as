package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	public class EditSingleMethod
	{

		public var controller:Controller;
		private var classData:UMLClass;
		public var isConstructor:Boolean;
		public var editMethodsWindow:EditMethodsWindow;

		
		public function EditSingleMethod()
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
        
        public function setEditMethodsWindow(editMethodsWindow:EditMethodsWindow):void
        {
        	this.editMethodsWindow = editMethodsWindow;
        }
        
        public function getEditMethodsWindow():EditMethodsWindow
        {
        	return this.editMethodsWindow;
        }
        

	}
}