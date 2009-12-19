package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.classDiagram.maps.LinkMap;
	import de.waveumleditor.model.classDiagram.maps.NodeMap;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
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
		
		/**
		 * Removes a node from the diagram by its id.
		 * 
		 * @returns A list of links that were connected to this node.
		 */ 
		public function removeNodeById(id:Identifier):IList
		{
			return removeNode(getNode(id));
		}
		
		/**
		 * Removes a node from the diagram.
		 * 
		 * @returns A list of links that were connected to this node.
		 */ 
		public function removeNode(node:ClassDiagramNode):IList
		{
			this.nodes.removeValue(node.getIdentifier());
			return removeCorrespondingLinks(node);
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
		
		/**
		 * Removes all links from the diagram that are connected 
		 * with the passed-in node.
		 * 
		 * @returns A list of links that were removed.
		 */ 
		private function removeCorrespondingLinks(node:ClassDiagramNode):IList
		{
			var linkList:ArrayList = getLinks();
			
			var removedLinks:ArrayList = new ArrayList();
			for (var i:int = 0; i < linkList.length; i++)
			{
				var link:ClassDiagramLink = linkList.getItemAt(i) as ClassDiagramLink;
				
				if (link.getLinkFrom() == node || link.getLinkTo() == node) 
				{
					removedLinks.addItem(link);	
					removeLink(link);		
				}	
			}
			
			return removedLinks;
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
				var method:ClassMethod = newMethod.clone(methodId) as ClassMethod;
				
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
		
		// Constructors
		public function addConstructor(classId:Identifier, 
			newConstructor:ClassConstructorMethod, 
			constructorId:Identifier):void
		{
				var constructor:ClassConstructorMethod = newConstructor.clone(constructorId);
				
				var umlClass:UMLClass = getNode(classId) as UMLClass;
				
				umlClass.addConstructor(constructor);
		}
		
		public function editConstructor(classId:Identifier, newConstructor:ClassConstructorMethod):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			var constructor:ClassConstructorMethod = umlClass.getConstructor(newConstructor.getIdentifier());
			constructor.updateFrom(newConstructor);
		}
		
		public function removeConstructor(classId:Identifier, constructorId:Identifier):void
		{
			var umlClass:UMLClass = getNode(classId) as UMLClass;
			
			umlClass.removeConstructorById(constructorId);
		}
		
		public function editLink(newLink:LinkDependency):void
		{
			var link:LinkDependency = getLink(newLink.getIdentifier()) as LinkDependency;
			
			link.updateFrom(newLink);
		}
	}
}