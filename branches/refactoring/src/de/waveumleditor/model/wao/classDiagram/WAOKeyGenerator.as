package de.waveumleditor.model.wao.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.wao.wave.Delta;
	
	public class WAOKeyGenerator
	{
		
		public static const SEPERATOR:String = "-";
		public static const IDS_SEPERATOR:String = "_";
		
		public static const PREFIX_ATTRIBUTE:String = "A" + SEPERATOR;
		public static const PREFIX_METHOD:String = "M" + SEPERATOR;
		public static const PREFIX_CONSTRUCTOR:String = "CO" + SEPERATOR;
		public static const PREFIX_NODE:String = "N" + SEPERATOR;
		public static const PREFIX_LINK:String = "L" + SEPERATOR;
		
		public static const DEFAULT_ATTRIBUTE_IDENTIFIER:Identifier = new Identifier(PREFIX_ATTRIBUTE + "default_attr");
		public static const DEFAULT_METHOD_IDENTIFIER:Identifier = new Identifier(PREFIX_METHOD + "default_meth");
		public static const DEFAULT_CONSTRUCTOR_IDENTIFIER:Identifier = new Identifier(PREFIX_CONSTRUCTOR + "default_constr");
	
		
		public function WAOKeyGenerator()
		{
		}
		
		public function generateNodeIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			// eigene ID: wave.getViewer().getId()
			return new Identifier(PREFIX_NODE + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateLinkIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_LINK + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateAttributeIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_ATTRIBUTE + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateMethodIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_METHOD + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateConstructorIdentifier():Identifier
		{
			// todo: abhängig von node
			//var nodeList:List = diagram.getNodes();
			return new Identifier(PREFIX_CONSTRUCTOR + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public static function isConstructor(id:Identifier):Boolean
		{
			return id.getId().substr(0, 3) == PREFIX_CONSTRUCTOR;
		}
		
		public static function isMethod(id:Identifier):Boolean
		{
			return id.getId().substr(0, 2) == PREFIX_METHOD;
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