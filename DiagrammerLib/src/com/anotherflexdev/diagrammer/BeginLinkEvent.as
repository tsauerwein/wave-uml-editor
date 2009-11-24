package com.anotherflexdev.diagrammer
{
	import flash.events.MouseEvent;
	
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	public class BeginLinkEvent extends MouseEvent
	{
		private var linkFactory:IFactory;
		
		public function BeginLinkEvent(eventName:String, linkClass:Class, originalEvent:MouseEvent)
		{
			super(eventName, originalEvent.bubbles, originalEvent.cancelable, originalEvent.localX, 
				originalEvent.localY, originalEvent.relatedObject, originalEvent.ctrlKey, originalEvent.altKey, 
				originalEvent.shiftKey, originalEvent.buttonDown);
				
			this.linkFactory = new ClassFactory(linkClass);
		}

		public function getLinkFactory():IFactory
		{
			return linkFactory;
		}
	}
}