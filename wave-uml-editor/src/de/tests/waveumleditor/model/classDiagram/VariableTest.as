package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flexunit.framework.TestCase;
	
	public class VariableTest extends TestCase
	{
		public function VariableTest()
		{
		}
		
		public function testToString():void
		{
			var variable:Variable = new Variable("variable", Type.DOUBLE);
			
			assertEquals("variable:double", variable.toString());
			
			variable= new Variable("variable", Type.DOUBLE, "0.0");
			assertEquals("variable:double=0.0", variable.toString());
		}
	}
}