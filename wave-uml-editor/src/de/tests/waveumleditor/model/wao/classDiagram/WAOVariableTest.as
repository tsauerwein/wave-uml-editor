package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOType;
	import de.waveumleditor.model.wao.classDiagram.WAOVariable;
	
	import flexunit.framework.TestCase;
	
	public class WAOVariableTest extends TestCase
	{
		public function testGetEncodableObject():void
		{
			var variable:Variable = new Variable("a", Type.STRING, "leer");
			
			var obj:Object = WAOVariable.getEncodableObject(variable);
			
			assertEquals(variable.getName(), obj[WAOVariable.NAME]);
			assertEquals(variable.getDefaultValue(), obj[WAOVariable.DEFAULT]);
			
			assertNotNull(obj[WAOVariable.TYPE]);
			assertEquals(variable.getType().getName(), obj[WAOVariable.TYPE][WAOType.NAME]);
		}

	}
}