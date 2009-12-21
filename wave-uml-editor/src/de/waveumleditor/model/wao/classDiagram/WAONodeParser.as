package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
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
		
		public function getNode(state:WaveState):ClassDiagramNode
		{
			var node:ClassDiagramNode = WAONode.getFromState(nodeId, state);
			
			if (node == null)
			{
				return null;
			}
			
			if (node is UMLClass)
			{
				var umlClass:UMLClass = node as UMLClass;
				
				addAtttributes(umlClass, state);
				addConstructors(umlClass, state);
				addMethods(umlClass, state);
			}
			else if (node is Interface)
			{
				// todo
			}
			
			return node;
		}
		
		private function addAtttributes(umlClass:UMLClass, state:WaveState):void
		{
			for (var i:int = 0; i < attributeKeys.length; i++)
			{
				var key:String = attributeKeys.getItemAt(i) as String;
				
				var attribute:ClassAttribute = 
					WAOClassAttribute.getFromState(key, state.getStringValue(key));
					
				umlClass.addAttribute(attribute);
			}
		}
		
		private function addConstructors(umlClass:UMLClass, state:WaveState):void
		{
			for (var i:int = 0; i < constructorKeys.length; i++)
			{
				var key:String = constructorKeys.getItemAt(i) as String;
				
				var constructor:ClassConstructorMethod = 
					WAOClassConstructor.getFromState(key, state.getStringValue(key));
					
				umlClass.addConstructor(constructor);
			}
		}
		
		private function addMethods(umlClass:UMLClass, state:WaveState):void
		{
			for (var i:int = 0; i < methodKeys.length; i++)
			{
				var key:String = methodKeys.getItemAt(i) as String;
				
				var method:ClassMethod = 
					WAOClassMethod.getFromState(key, state.getStringValue(key));
					
				umlClass.addMethod(method);
			}
		}
	}
}