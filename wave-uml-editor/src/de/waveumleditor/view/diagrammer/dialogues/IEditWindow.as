package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	import flash.events.Event;
	
	import mx.containers.TitleWindow;
	
	public interface IEditWindow
	{
		function handleAdd(event:Event):void;
		
		function handleDelete(event:Event):void;
		
		function handleEdit(event:Event):void;
		
		function getController():Controller;
		
		function getClassData():MClassDiagramNode;
		
		function getTitleWindow():TitleWindow;
		
		function update(nodeData:MClassDiagramNode):void;
	}
}