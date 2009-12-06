package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;

	public class NodeAttributeEvent extends NodeEvent
	{
		public static var EVENT_ADD_ATTRIBUTE:String = "eventEditNodeAttributesAdd";
		
		private var attribute:ClassAttribute;
		private var attributeWindow:EditAttributesWindow;
		private var attributeId:Identifier;
		
		public function NodeAttributeEvent(
			type:String, 
			node:ClassNode, 
			attribute:ClassAttribute,
			attributeWindow:EditAttributesWindow,
			attributeId:Identifier = null)
		{
			super(type, node);
			this.attribute = attribute;
			this.attributeWindow = attributeWindow;
			
			if (attributeId == null && attribute != null)
			{
				attributeId = attribute.getIdentifier();
			}
		}
		
		public function getClassNode():ClassNode
		{
			return getNode() as ClassNode;
		}
		
		public function getAttribute():ClassAttribute
		{
			return attribute;
		}
		
		public function getAttributeWindow():EditAttributesWindow
		{
			return attributeWindow;
		}
		
		public function getAttributeId():Identifier
		{
			return attributeId;
		}
		
	}
}