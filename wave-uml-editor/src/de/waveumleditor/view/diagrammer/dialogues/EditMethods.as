package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	import flash.events.Event;
	
	import mx.controls.Button;
	
	public class EditMethods implements IEditWindow
	{
		private var controller:Controller;
		private var classData:UMLClass;

		
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
			trace("add method handler");
			var newMethod:ClassMethod = new ClassMethod(new Identifier("default_meth"), "", EVisibility.PUBLIC, Type.STRING);
                
            var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
            editSingleMethod.update(newMethod);//TODO Methode über Id holen
            editSingleMethod.popUp();
		}
		
		public function handleDelete(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("delete method handler: " + buttonClicked.id);	
		}
		
		public function handleEdit(event:Event):void
		{
			var buttonClicked:Button = event.currentTarget as Button;
            trace("edit method handler: " + buttonClicked.id);
            
            //Mockup Methode
			var mockupMethod:ClassMethod = new ClassMethod(new Identifier("meth004"), "getMyString", EVisibility.PUBLIC, Type.STRING);
            
            var editSingleMethod:EditSingleMethodWindow = new EditSingleMethodWindow();
            editSingleMethod.update(mockupMethod);//TODO Attribut über Id holen
            editSingleMethod.popUp();
		}
	}
}