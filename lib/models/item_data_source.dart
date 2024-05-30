import '../api/baseNetwork.dart';

class AgentDataSource {
  static AgentDataSource instance = AgentDataSource();
  Future<Map<String, dynamic>> loadAgents() {
    return BaseNetwork.get("agents");
  }
}

class AgentDetailSource {
  static AgentDetailSource instance = AgentDetailSource();
  Future<Map<String, dynamic>> loadAgentDetail(String agentUuid) {
    return BaseNetwork.get("agents/${agentUuid}");
  }
}

class MapSource {
  static MapSource instance = MapSource();
  Future<Map<String, dynamic>> loadMaps() {
    return BaseNetwork.get("maps");
  }
}

