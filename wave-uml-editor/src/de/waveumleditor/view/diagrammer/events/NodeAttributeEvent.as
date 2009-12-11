package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributes;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;

	public class NodeAttributeEvent
	{
		
		private var attribute:ClassAttribute;
		private var attributeWindow:EditAttributes;
		private var attributeId:Identifier;
		private var node:UMLClass;
		
		public function NodeAttributeEvent(
			node:UMLClass, 
			attribute:ClassAttribute,
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
		
		public function getClassNode():UMLClass
		{
			return node;
		}
		
		public function getAttribute():ClassAttribute
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