package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	import flash.utils.Dictionary;
	
	
	public class WAODiagram
	{
		public static function getFromState(state:WaveState):ClassDiagram
		{
			var diagram:ClassDiagram = new ClassDiagram();
			
			var nodeParsers:Dictionary = new Dictionary();
			var linkParsers:Dictionary = new Dictionary();

			scanKeys(state, nodeParsers, linkParsers);
			processNodes(state, nodeParsers, diagram);
			processLinks(state, linkParsers, diagram);
			
			return diagram;
		}
		
		private static function scanKeys(state:WaveState, nodeParsers:Dictionary, linkParsers:Dictionary):void
		{
			var keys:Array = state.getKeys();
			
			for (var i:int = 0; i < keys.length; i++)
			{
				var key:String = keys[i];
				var parentKey:String = ModelFascade.getParentIdentifier(key);
				
				if (ModelFascade.isNodeKey(parentKey))
				{
					addNodeParser(nodeParsers, parentKey, key);
				}
				else if (ModelFascade.isLinkKey(parentKey))
				{
					addLinkParser(linkParsers, parentKey, key);
				}
			}			
		}
		
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
			linkParser.addKey(stateKey);
		}
		
		private static function processNodes(state:WaveState, nodeParsers:Dictionary, diagram:ClassDiagram):void
		{
			for (var key:Object in nodeParsers)
			{
				var nodeParser:WAONodeParser = nodeParsers[key];
				
				var node:ClassDiagramNode = nodeParser.getNode(state);
				
				if (node != null)
				{
					diagram.addNode(node);
				}
			}
		}
		
		private static function processLinks(state:WaveState, linkParsers:Dictionary, diagram:ClassDiagram):void
		{
			for (var key:Object in linkParsers)
			{
				var linkParser:WAOLinkParser = linkParsers[key];
				
				var link:ClassDiagramLink = linkParser.getLink(state, diagram);
				
				if (link != null)
				{
					diagram.addLink(link);
				}
			}
		}
	}
}