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
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	import de.waveumleditor.model.wao.wave.Delta;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	import mx.collections.IList;

	public class ModelFascade
	{
		private var diagram:ClassDiagram;
		
		private var wave:Wave;
		
		private var waoNode:WAONode;
		private var waoLink:WAOLink;
		
		public static const SEPERATOR:String = "-";
		
		public static const PREFIX_ATTRIBUTE:String = "A" + SEPERATOR;
		public static const PREFIX_METHOD:String = "M" + SEPERATOR;
		public static const PREFIX_CONSTRUCTOR:String = "CO" + SEPERATOR;
		public static const PREFIX_NODE:String = "N" + SEPERATOR;
		public static const PREFIX_LINK:String = "L" + SEPERATOR;
		
		public static const DEFAULT_ATTRIBUTE_IDENTIFIER:Identifier = new Identifier(PREFIX_ATTRIBUTE + "default_attr");
		public static const DEFAULT_METHOD_IDENTIFIER:Identifier = new Identifier(PREFIX_METHOD + "default_meth");
		public static const DEFAULT_CONSTRUCTOR_IDENTIFIER:Identifier = new Identifier(PREFIX_CONSTRUCTOR + "default_constr");
		
		public function ModelFascade(diagram:ClassDiagram, wave:Wave)
		{
			this.diagram = diagram;
			
			this.wave = wave;
			this.waoLink = new WAOLink(wave);
			this.waoNode = new WAONode(wave, waoLink);
		}
		
		public function addNode(node:BaseClassDiagramNode):void
		{	
			var id:Identifier = generateNodeIdentifier();
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
			var id:Identifier = generateLinkIdentifier();
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
			
			if (attribute.getIdentifier().getId() == ModelFascade.DEFAULT_ATTRIBUTE_IDENTIFIER.getId())
			{
				id = generateAttributeIdentifier();
				diagram.addAttribute(nodeId, attribute, generateAttributeIdentifier());
			}
			else
			{
				id = attribute.getIdentifier();
				diagram.editAttribute(nodeId, attribute);
			}
			
			var node:UMLClass = diagram.getNode(nodeId) as UMLClass;
			var attribute:ClassAttribute = node.getAttribute(id);
			
			waoNode.updateClassAttribute(nodeId, attribute);
		}
		
		public function removeNodeAttribute(nodeId:Identifier, attributeId:Identifier):void
		{
			diagram.removeAttribute(nodeId, attributeId);
			waoNode.removeClassAttribute(nodeId, attributeId);
		}
		
		// Methods
		
		public function addNodeMethod(nodeId:Identifier, method:ClassConstructorMethod):void
		{
			var id:Identifier = generateMethodIdentifier();
			if(method is ClassMethod)
			{
				diagram.addMethod(nodeId, method as ClassMethod, generateMethodIdentifier());
			}
			if(method is ClassConstructorMethod)
			{
				diagram.addConstructor(nodeId, method, generateMethodIdentifier());
			}
			
		}
		
		public function removeNodeMethod(nodeId:Identifier, methodId:Identifier):void
		{
			diagram.removeMethod(nodeId, methodId);
		}
		
		public function editNodeMethod(nodeId:Identifier, method:ClassConstructorMethod):void
		{
			if (method.getIdentifier().getId() == ModelFascade.DEFAULT_CONSTRUCTOR_IDENTIFIER.getId() ||
				method.getIdentifier().getId() == ModelFascade.DEFAULT_METHOD_IDENTIFIER.getId())
			{
				var id:Identifier;
				
				if(method is ClassMethod)
				{
					id = generateMethodIdentifier();
					diagram.addMethod(nodeId, method as ClassMethod, id);	
				}
				else
				{
					id = generateConstructorIdentifier();
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
			if (constructor.getIdentifier().getId() == ModelFascade.DEFAULT_ATTRIBUTE_IDENTIFIER.getId())
			{
				var id:Identifier = generateConstructorIdentifier();
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
		
		// Identifier
		public function generateNodeIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			// eigene ID: wave.getViewer().getId()
			return new Identifier(PREFIX_NODE + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateLinkIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_LINK + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateAttributeIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_ATTRIBUTE + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateMethodIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_METHOD + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateConstructorIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_CONSTRUCTOR + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public static function isConstructor(id:Identifier):Boolean
		{
			return id.getId().substr(0, 3) == PREFIX_CONSTRUCTOR;
		}
		
		public static function isMethod(id:Identifier):Boolean
		{
			return id.getId().substr(0, 2) == PREFIX_METHOD;
		}
		
		public static function isAttribute(id:Identifier):Boolean
		{
			return id.getId().substr(0, 2) == PREFIX_ATTRIBUTE;
		}
		
		public static function isConstructorKey(key:String):Boolean
		{
			return key.substr(0, 3) == PREFIX_CONSTRUCTOR;
		}
		
		public static function isMethodKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_METHOD;
		}
		
		public static function isAttributeKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_ATTRIBUTE;
		}
		
		public static function isNodeKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_NODE;
		}
		
		public static function isLinkKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_LINK;
		}
		
		/**
		 * Returns the identifier for a class element (attribute, method, constructor)
		 * from the wave state key.
		 * 
		 * For example:
		 * C-001_A-002 --> A-002
		 *
		 *  @param key wave state key
		 *  @return The 2nd half of the key
		 */  
		public static function getNodeElementIdentifier(key:String):String
		{
			var seperatorPos:int = key.indexOf(Delta.IDS_SEPERATOR);
			
			return key.substring(seperatorPos + 1, key.length);
		}
		
		/**
		 * Returns the identifier of the parent element (node or link)
		 * from the wave state key.
		 * 
		 * For example:
		 * C-001_A-002 --> C-001
		 * C-001 --> C-001
		 * 
		 *  @param key wave state key
		 *  @return The 1st half of the key
		 */  
		public static function getParentIdentifier(key:String):String
		{
			var seperatorPos:int = key.indexOf(Delta.IDS_SEPERATOR);
			
			if (seperatorPos < 0)
			{
				return key;
			}
			else
			{
				return key.substring(0, seperatorPos); 
			}
		}
	}
}