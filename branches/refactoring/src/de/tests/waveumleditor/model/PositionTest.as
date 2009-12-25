package de.tests.waveumleditor.model
{
	import de.waveumleditor.model.Position;
	
	import flexunit.framework.TestCase;
	
	public class PositionTest extends TestCase
	{
		public function PositionTest()
		{
		}
		
		public function testToString():void
		{
			var pos:Position = new Position(1, 2);
			
			assertEquals("1:2", pos.toString());
		}
	}
}