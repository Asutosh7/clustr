package com.signalsondisplay.clustr
{
	/**
	 * ...
	 * @author dotminic
	 */
	public class ClusterNode 
	{
		public var x:Number;
		public var y:Number;
		public var visited:Boolean;
		private var m_clusterID:int;
		
		public function ClusterNode( x:Number, y:Number, clusterID:int = -1 ) 
		{
			this.x = x;
			this.y = y;
			m_clusterID = clusterID;
			visited = false;
		}
		
		public function set clusterID( id:int ):void
		{
			m_clusterID = id;
		}
		
		public function get clusterID():int
		{
			return m_clusterID;
		}
	}
}