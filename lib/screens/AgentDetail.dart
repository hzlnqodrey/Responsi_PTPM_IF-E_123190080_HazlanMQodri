import 'package:flutter/material.dart';
import '../models/AgentsModel.dart';
import '../models/AgentDetailModel.dart';
import '../models/item_data_source.dart';
import 'package:responsi_123190080_hazlan/models/item_data_source.dart';

class AgentDetail extends StatefulWidget {
  final AgentModel data;
  final String? uuid;
  final int index;
  const AgentDetail({
    Key? key,
    required this.data,
    required this.index,
    required this.uuid,
  }) : super(key: key);

  @override
  _AgentDetailState createState() => _AgentDetailState();
}

class _AgentDetailState extends State<AgentDetail> {
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: Color.fromARGB(255, 37, 85, 50),
        appBar: AppBar(
          title: Text(
            'Detail Agents',
          ),
          backgroundColor: Color.fromARGB(255, 37, 85, 50),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 35.0),
        //   child: ElevatedButton(
        //     onPressed: () async {
        //       final url =
        //           widget.data.books?[0].link ?? "https://www.google.com";
        //       if (await canLaunch(url)) {
        //         await launch(url);
        //       } else {
        //         // Handle the error when the URL can't be launched
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(content: Text('Could not launch $url')),
        //         );
        //       }
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: Color.fromARGB(255, 37, 85, 50),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(20),
        //       ),
        //     ),
        //     child: Text(
        //       "Info Buku",
        //       style: TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
            child: Container(
                child: FutureBuilder(
                    future: AgentDetailSource.instance
                        .loadAgentDetail(widget.uuid ?? ""),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return _buildErrorSection();
                      }
                      if (snapshot.hasData) {
                        AgentDetailModel data =
                            AgentDetailModel.fromJson(snapshot.data);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data.data?.background ??
                                          "https://islandpress.org/files/default_book_cover_2015.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data.data?.background ??
                                          "https://islandpress.org/files/default_book_cover_2015.jpg",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 230,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              (data.data?.fullPortraitV2 == "")
                                                  ? "https://islandpress.org/files/default_book_cover_2015.jpg"
                                                  : data.data?.fullPortraitV2 ??
                                                      "",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0, vertical: 25),
                                        child: ListView(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "" +
                                                  "${data.data?.displayName}" +
                                                  " ${data.data?.developerName}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Roles: " +
                                                  "${data.data?.role?.displayName}",
                                              style: TextStyle(
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data.data?.description ?? "",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Abilities",
                                              style: TextStyle(
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: data.data?.abilities
                                                      ?.length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data
                                                              .data
                                                              ?.abilities?[
                                                                  index]
                                                              .displayName ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      data
                                                              .data
                                                              ?.abilities?[
                                                                  index]
                                                              .description ??
                                                          "",
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return _buildLoadingSection();
                    })))));
  }

  Widget _buildErrorSection() {
    return Center(
      child: Text("Error"),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
