import 'package:flutter/material.dart';
import '../models/AgentsModel.dart';
import '../models/item_data_source.dart';
import 'package:responsi_123190080_hazlan/screens/AgentDetail.dart';
import 'package:url_launcher/url_launcher.dart';


class AgentList extends StatefulWidget {
  const AgentList({Key? key}) : super(key: key);

  @override
  _AgentListState createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  void initState() {
    super.initState();
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Agents'),
              backgroundColor: Colors.red[400],
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: Container(
                child: FutureBuilder(
              future: AgentDataSource.instance.loadAgents(),
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.hasError) {
                  return _buildErrorSection();
                }
                if (snapshot.hasData) {
                  AgentModel data = AgentModel.fromJson(snapshot.data);
                  return ListView.builder(
                    itemCount: data.data?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            print("UUID : ${data.data?[index].uuid}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return AgentDetail(
                                  data: data,
                                  index: index,
                                  uuid: data.data?[index].uuid,
                                );
                              }),
                            );
                          },
                          child: Card(
                              child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${data.data?[index].killfeedPortrait}"),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "" +
                                          "${data.data?[index].displayName}" +
                                          " ${data.data?[index].developerName}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )));
                    },
                  );
                }
                return _buildLoadingSection();
              },
            ))));
  }
}
