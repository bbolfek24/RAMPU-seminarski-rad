# Reciklirajući prikazi podataka
## Lista
``` case "lista":
      return ListView(
          children: [
            ListTile(leading: Icon(Icons.volcano), title: Text("T-rex"), subtitle: Text("Theropod"),),
            ListTile(leading: Icon(Icons.volcano), title: Text("Brontosaurus"), subtitle: Text("Sauropod"), tileColor: Colors.amberAccent,),
            ListTile(leading: Icon(Icons.volcano), title: Text("Triceratops"), subtitle: Text("Marginocephalian"),),
            ListTile(leading: Icon(Icons.volcano), title: Text("Stegosaurus"), subtitle: Text("Thyreophoran"), tileColor: Colors.amberAccent,),
          ], 
        );
```
Lista se definira s pomoću widgeta _ListView_ u kojemu koristeći argument _children_ dodajemo stavke liste. Kako bi uspješno dodali stavku liste moramo koristiti widget _ListTile_ koji nam omogućuje prikaz elemenata jedne stavke poput naslova, podnaslova, ikone i slično. Stavke su prikazane jedna ispod druge i u slučaju da stavke ne stanu na ekran automatski će se omogućiti vertikalno pomicanje po listi.

## Horizontalna lista
```
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
```

Horizontalna lista radi veoma slično kao i vertikalna lista. Glavna razlika je u argumentu _scrollDirection: Axis.horizontal_. Tako zadajemo da lista ima horizontalni pomak, a ne vertikalni. Budući da se horizontalne liste najčešće koriste za neke oblike ili slike, koristi se widget _Container_. Njemu je moguće mijenjati vizualna svojstva poput boje, margina, širine i slično kako bi se uljepšala aplikacija. Horizontalna lista inače popuni visinu ekrana, no koristeći _SizedBox_ možemo definirati visinu liste i elemenata u njoj.

## Tablica
```
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
```
Tablica se definira s _DataTable_. Stupci tablice se definiraju s _columns_ s time da svaki stupac predstavlja jedan _DataColumn_. Redovi se definiraju s _rows_, a svaki redak predstavlja jedan _DataRow_. Pojedinačne ćelije u redcima se postavljaju s _DataCell_. Koristi se za strukturirano predstavljanje podataka.

## Tablica s paginacijom

```
case "tablica2":
        return PaginatedDataTable(
          header: Text("Dinosauri"),
          rowsPerPage: 3,
          columns: [
          DataColumn(label: Text("Naziv")),
          DataColumn(label: Text("Vrsta")),
        ], source: DinoDataSource());
```
```
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
```
```
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
```
Paginirana tablica koristi se kada želimo odvojiti podatke po stranicama tablice. Za nju se koristi _PaginatedDataTable_. Definiramo stupce s _columns_ i _DataColumn_ isto kao u običnoj tablici. _rowsPerPage_ govori koliko elemenata će biti prikazano na jednoj stranici tablice. Kako bi koristi paginiranu tablicu moramo ima _source_. U izvoru podataka tablice potrebno je definirati bitne metode poput _getRow_ koji vraća podatke jednog retka i _rowCount_ kako bi znali koliko elemenata ima tablica.

## Mrežni prikaz

```
 case "mreza":
      return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,), itemCount: 4, itemBuilder: (context, index){
        return Card(
          child: Image.network(slikeDinosaura[index],
          fit: BoxFit.cover
          ),
          
        );
      });
```
```
  final List<String> slikeDinosaura = [
  "https://i.natgeofe.com/k/825bd6d8-6daf-4019-8cab-9b4ed6c02545/tyrannosaurus-rex-closeup-jaws-walking_square.jpg",
  "https://www.nhm.ac.uk/content/dam/nhm-www/discover/brontosaurus-reinstated/brontosaurus-3d-render-reconstruction-full-width.jpg.thumb.1160.1160.png",
  "https://upload.wikimedia.org/wikipedia/commons/e/ec/LA-Triceratops_mount-2.jpg",
  "https://dinosaurland.es/wp-content/uploads/elementor/thumbs/dinosaurio-stegosaurus-dinosaurland-r1n5jvppvyq7ahgc8fksp9wkzqen5sq9cnu2l3cav4.jpg",
];
```
Mrežni prikaz nam omogućuju prikaz podataka u mreži (gridu). Koristi se najčešće za galerije ili prikaze većeg broja vizualnih elemenata. Za definiranje koristi se _GridView.builder_. Za početak s pomoću _gridDelegate: SliverGridDelegateWithFixedCrossAxisCount_ definiramo raspored elemenata koji imaju maksimalni opseg poprečne osi. _crossAxisCount_ koristimo da definiramo broj stupaca u mreži odnosno koliko će elemenata imati svaki redak. _crossAxisSpacing_ i _mainAxisSpacing_ određuju razmake između elemenata. _itemCount_ određuje broj elemenata koji će se prikazati. _itemBuilder_ se koristi za definiranje izgleda svakog elementa. Prima dva elementa. _context_ označuje položaj widgeta unutar strukture aplikacije. Tako može pristupati okolnim widgetima. _index_ predstavlja index elementa koji želimo prikazati. Elementi se prikazuju unutar widgeta _Card_ i s pomoću _Image.network_ se prikazuju slike. _fit: BoxFit.cover_ znači da će zauzeti prostor widgeta _Card_.

## Kartica

```
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
```
Kartica se koristi kao detaljniji vizualni prikaz jednog elementa. Koristimo widget _Card_ koji može primiti puno argumenta koji vizualno utječu na njega poput _elevation_ i _margin_. Koristimo _column_ kako bi se tekst i slika prikazivali jedno ispod drugog. Koristi se _SizedBox_ kako bi upravljali visinom različitih elemenata i _Center_ kako bi centrirali karticu. Argument _mainAxisSize: MainAxisSize.min_ govori da element uzme onoliko prostora koliko mu treba za djecu, a argument _crossAxisAlignment: CrossAxisAlignment.start_ poravnava djecu elementa. 

## Padajući izbornik

```
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
```
Koristimo _DropdownButton_ kako bi definirali padajuću listu. On je _int_ jer radimo s indeksima iz liste, a ne prikazanim imenima. S pomoću _List.generate_ postavljamo listu dinosaura kao opcije padajuće liste. _DropdownMenuItem_ označuje jednu opciju u padajućoj listi. _value_ joj je index tog elementa u listi. _onChanged_ definira što se dogodi dok korisnik odabere drugu opciju. Pozivom funkcije _setState()_ javljamo flutteru da se nešto promijenilo pa da se prikaz ekrana treba ponovno izgraditi. 

## Lista s dinamičkim generiranjem

```
case "lista2":
        return ListView.builder(itemCount: 5, itemBuilder: ((context, index){
          return ListTile(
            leading: Icon(Icons.volcano),
            title: Text(dinosauri[index]["naziv"]!),
            subtitle: Text(dinosauri[index]["vrsta"]!),
          );
        }));
```
Za listu s dinamičkim generiranjem potreban nam je _ListView.builder_. On ima argumente _itemCount_ koji definira koliko će se podataka dohvatiti iz izvora. Argument _itemBuilder_ prima kontekst i index isto kao i kod mrežnog prikaza. Vraća se widget _ListTile_ za svaki element u kojemu se prikazuje ikona, naslov i podnaslov. Prednost ovog pristupa je lazy loading, odnosno izrada elemenata prema potrebi tijekom prikazivanja i pomicanja kroz listu.
