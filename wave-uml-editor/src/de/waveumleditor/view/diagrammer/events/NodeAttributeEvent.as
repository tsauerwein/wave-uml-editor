package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditAttributesWindow;

	public class NodeAttributeEvent
	{
		
		private var attribute:ClassAttribute;
		private var attributeWindow:EditAttributesWindow;
		private var attributeId:Identifier;
		private var node:UMLClass;
		
		public function NodeAttributeEvent(
			node:UMLClass, 
			attribute:ClassAttribute,
			attributeWindow:EditAttributesWindow,
			attributeId:Identifier = null)
		{
			this.attribute = attribute;
			this.attributeWindow = attributeWindow;
			this.node = node;
			
			if (attributeId == null && attribute != null)
			{
				attributeId = attribute.getIdentifier();
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