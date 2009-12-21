package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	import flash.events.Event;
	
	public interface IEditWindow
	{
		function handleAdd(event:Event):void;
		
		function handleDelete(event:Event):void;
		
		function handleEdit(event:Event):void;
		
		function getController():Controller;
		
		function getClassData():ClassDiagramNode;
		
		
		
	}
}