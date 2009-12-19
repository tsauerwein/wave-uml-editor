package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.wao.classDiagram.WAOType;
	
	import flexunit.framework.TestCase;
	
	public class WAOTypeTest extends TestCase
	{
		public function testGetEncodableObject():void
		{
			var type:Type = Type.STRING;
			
			var obj:Object = WAOType.getEncodableObject(type);
			
			assertEquals(type.getName(), obj[WAOType.NAME]);
		}

	}
}