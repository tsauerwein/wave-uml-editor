package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributes;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;

	public class NodeAttributeEvent
	{
		
		private var attribute:MClassAttribute;
		private var attributeWindow:EditAttributes;
		private var attributeId:Identifier;
		private var node:MClassNode;
		
		public function NodeAttributeEvent(
			node:MClassNode, 
			attribute:MClassAttribute,
			attributeWindow:EditAttributes,
			attributeId:Identifier = null)
		{
			this.attribute = attribute;
			this.attributeWindow = attributeWindow;
			this.node = node;
			
			if (attributeId == null && attribute != null)
			{
				this.attributeId = attribute.getIdentifier();
			} 
			else 
			{
				this.attributeId = attributeId;
			}
		}
		
		public function getClassNode():MClassNode
		{
			return node;
		}
		
		public function getAttribute():MClassAttribute
		{
			return attribute;
		}
		
		public function getAttributeWindow():EditAttributes
		{
			return attributeWindow;
		}
		
		public function getAttributeId():Identifier
		{
			return attributeId;
		}
		
	}
}