package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.Interface;
	
	import flexunit.framework.TestCase;
	
	public class InterfaceTest extends TestCase
	{
		public function InterfaceTest()
		{
		}
		
		public function testToString():void
		{
			var iface:Interface = new Interface(new Identifier("1234567"), new Position(0,0), "ITest");
			
			assertEquals("ITest", iface.toString());
		}
	}
}