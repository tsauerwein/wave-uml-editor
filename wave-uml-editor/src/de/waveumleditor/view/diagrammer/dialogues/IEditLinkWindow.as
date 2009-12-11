package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	
	import flash.events.Event;

	public interface IEditLinkWindow
	{
		function getController():Controller;
		
		function getLinkData():LinkDependency;
	}
}