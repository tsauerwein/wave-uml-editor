package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	import flexunit.framework.TestCase;
	
	public class UMLClassTest extends TestCase
	{
		public function UMLClassTest()
		{
		}
		
		public function testToString():void
		{
			var umlclass:UMLClass = new UMLClass(new Identifier("1234567"), new Position(0,0), "TestClass");
			
			assertEquals("TestClass", umlclass.toString());
		}
	}
}