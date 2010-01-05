package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MInterface;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	/**
	 * This class is responsible for restoring a node from
	 * the wave state. It keeps lists of all state keys that
	 * belong to a node.
	 *
	 * @see de.waveumleditor.model.wao.classDiagram.WAODiagram
	 */  
	public class WAONodeParser
	{
		private var nodeId:String;
		
		private var attributeKeys:IList = new ArrayList();
		private var constructorKeys:IList = new ArrayList();
		private var methodKeys:IList = new ArrayList();
		private var nodeKeys:IList = new ArrayList();
		
		public function WAONodeParser(nodeId:String)
		{
			this.nodeId = nodeId;
		}

		public function addKey(key:String):void
		{
			var elementKey:String = WAOKeyGenerator.getNodeElementIdentifier(key);
			
			if (WAOKeyGenerator.isAttributeKey(elementKey))
			{
				attributeKeys.addItem(key);
			}
			else if (WAOKeyGenerator.isConstructorKey(elementKey))
			{
				constructorKeys.addItem(key);
			}
			else if (WAOKeyGenerator.isMethodKey(elementKey))
			{
				methodKeys.addItem(key);
			}
			else
			{
				nodeKeys.addItem(key);
			}
		}
		
		public function getNode(state:WaveState):MClassDiagramNode
		{
			var node:MClassDiagramNode = WAONode.getFromState(nodeId, state);
			
			if (node == null)
			{
				return null;
			}
			
			if (node is MClassNode)
			{
				var umlClass:MClassNode = node as MClassNode;
				
				addAtttributes(umlClass, state);
				addConstructors(umlClass, state);
				addMethods(umlClass, state, false);
			}
			else if (node is MInterface)
			{
				addMethods(node, state, true);
			}
			
			return node;
		}
		
		private function addAtttributes(umlClass:MClassNode, state:WaveState):void
		{
			for (var i:int = 0; i < attributeKeys.length; i++)
			{
				var key:String = attributeKeys.getItemAt(i) as String;
				
				var attribute:MClassAttribute = 
					WAOClassAttribute.getFromState(key, state.getStringValue(key));
					
				if (attribute != null)
				{
					umlClass.addAttribute(attribute);
				}
			}
		}
		
		private function addConstructors(umlClass:MClassNode, state:WaveState):void
		{
			for (var i:int = 0; i < constructorKeys.length; i++)
			{
				var key:String = constructorKeys.getItemAt(i) as String;
				
				var constructor:MClassConstructorMethod = 
					WAOClassConstructor.getFromState(key, state.getStringValue(key));
					
				if (constructor != null)
				{
					umlClass.addConstructor(constructor);
				}
			}
		}
		
		private function addMethods(node:MClassDiagramNode, state:WaveState, isInterface:Boolean):void
		{
			for (var i:int = 0; i < methodKeys.length; i++)
			{
				var key:String = methodKeys.getItemAt(i) as String;
				
				var method:MClassMethod = 
					WAOClassMethod.getFromState(key, state.getStringValue(key), isInterface);
					
				if (method != null)
				{
					node.addMethod(method);
				}
			}
		}
	}
}