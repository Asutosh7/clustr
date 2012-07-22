package events
{
	import flash.events.Event;

	/**
	 * ...
	 * @author dotminic
	 */
	public class AddNodeEvent extends Event
	{
		public static const ADD_NODE:String = "addNode";
		
		private var m_x:Number;
		private var m_y:Number;
		
		public function AddNodeEvent( type:String, x:Number, y:Number )
		{
			super(type, false, false);
			m_x = x;
			m_y = y;
		}
		
		public function get x():Number
		{
			return m_x;
		}
		
		public function get y():Number
		{
			return m_y;
		}	
	}
}