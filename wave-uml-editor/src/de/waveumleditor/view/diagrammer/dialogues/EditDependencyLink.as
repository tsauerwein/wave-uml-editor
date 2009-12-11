package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	

	public class EditDependencyLink implements IEditLinkWindow
	{
		private var linkData:LinkDependency;
		private var controller:Controller;
		
		public function EditDependencyLink()
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
		
		public function setLinkData(linkData:LinkDependency):void
		{
			this.linkData = linkData;
		}
		
		public function getLinkData():LinkDependency
		{
			return this.linkData;
		}
	}
}