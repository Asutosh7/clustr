package  
{
	import flash.events.Event;

	/**
	 * ...
	 * @author dotminic
	 */
	public class ToggleEvent extends Event
	{
		public static const TOGGLE:String = "toggle";
		
		private var m_visible:Boolean;

		public function ToggleEvent( type:String, visible:Boolean = false )
		{			
			super(type, false, false);
			m_visible = visible;
		}
		
		public function get visible():Boolean
		{
			return m_visible;
		}
	}
}