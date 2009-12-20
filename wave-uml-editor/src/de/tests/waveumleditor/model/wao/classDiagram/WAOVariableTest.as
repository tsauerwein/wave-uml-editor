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

		public function testGetFromDecodedObject():void
		{
			var obj:Object = new Object();
			obj[WAOVariable.NAME] = "a";
			obj[WAOVariable.DEFAULT] = "leer";
			obj[WAOVariable.TYPE] = new Object();
			obj[WAOVariable.TYPE][WAOType.NAME] = "String";
			
			var variable:Variable = WAOVariable.getFromDecodedObject(obj);
			
			assertEquals(obj[WAOVariable.NAME], variable.getName());
			assertEquals(obj[WAOVariable.DEFAULT], variable.getDefaultValue());
			assertEquals(obj[WAOVariable.TYPE][WAOType.NAME], variable.getType().getName());
		}
	}
}