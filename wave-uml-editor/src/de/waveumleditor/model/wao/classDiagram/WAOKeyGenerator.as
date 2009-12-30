package de.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	
	import de.waveumleditor.model.Identifier;
	
	public class WAOKeyGenerator
	{
		private var wave:Wave;
		
		/**
		 * SEPERATOR seperates the several elements of an ID, for example:
		 * N-0-123-456
		 */ 
		public static const SEPERATOR:String = "-";
		
		/**
		 * IDS_SEPERATOR seperates cascaded ID's, for example
		 * for an attribute:
		 * N-0-123-456_A-0-123-456
		 */ 
		public static const IDS_SEPERATOR:String = "_";
		
		public static const PREFIX_ATTRIBUTE:String = "A" + SEPERATOR;
		public static const PREFIX_METHOD:String = "M" + SEPERATOR;
		public static const PREFIX_CONSTRUCTOR:String = "CO" + SEPERATOR;
		public static const PREFIX_NODE:String = "N" + SEPERATOR;
		public static const PREFIX_LINK:String = "L" + SEPERATOR;
		
		public static const DEFAULT_ATTRIBUTE_IDENTIFIER:Identifier = new Identifier(PREFIX_ATTRIBUTE + "default_attr");
		public static const DEFAULT_METHOD_IDENTIFIER:Identifier = new Identifier(PREFIX_METHOD + "default_meth");
		public static const DEFAULT_CONSTRUCTOR_IDENTIFIER:Identifier = new Identifier(PREFIX_CONSTRUCTOR + "default_constr");
	
		
		public function WAOKeyGenerator(wave:Wave)
		{
			this.wave = wave;
		}
		
		/**
		 * The identifier consists of:
		 * 	- the prefix depending on the element for which the identifier is used
		 * 	- the id of the user who created the element (wave-account)
		 * 	- the current timestamp
		 * 	- and random number.
		 */ 
		private function generateIdentifier(prefix:String):Identifier
		{
			var key:String = prefix + 
				getViewerId() + SEPERATOR +
				new Date().getTime() + SEPERATOR + 
				new Number(int.MAX_VALUE * Math.random()).toFixed(0);
			
			// replace all occurences of IDS_SEPERATOR 
			// (the viewer id could have such characters)
			if (key.indexOf(IDS_SEPERATOR) >= 0)
			{
				key = key.replace(IDS_SEPERATOR, "|");
			}
			
			return new Identifier(key);
		}
		
		private function getViewerId():String
		{
			return (wave.getViewer() != null) ?
				wave.getViewer().getId() :
				"0";
		}
		
		public function generateNodeIdentifier():Identifier
		{
			return generateIdentifier(PREFIX_NODE);
		}
		
		public function generateLinkIdentifier():Identifier
		{
			return generateIdentifier(PREFIX_LINK);
		}
		
		public function generateAttributeIdentifier():Identifier
		{
			return generateIdentifier(PREFIX_ATTRIBUTE);
		}
		
		public function generateMethodIdentifier():Identifier
		{
			return generateIdentifier(PREFIX_METHOD);
		}
		
		public function generateConstructorIdentifier():Identifier
		{
			return generateIdentifier(PREFIX_CONSTRUCTOR);
		}
		
		
		public static function isConstructor(id:Identifier):Boolean
		{
			return isConstructorKey(id.getId());
		}
		
		public static function isMethod(id:Identifier):Boolean
		{
			return isMethodKey(id.getId());
		}
		
		public static function isAttribute(id:Identifier):Boolean
		{
			return id.getId().substr(0, 2) == PREFIX_ATTRIBUTE;
		}
		
		
		public static function isConstructorKey(key:String):Boolean
		{
			return key.substr(0, 3) == PREFIX_CONSTRUCTOR;
		}
		
		public static function isMethodKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_METHOD;
		}
		
		public static function isAttributeKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_ATTRIBUTE;
		}
		
		public static function isNodeKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_NODE;
		}
		
		public static function isLinkKey(key:String):Boolean
		{
			return key.substr(0, 2) == PREFIX_LINK;
		}
		
		/**
		 * Returns the identifier for a class element (attribute, method, constructor)
		 * from the wave state key.
		 * 
		 * For example:
		 * C-001_A-002 --> A-002
		 *
		 *  @param key wave state key
		 *  @return The 2nd half of the key
		 */  
		public static function getNodeElementIdentifier(key:String):String
		{
			var seperatorPos:int = key.indexOf(IDS_SEPERATOR);
			
			return key.substring(seperatorPos + 1, key.length);
		}
		
		/**
		 * Returns the identifier of the parent element (node or link)
		 * from the wave state key.
		 * 
		 * For example:
		 * C-001_A-002 --> C-001
		 * C-001 --> C-001
		 * 
		 *  @param key wave state key
		 *  @return The 1st half of the key
		 */  
		public static function getParentIdentifier(key:String):String
		{
			var seperatorPos:int = key.indexOf(IDS_SEPERATOR);
			
			if (seperatorPos < 0)
			{
				return key;
			}
			else
			{
				return key.substring(0, seperatorPos); 
			}
		}
	}
}