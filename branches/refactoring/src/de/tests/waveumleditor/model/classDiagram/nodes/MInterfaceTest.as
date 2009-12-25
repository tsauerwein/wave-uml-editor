package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MInterface;
	
	import flexunit.framework.TestCase;
	
	public class MInterfaceTest extends TestCase
	{
		public function MInterfaceTest()
		{
		}
		
		public function testToString():void
		{
			var iface:MInterface = new MInterface(new Identifier("1234567"), new Position(0,0), "ITest");
			
			assertEquals("ITest", iface.toString());
		}
	}
}