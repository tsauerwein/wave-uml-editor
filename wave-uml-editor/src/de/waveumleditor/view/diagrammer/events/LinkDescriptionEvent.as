package de.waveumleditor.view.diagrammer.events
{
	import flash.events.Event;

	public class LinkDescriptionEvent extends Event
	{
		public static const DESCRIBE_LINK:String = "describeLink";
		public var valueArray:Array;

		
		public function LinkDescriptionEvent(value:Array) 
		{
			super(DESCRIBE_LINK);
			
			this.valueArray = new Array(6);
			
			for (var i:int = 0; i < value.length; i++)
			{
				if(i < 6)
				{
			    	this.valueArray[i] = value[i];
			    	trace("for" + valueArray[i]);
			 	}
			 	else
			 	{
			 		break;
			 	}
			}
			trace("LinkDescriptionEvent");
		}
	}
}