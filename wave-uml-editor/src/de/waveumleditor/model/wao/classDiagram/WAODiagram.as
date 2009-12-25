package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	
	import flash.utils.Dictionary;
	
	
	public class WAODiagram
	{
		/**
		 * Restores a model diagram from the Wave state.
		 * 
		 * @param state The Wave state
		 * @return 
		 */		
		public static function getFromState(state:WaveState):MClassDiagram
		{
			var diagram:MClassDiagram = new MClassDiagram();
			
			var nodeParsers:Dictionary = new Dictionary();
			var linkParsers:Dictionary = new Dictionary();

			scanKeys(state, nodeParsers, linkParsers);
			processNodes(state, nodeParsers, diagram);
			processLinks(state, linkParsers, diagram);
			
			return diagram;
		}
		
		/**
		 * Loops through all state keys and groups the keys
		 * into NodeParser/LinkParser objects for every node/link.
		 * 
		 * For example:
		 * 
		 * Wave state:
		 * N-001=C
		 * N-001_p={..}
		 * N-001_M-001={..}
		 * N-002=C
		 * N-002_p={..}
		 * 
		 * -->
		 * 
		 * NodeParser 1:
		 * N-001
		 * N-001_p
		 * N-001_M-001
		 * 
		 * Node Parser 2:
		 * N-002
		 * N-002_p
		 */
		private static function scanKeys(state:WaveState, nodeParsers:Dictionary, linkParsers:Dictionary):void
		{
			var keys:Array = state.getKeys();
			
			for (var i:int = 0; i < keys.length; i++)
			{
				var key:String = keys[i];
				var parentKey:String = WAOKeyGenerator.getParentIdentifier(key);
				
				if (WAOKeyGenerator.isNodeKey(parentKey))
				{
					addNodeParser(nodeParsers, parentKey, key);
				}
				else if (WAOKeyGenerator.isLinkKey(parentKey))
				{
					addLinkParser(linkParsers, parentKey, key);
				}
			}			
		}
		
		/**
		 * Stores a state key inside the NodeParser list. If there is no
		 * NodeParser for the node the key belongs to, then a new NodeParser
		 * is created.
		 * 
		 * @param nodeParsers The list of NodeParser
		 * @param nodeKey The node to which the state key belongs (e.g. "N-001")
		 * @param stateKey The key inside the state (e.g. "N-001" or "N-001_M-001")
		 */ 
		private static function addNodeParser(nodeParsers:Dictionary, nodeKey:String, stateKey:String):void
		{
			var nodeParser:WAONodeParser = nodeParsers[nodeKey] as WAONodeParser; 
			if (nodeParser == null)
			{
				nodeParser = new WAONodeParser(nodeKey);
					
				nodeParsers[nodeKey] = nodeParser;
			}
			nodeParser.addKey(stateKey);
		}
		
		private static function addLinkParser(linkParsers:Dictionary, linkKey:String, stateKey:String):void
		{
			var linkParser:WAOLinkParser = linkParsers[linkKey] as WAOLinkParser; 
			if (linkParser == null)
			{
				linkParser = new WAOLinkParser(linkKey);
					
				linkParsers[linkKey] = linkParser;
			}
		}
		
		/**
		 * Creates a node for every NodeParser inside the 
		 * NodeParser list and adds this node to the diagram.
		 */ 
		private static function processNodes(state:WaveState, nodeParsers:Dictionary, diagram:MClassDiagram):void
		{
			for (var key:Object in nodeParsers)
			{
				var nodeParser:WAONodeParser = nodeParsers[key];
				
				var node:MClassDiagramNode = nodeParser.getNode(state);
				
				if (node != null)
				{
					diagram.addNode(node);
				}
			}
		}
		
		/**
		 * Creates a link for every LinkParser inside the 
		 * LinkParser list and adds this link to the diagram.
		 */
		private static function processLinks(state:WaveState, linkParsers:Dictionary, diagram:MClassDiagram):void
		{
			for (var key:Object in linkParsers)
			{
				var linkParser:WAOLinkParser = linkParsers[key];
				
				var link:MClassLink = linkParser.getLink(state, diagram);
				
				if (link != null)
				{
					diagram.addLink(link);
				}
			}
		}
	}
}