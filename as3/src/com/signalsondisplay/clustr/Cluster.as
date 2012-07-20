package com.signalsondisplay.clustr
{
	/**
	 * ...
	 * @author dotminic
	 */
	public class Cluster 
	{	
		private var m_id:int;
		private var m_nodes:Vector.<ClusterNode>;

		public function Cluster() 
		{
			m_id = -1;
			m_nodes = new Vector.<ClusterNode>();
		}
		
		public function get nodes():Vector.<ClusterNode>
		{
			return m_nodes;
		}
		
		public function set id( id:int ):void
		{
			m_id = id;
		}
		
		public function get id():int
		{
			return m_id;
		}
		
		public function addNode( node:ClusterNode ):void
		{
			m_nodes.push(node);
		}
		
		public function addNodeList( nodes:Vector.<ClusterNode> ):void
		{
			m_nodes = m_nodes.concat(nodes);
		}
		
		public function clear():void
		{
			m_nodes.length = 0;
			m_id = -1;
		}
	}
}