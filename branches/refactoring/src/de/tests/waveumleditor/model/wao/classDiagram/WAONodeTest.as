package de.tests.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayList;

	public class WAONodeTest extends TestCase
	{
		public function testSetPosition():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave, null);
			
			var id:Identifier = new Identifier(WAOKeyGenerator.PREFIX_NODE + "node");
			var pos:Position = new Position(1, 2);
			
			waoNode.setPosition(id, pos);
				
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.POSITION), "{\"x\":1,\"y\":2}");
		}
		
		public function testCreateNode():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave, null);
			
			var id:Identifier = new Identifier(WAOKeyGenerator.PREFIX_NODE + "node");
			var pos:Position = new Position(1, 2);
			var name:String = "Name";
			
			var node:MClassDiagramNode = new MClassNode(id, pos, name);
			
			waoNode.createNode(node);
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(id.getId()), node.getType());
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.POSITION), "{\"x\":1,\"y\":2}");
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.NAME), node.getName());
		}
		
		public function testRenameNode():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave, null);
			
			var id:Identifier = new Identifier(WAOKeyGenerator.PREFIX_NODE + "node");
			var pos:Position = new Position(1, 2);
			var name:String = "Name";
			
			var node:MClassDiagramNode = new MClassNode(id, pos, name);
			
			waoNode.createNode(node);
			
			var newName:String = "Neuer Name";
			node.setName(newName);
			
			waoNode.renameNode(node);
			
			var newState:WaveState = wave.getState();
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.NAME), newName);
			
		}
		
		public function testRemoveNode():void
		{
			var wave:Wave = new WaveSimulator();
			var waoLink:WAOLink = new WAOLink(wave);
			var waoNode:WAONode = new WAONode(wave, waoLink);
			
			var id:Identifier = new Identifier(WAOKeyGenerator.PREFIX_NODE + "node");
			var pos:Position = new Position(1, 2);
			var name:String = "Name";
			
			var node:MClassNode = new MClassNode(id, pos, name);
			var attribute:MClassAttribute = new MClassAttribute(new Identifier("attrId"), new MVariable("a", MType.INT), EVisibility.PUBLIC);
			node.addAttribute(attribute);
			
			waoNode.createNode(node);
			waoNode.updateClassAttribute(id, attribute);
			waoNode.removeNode(node, new ArrayList());
			
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(id.getId()), null);
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.POSITION), null);
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + WAONode.NAME), null);
			assertEquals(newState.getStringValue(id.getId() + WAOKeyGenerator.IDS_SEPERATOR + "attrId"), null);
		}
	}
}