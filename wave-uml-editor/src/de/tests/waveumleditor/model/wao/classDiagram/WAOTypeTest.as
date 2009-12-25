package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.wao.classDiagram.WAOType;
	
	import flexunit.framework.TestCase;
	
	public class WAOTypeTest extends TestCase
	{
		public function testGetEncodableObject():void
		{
			var type:MType = MType.STRING;
			
			var obj:Object = WAOType.getEncodableObject(type);
			
			assertEquals(type.getName(), obj[WAOType.NAME]);
		}

		public function testGetFromDecodedObject():void
		{
			var obj:Object = new Object();
			obj[WAOType.NAME] = "String";
			
			var type:MType = WAOType.getFromDecodedObject(obj);
			
			assertEquals(obj[WAOType.NAME], type.getName());
		}
	}
}