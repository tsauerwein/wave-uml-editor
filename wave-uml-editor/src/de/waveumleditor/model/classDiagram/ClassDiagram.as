package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.classDiagram.maps.LinkMap;
	import de.waveumleditor.model.classDiagram.maps.NodeMap;
	
	import mx.collections.ArrayList;
	
	/**
	 * Holds a list of all nodes and links that belong 
	 * to a digram
	 */ 
	public class ClassDiagram
	{

		private var nodes:NodeMap;
		private var links:LinkMap;
		
		public function ClassDiagram()
		{
			this.nodes = new NodeMap();
			this.links = new LinkMap();
		}

		public function addNode(node:ClassDiagramNode):void
		{
			this.nodes.setValue(node);
		}
		
		public function removeNodeById(id:Identifier):void
		{
			removeNode(getNode(id));
		}
		
		public function removeNode(node:ClassDiagramNode):void
		{
			this.nodes.removeValue(node.getIdentifier());
			removeCorrespondingLinks(node);
		}
		
		public function getNode(id:Identifier):ClassDiagramNode
		{
			return this.nodes.getValue(id);
		}
		
		public function getNodes():ArrayList
		{
			return this.nodes.getAsList();
		}
		
		public function addLink(link:ClassDiagramLink):void
		{
			this.links.setValue(link);
		}
		
		public function removeLink(link:ClassDiagramLink):void
		{
			removeLinkById(link.getIdentifier());
		}
		
		public function removeLinkById(id:Identifier):void
		{
			this.links.removeValue(id);
		}
		
		public function getLink(id:Identifier):ClassDiagramLink
		{
			return this.links.getValue(id);
		}
		
		public function getLinks():ArrayList
		{
			return this.links.getAsList();
		}
		
		private function removeCorrespondingLinks(node:ClassDiagramNode):void
		{
			var linkList:ArrayList = getLinks();
			
			for (var i:int = 0; i < linkList.length; i++)
			{
				var link:ClassDiagramLink = linkList.getItemAt(i) as ClassDiagramLink;
				
				if (link.getLinkFrom() == node || link.getLinkTo() == node) 
				{
						removeLink(link);		
				}	
			}
		}
		
		public function addAttribute(classId:Identifier, newAttribute:ClassAttribute, 
			attributeId:Identifier):void
		{
			// build a copy of the attribute
			var attribute:ClassAttribute = newAttribute.clone(attributeId);
				
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			umlClass.addAttribute(attribute);
		}
		
		public function editAttribute(classId:Identifier, newAttribute:ClassAttribute):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			var attribute:ClassAttribute = umlClass.getAttribute(newAttribute.getIdentifier());
			attribute.updateFrom(newAttribute);
		}
		
		public function removeAttribute(classId:Identifier, attributeId:Identifier):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			umlClass.removeAttributeById(attributeId);
		}
		
		//Methods
		public function addMethod(classId:Identifier, newMethod:ClassMethod, methodId:Identifier):void
		{
				var method:ClassMethod = newMethod.clone(methodId);
				
				var umlClass:UMLClass = getNode(classId) as UMLClass;
				
				umlClass.addMethod(method);
		}
		
		public function editMethod(classId:Identifier, newMethod:ClassMethod):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			var method:ClassMethod = umlClass.getMethod(newMethod.getIdentifier());
			method.updateFrom(newMethod);
		}
		
		public function removeMethod(classId:Identifier, methodId:Identifier):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			umlClass.removeMethodById(methodId);
		}
		
		public function editLink(newLink:LinkDependency):void
		{
			var link:LinkDependency = getLink(newLink.getIdentifier()) as LinkDependency;
			
			link.updateFrom(newLink);
		}
	}
}