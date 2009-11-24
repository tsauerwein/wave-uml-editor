package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.EVisibility;
	
	import flexunit.framework.TestCase;
	
	public class EVisibilityTest extends TestCase
	{
		public function EVisibilityTest()
		{
		}
		
		public function testToString():void
		{
			var visibility:EVisibility = EVisibility.PUBLIC;
			
			assertEquals("+", visibility.toString());
		}

	}
}