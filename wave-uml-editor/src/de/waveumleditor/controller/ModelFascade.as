package de.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.Wave;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import mx.collections.IList;

	public class ModelFascade
	{
		private var diagram:ClassDiagram;
		
		private var wave:Wave;
		
		private var waoNode:WAONode;
		private var waoLink:WAOLink;
		private var waoKey:WAOKeyGenerator;
		
	
		public function ModelFascade(diagram:ClassDiagram, wave:Wave)
		{
			this.diagram = diagram;
			
			this.wave = wave;
			this.waoLink = new WAOLink(wave);
			this.waoNode = new WAONode(wave, waoLink);
			this.waoKey = new WAOKeyGenerator();
		}
		
		public function addNode(node:BaseClassDiagramNode):void
		{	
			var id:Identifier = waoKey.generateNodeIdentifier();
			node.setIdentifier(id);
			
			var modelNode:ClassDiagramNode = ModelFactory.nodeFromView(node);
			this.diagram.addNode(modelNode);
			
			waoNode.createNode(modelNode);
			node.update(modelNode);
		}
		
		public function moveNode(node:BaseClassDiagramNode):void
		{
			var id:Identifier = node.getIdentifier();
			var nodeModel:ClassDiagramNode = diagram.getNode(id);
			
			if (nodeModel != null)
			{
				var newPosition:Position = new Position(node.x, node.y);
				
				nodeModel.setPosition(newPosition);
				waoNode.setPosition(id, newPosition);
			}
		}
		
		/**
		 * Removes a node from the diagram.
		 * 
		 * @return A list of links that were connected to this node.
		 */ 
		public function removeNode(node:BaseClassDiagramNode):void
		{
			var nodeModel:ClassDiagramNode = diagram.getNode(node.getIdentifier());
			
			var removedLinks:IList = diagram.removeNode(nodeModel);
			waoNode.removeNode(nodeModel, removedLinks);
		}
		
		public function renameNode(node:BaseClassDiagramNode):void
		{
			var modelNode:ClassDiagramNode = diagram.getNode(node.getIdentifier());
			modelNode.setName(node.nodeName);
			waoNode.renameNode(modelNode);
		}
		
		
		// Link 				
		public function addLink(link:ClassLink):void
		{
			var id:Identifier = waoKey.generateLinkIdentifier();
			link.setIdentifier(id);
			var fromNode:ClassDiagramNode = this.diagram.getNode((link.fromNode as BaseClassDiagramNode).getIdentifier());
			var toNode:ClassDiagramNode = this.diagram.getNode((link.toNode as BaseClassDiagramNode).getIdentifier());
			
			var modelLink:ClassDiagramLink = ModelFactory.linkFromView(link, fromNode, toNode);
			this.diagram.addLink(modelLink);
			waoLink.createLink(modelLink);
		}
		
		public function editLink(link:LinkDependency):void
		{
			diagram.editLink(link);
			waoLink.updateLink(link);
		}
		
		public function removeLink(link:ClassLink):void
		{
			var modelLink:ClassDiagramLink = diagram.getLink(link.getIdentifier());
			diagram.removeLinkById(link.getIdentifier());
			waoLink.removeLink(modelLink);
		}
		
		public function editNodeAttribute(nodeId:Identifier, attribute:ClassAttribute):void
		{
			var id:Identifier = null;
			
			if (attribute.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER.getId())
			{
				id = waoKey.generateAttributeIdentifier();
				diagram.addAttribute(nodeId, attribute, waoKey.generateAttributeIdentifier());
			}
			else
			{
				id = attribute.getIdentifier();
				diagram.editAttribute(nodeId, attribute);
			}
			
			var node:UMLClass = diagram.getNode(nodeId) as UMLClass;
			var attribute:ClassAttribute = node.getAttribute(id);
		
			//todo	
			//waoNode.updateClassAttribute(nodeId, attribute);
		}
		
		public function removeNodeAttribute(nodeId:Identifier, attributeId:Identifier):void
		{
			diagram.removeAttribute(nodeId, attributeId);
			waoNode.removeClassAttribute(nodeId, attributeId);
		}
		
		// Methods
		
		public function addNodeMethod(nodeId:Identifier, method:ClassConstructorMethod):void
		{
			var id:Identifier = waoKey.generateMethodIdentifier();
			if(method is ClassMethod)
			{
				diagram.addMethod(nodeId, method as ClassMethod, waoKey.generateMethodIdentifier());
			}
			if(method is ClassConstructorMethod)
			{
				diagram.addConstructor(nodeId, method, waoKey.generateMethodIdentifier());
			}
			
		}
		
		public function removeNodeMethod(nodeId:Identifier, methodId:Identifier):void
		{
			diagram.removeMethod(nodeId, methodId);
		}
		
		public function editNodeMethod(nodeId:Identifier, method:ClassConstructorMethod):void
		{
			if (method.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_CONSTRUCTOR_IDENTIFIER.getId() ||
				method.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_METHOD_IDENTIFIER.getId())
			{
				var id:Identifier;
				
				if(method is ClassMethod)
				{
					id = waoKey.generateMethodIdentifier();
					diagram.addMethod(nodeId, method as ClassMethod, id);	
				}
				else
				{
					id = waoKey.generateConstructorIdentifier();
					diagram.addConstructor(nodeId, method, id);
				}
				
			}
			else
			{
				if(method is ClassMethod)
				{
					diagram.editMethod(nodeId, method as ClassMethod);
				}
				else
				{
					diagram.editConstructor(nodeId, method);
				}
				
			}
		}
		
		// Constructors
		
		public function editClassConstructor(classId:Identifier, constructor:ClassConstructorMethod):void
		{
			if (constructor.getIdentifier().getId() == WAOKeyGenerator.DEFAULT_ATTRIBUTE_IDENTIFIER.getId())
			{
				var id:Identifier = waoKey.generateConstructorIdentifier();
				diagram.addConstructor(classId, constructor, id);
			}
			else
			{
				diagram.editConstructor(classId, constructor);
			}
		}
		
		public function removeClassConstructor(classId:Identifier, constructorId:Identifier):void
		{
			diagram.removeConstructor(classId, constructorId);
		}
		
	}
}