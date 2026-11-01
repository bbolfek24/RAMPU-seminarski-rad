import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}


class PocetnaStranica extends StatefulWidget {
  const PocetnaStranica({super.key});

  @override
  State<PocetnaStranica> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PocetnaStranica> {
  int odabraniDinosaur = 0;
  String odabraniPrikaz = "";
  void promijeniPrikaz(String prikaz){
    setState(() {
      odabraniPrikaz = prikaz;
    });
  }

Widget prikaziSadrzaj(){
  switch (odabraniPrikaz){
    case "lista":
      return ListView(
          children: [
            ListTile(leading: Icon(Icons.volcano), title: Text("T-rex"), subtitle: Text("Theropod"),),
            ListTile(leading: Icon(Icons.volcano), title: Text("Brontosaurus"), subtitle: Text("Sauropod"), tileColor: Colors.amberAccent,),
            ListTile(leading: Icon(Icons.volcano), title: Text("Triceratops"), subtitle: Text("Marginocephalian"),),
            ListTile(leading: Icon(Icons.volcano), title: Text("Stegosaurus"), subtitle: Text("Thyreophoran"), tileColor: Colors.amberAccent,),
          ], 
        );
    case "horizontalnalista":
      return SizedBox(
        height: 200,
        child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 150,
            height: 200,
            margin: EdgeInsets.all(10),
            color: Colors.amberAccent,
            child: Center(
            child: Text("T-rex"),
            ),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.all(10),
            color: Colors.blueAccent,
            child: Center(
            child: Text("Brontosaurus"),
            ),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.all(10),
            color: Colors.deepOrangeAccent,
            child: Center(
            child: Text("Triceratops"),
            ),
          ),
          Container(
            width: 150,
            margin: EdgeInsets.all(10),
            color: Colors.greenAccent,
            child: Center(
            child: Text("Stegosaurus"),
            ),
          )
        ],
      )
      );
      
    case "tablica":
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
       child:  DataTable( 
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16,
      ),
      dataRowMinHeight: 60,
      dataRowMaxHeight: 60,
      columnSpacing: 40,
      border: TableBorder.all(
        color: Colors.amber.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      columns: [
      DataColumn(label: Text("Naziv")),
      DataColumn(label: Text("Vrsta"))
    ], rows: [
      DataRow(color: WidgetStatePropertyAll(Colors.amberAccent), cells: [
        DataCell(Text("T-rex")),
        DataCell(Text("Theropod"))
      ]),
      DataRow(cells: [
        DataCell(Text("Brontosaurus")),
        DataCell(Text("Sauropod"))
      ]),
      DataRow(color: WidgetStatePropertyAll(Colors.amberAccent), cells: [
        DataCell(Text("Triceratops")),
        DataCell(Text("Marginocephalian"))
      ]),
      DataRow(cells: [
        DataCell(Text("Stegosaurus")),
        DataCell(Text("Thyreophoran"))
      ])
    ])
      )
    );
    
    case "mreza":
      return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,), itemCount: 4, itemBuilder: (context, index){
        return Card(
          child: Image.network(slikeDinosaura[index],
          fit: BoxFit.cover
          ),
          
        );
      });

      case "tablica2":
        return PaginatedDataTable(
          header: Text("Dinosauri"),
          rowsPerPage: 3,
          columns: [
          DataColumn(label: Text("Naziv")),
          DataColumn(label: Text("Vrsta")),
        ], source: DinoDataSource());

      case "lista2":
        return ListView.builder(itemCount: 5, itemBuilder: ((context, index){
          return ListTile(
            leading: Icon(Icons.volcano),
            title: Text(dinosauri[index]["naziv"]!),
            subtitle: Text(dinosauri[index]["vrsta"]!),
          );
        }));

      case "kartica":
        return Center(
          child: Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    slikeDinosaura[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dinosauri[0]["naziv"]!,
                        style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                    ),

                      ),
                      SizedBox(height: 8),
                      Text("Vrsta: ${dinosauri[0]["vrsta"]}"),
                      SizedBox(height: 8),
                      Text("Poznati dinosaur iz razdoblja krede."),
                    ],
                  ),
                  ),
                ],
              ),
            ),
          ),
        );

    case "dropdown":
      return  Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
          DropdownButton<int>(
            value: odabraniDinosaur,
            items: List.generate(
              dinosauri.length,
              (index) {
                return DropdownMenuItem<int>(
                  value: index,
                  child: Text(dinosauri[index]["naziv"]!),
                );
              },
            ),
            onChanged: (novaVrijednost) {
              setState(() {
                odabraniDinosaur = novaVrijednost!;
              });
            },
          ),
          Text("Naziv: ${dinosauri[odabraniDinosaur]["naziv"]}"),
          Text("Vrsta: ${dinosauri[odabraniDinosaur]["vrsta"]}"),
        ],
      ),
    );

    default:
      return Center(
        child: Text("Odaberi prikaz"),
      );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: Icon(Icons.menu),
          
          backgroundColor: Colors.amber,
          title: const Text("Dinosauri"),
          
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amberAccent),
              child: Text("Različite vrste prikaza", style: TextStyle(fontSize: 30),)
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Lista"),
                onTap: (){
                  promijeniPrikaz("lista");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Horizontalna lista"),
                onTap: (){
                  promijeniPrikaz("horizontalnalista");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Tablica"),
                onTap: (){
                  promijeniPrikaz("tablica");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Mreža"),
                onTap: (){
                  promijeniPrikaz("mreza");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Paginirana tablica"),
                onTap: (){
                  promijeniPrikaz("tablica2");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("ListView Builder"),
                onTap: (){
                  promijeniPrikaz("lista2");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("Kartica"),
                onTap: (){
                  promijeniPrikaz("kartica");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.tune),
                title: Text("DropDown"),
                onTap: (){
                  promijeniPrikaz("dropdown");
                  Navigator.pop(context);
                },
              ),
            ]
            ),
        ),
        body: prikaziSadrzaj(),
      );
  }
}

  final List<Map<String, String>> dinosauri = [
    {"naziv": "T-rex", "vrsta": "Theropod"},
    {"naziv": "Brontosaurus", "vrsta": "Sauropod"},
    {"naziv": "Triceratops", "vrsta": "Marginocephalian"},
    {"naziv": "Stegosaurus", "vrsta": "Thyreophoran"},
    {"naziv": "Velociraptor", "vrsta": "Theropod"},
    {"naziv": "Spinosaurus", "vrsta": "Theropod"},
    {"naziv": "Ankylosaurus", "vrsta": "Thyreophoran"},
    {"naziv": "Diplodocus", "vrsta": "Sauropod"},
  ];
  final List<String> slikeDinosaura = [
  "https://i.natgeofe.com/k/825bd6d8-6daf-4019-8cab-9b4ed6c02545/tyrannosaurus-rex-closeup-jaws-walking_square.jpg",
  "https://www.nhm.ac.uk/content/dam/nhm-www/discover/brontosaurus-reinstated/brontosaurus-3d-render-reconstruction-full-width.jpg.thumb.1160.1160.png",
  "https://upload.wikimedia.org/wikipedia/commons/e/ec/LA-Triceratops_mount-2.jpg",
  "https://dinosaurland.es/wp-content/uploads/elementor/thumbs/dinosaurio-stegosaurus-dinosaurland-r1n5jvppvyq7ahgc8fksp9wkzqen5sq9cnu2l3cav4.jpg",
];

class DinoDataSource extends DataTableSource {

  @override
  DataRow? getRow(int index) {
    if(index >= dinosauri.length){
      return null;
    }
    final dino = dinosauri[index];

    return DataRow(cells: [
      DataCell(Text(dino["naziv"]!)),
      DataCell(Text(dino["vrsta"]!)),
    ]);
  }
  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dinosauri.length;

  @override
  int get selectedRowCount => 0;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const PocetnaStranica(),
    );
  }
}