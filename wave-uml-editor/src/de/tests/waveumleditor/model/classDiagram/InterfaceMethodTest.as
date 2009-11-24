package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.InterfaceMethod;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	import flexunit.framework.TestCase;
	
	public class InterfaceMethodTest extends TestCase
	{
		public function InterfaceMethodTest()
		{
		}
		
		public function testToString():void
		{
			var umlclass:UMLClass = new UMLClass(new Position(0,0), "DasIstKlasse");
			var ifaceMethod:InterfaceMethod = new InterfaceMethod("method", Type.INT);
			ifaceMethod.setUMLClass(umlclass);
			
			assertEquals("+ method():int", ifaceMethod.toString());
		}

	}
}