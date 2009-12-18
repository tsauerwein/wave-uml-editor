package de.tests.waveumleditor.model.wao.wave.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	import com.nextgenapp.wave.gadget.WaveState;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class WAONodeTest extends TestCase
	{
		public function testSetPosition():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave);
			
			var id:Identifier = new Identifier(ModelFascade.PREFIX_CLASS + "node");
			var pos:Position = new Position(1, 2);
			
			waoNode.setPosition(id, pos);
				
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(id.getId() + Delta.IDS_SEPERATOR + WAONode.POSITION), "{\"x\":1,\"y\":2}");
		}
		
		public function testCreateNode():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave);
			
			var id:Identifier = new Identifier(ModelFascade.PREFIX_CLASS + "node");
			var pos:Position = new Position(1, 2);
			var name:String = "Name";
			
			var node:ClassDiagramNode = new UMLClass(id, pos, name);
			
			waoNode.createNode(node);
			var newState:WaveState = wave.getState();
			
			assertEquals(newState.getStringValue(id.getId()), node.getType());
			assertEquals(newState.getStringValue(id.getId() + Delta.IDS_SEPERATOR + WAONode.POSITION), "{\"x\":1,\"y\":2}");
			assertEquals(newState.getStringValue(id.getId() + Delta.IDS_SEPERATOR + WAONode.NAME), node.getName());
		}
		
		public function testRenameNode():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave);
			
			var id:Identifier = new Identifier(ModelFascade.PREFIX_CLASS + "node");
			var pos:Position = new Position(1, 2);
			var name:String = "Name";
			
			var node:ClassDiagramNode = new UMLClass(id, pos, name);
			
			waoNode.createNode(node);
			
			var newName:String = "Neuer Name";
			node.setName(newName);
			
			waoNode.renameNode(node);
			
			var newState:WaveState = wave.getState();
			assertEquals(newState.getStringValue(id.getId() + Delta.IDS_SEPERATOR + WAONode.NAME), newName);
			
		}
	}
}