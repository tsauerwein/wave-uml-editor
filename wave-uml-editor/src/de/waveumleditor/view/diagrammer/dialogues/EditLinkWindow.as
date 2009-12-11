package de.waveumleditor.view.diagrammer.dialogues
{
	import de.waveumleditor.controller.Controller;
	

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
	}
}