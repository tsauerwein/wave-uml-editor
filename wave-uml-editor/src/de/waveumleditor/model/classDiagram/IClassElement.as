package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	
	public interface IClassElement
	{
		function isStatic():Boolean;

		function isAbstract():Boolean;

		function toString():String;
		
		function getKey():Identifier;

	}
}