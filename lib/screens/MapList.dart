import 'package:flutter/material.dart';
import '../models/item_data_source.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/MapsModel.dart';

class MapList extends StatefulWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  @override
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
        title: const Text('Maps'),
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
            future: MapSource.instance.loadMaps(),
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.hasError) {
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                MapsModel maps = MapsModel.fromJson(snapshot.data);
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: maps.data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink[100],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image.network(
                              maps.data?[index].displayIcon ?? "",
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              maps.data?[index].displayName ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              maps.data?[index].coordinates ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _launchURL(maps.data?[index].mapUrl ?? "");
                              },
                              child: Text("View Map"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return _buildLoadingSection();
            }),
      ),
    ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
