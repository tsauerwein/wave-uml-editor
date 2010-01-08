package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	
	import mx.containers.TitleWindow;
	

	public class EditLinkWindow
	{
		private var controller:Controller;
		
		public function EditLinkWindow()
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
		
		public function getTitleWindow():TitleWindow
		{
			return null;
		}
		
		public function getLink():MDependencyLink
		{
			return null;	
		}
	}
}