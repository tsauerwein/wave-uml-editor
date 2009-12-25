package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flexunit.framework.TestCase;
	
	public class MVariableTest extends TestCase
	{
		public function MVariableTest()
		{
		}
		
		public function testToString():void
		{
			var variable:MVariable = new MVariable("variable", MType.DOUBLE);
			
			assertEquals("variable:double", variable.toString());
			
			variable= new MVariable("variable", MType.DOUBLE, "0.0");
			assertEquals("variable:double=0.0", variable.toString());
		}
	}
}