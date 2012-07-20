package com.signalsondisplay.clustr
{
	/**
	 * ...
	 * @author dotminic
	 */
	public class GridCell 
	{
		public var visited:Boolean;
		private var m_nodes:Vector.<ClusterNode>;

		public function GridCell() 
		{
			visited = false;
			m_nodes = new Vector.<ClusterNode>();
		}
		
		public function addNode( node:ClusterNode ):void
		{
			m_nodes.push(node);
		}
		
		public function get nodes():Vector.<ClusterNode>
		{
			return m_nodes;
		}
		
		public function clear():void
		{
			visited = false;
			m_nodes.length = 0;
		}
		
		public function get size():int
		{
			return m_nodes.length;
		}
	}
}