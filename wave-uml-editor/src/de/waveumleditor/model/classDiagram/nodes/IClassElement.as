package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	
	public interface IClassElement extends IIdentifiable
	{
		function isStatic():Boolean;

		function isAbstract():Boolean;

		function toString():String;

	}
}