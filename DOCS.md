# Dokumentation

Detta är en guide till de verktyg och tekniker som vi har använt för att utveckla CrossDump.
Vi berättar om vilka olika lösningar vi övervägt och hur den slutliga lösningen implementeras.
CrossDump använder Mapbox GL som karttjänst och här kan du läsa om generering av kartor och hur de installeras på displayen och hur du designar kartan med färger och 3D-byggnader.
Vi beskriver även detaljer om hur navigering hanteras med C++ i appens backend med hjälp av Mapbox.
Ruttoptimering och geofencing har implementerats med egen logik, men det finns även andra alternativ att utforska.

## Kartor

I det här avsnittet beskriver vilka lösningar vi använt för att rita upp kartor i appen.

### Mapbox

Mapbox används för att rita upp kartor i appen.
Qt behöver en access token från Mapbox för att kunna använda det i appen.
En access token behövs även för att kunna använda egna designer på kartor och ladda ner offline-kartor till appen.
När du [skapar ett användarkonto på Mapbox hemsida](https://account.mapbox.com/) får du tillgång till en access token.

### Qt-tillägget Mapbox GL och alternativ

För att hämta och rendera en karta i appen finns det ett antal tillägg till Qt som kan användas.
Vi har testat OpenStreetMap, Mapbox och Mapbox GL. 
Några skillnader mellan tilläggen är hur de hanterar offline-kartor, 3D-funktioner och kartutseende, men de har alla god dokumentation för hur de används i Qt.

Kod för kartan ligger huvudsakligen i `main.qml` och `MapView.qml`.
I `main.qml` väljs vilket kart-plugin som ska användas och parametrar till pluginet.
Här anges appens access token och vilket/vilka kartstilar som ska användas.
Kartstilar finns antingen färdigskapade från Mapbox, eller så kan du skapa egna styles med Mapbox Studio.
I `MapView.qml` används QML-komponenten `Map` och kopplas ihop med vårt plugin i `main.qml` för att visa kartor från Mapbox.
`Map`-komponenten har olika properties för att ställa in zoom-nivå, vilken kartstil som ska visas, ikoner som ska visas på kartan, och mycket mer.

Mapbox GL är den enda av de olika karttilläggen som är hårdvaruaccelererad, vilket innebär att det bland annat utnyttjar en dators grafikkort till en högre grad för att utföra vissa beräkningar.
Detta borde vara en prestandafördel på CrossControls displayer, eftersom appen lätt kan bli begränsad eller långsam om den enbart utnyttjar processorns prestanda.
Trots detta så sker kartuppdateringen långsammare med på displayen CCpilot VS med Mapbox GL än andra karttjänster. 

I VM:en kan Mapbox GL köra snabbt genom att slå på följande inställning i VirtualBox: Settings -> Display -> Enable 3D acceleration

Vi tror att det är möjligt att optimera implementationen för att Mapbox GL ska kunna leverera en lika snabb lösning som med vanliga Mapbox eller OpenStreetMap.
Vi har redan sett att vår app kan köra snabbt på displayer med lite bättre prestanda, så vi ser potential för att optimera vår app även för CCpilot VS.

Vi gjorde ett snabbt test med att använda raster tiles istället för vector tiles, men det gjorde ingen skillnad på prestanda.
Det är möjligt att det kan ge skillnad med vidare undersökning.

Mapbox GL har också fler funktioner som till exempel 3D-grafik och olika typer av kartstilar, vilket hjälper att förhöja användarupplevelsen.

### Kartstilar och Mapbox Studio

[Mapbox Studio](https://studio.mapbox.com/) används för att designa olika kartstilar som kan användas till kartorna i appen.
När du skapar en ny kartstil i Mapbox Studio går det att välja vilken existerande stil den ska baseras på, vilket gör det snabbt att komma igång.
När stilen är skapad visas en förhandsvisning av kartan och du kommer in i ett redigeringsläge.
Runt kartan finns olika inställningar för hur färgerna ska se ut, om 3D-läge ska vara påslaget, och mycket mer.

När kartstilen känns färdig klickar du på "Publish" uppe i högra hörnet.

För att få en länk till kartstilen som kan användas i Qt-appen, klicka på "Share" uppe i högra hörnet och kopiera texten under "Style URL".
Se `main.qml` i vårt repo för exempel på hur länkarna ska användas.
Det går även att ha flera olika kartstilar i en app och växla mellan dem, till exempel för dag- och nattläge.
Då lägger du in länkar till både kartstilarna med ett kommatecken mellan sig.
För att välja vilken av kartstilarna som ska användas av `Map`-komponenten kan propertyn `activeMapType` sättas enligt `activeMapType: supportedMapTypes[index]`, där `index` är ett nollindexerat nummer som säger vilken av kartstilarna som ska visas.

Under avsnittet [Offline-läge](#offline-läge) beskrivs hur egenskapade kartstilar kan användas till offline-kartor.

## Navigering

Appen använder Qt-tillägg för Mapbox för att hämta navigeringsinformation.
Hämtning av navigeringsinformation sker bland annat i `navigator.cpp`.

### Ruttoptimering

CrossDump har support för ruttoptimering, dvs att man kan sortera ordningen på olika destination för att få kortast totala körsträcka. Detta fungerar bra upp till 8-9 destinationer och sker ganska rappt.

Beräkningen sker med data från körinstruktioner mellan alla olika destinationer.
Detta innebär att den måste hämta ner *n*^2 instruktioner från internet innan uträkningen kan börja.
Uträkningen sker sedan lokalt och provar alla kombinationer.
Detta får tidskomplexitet *O*(*n*!) så är inte lämpligt att använda för mer än kanske 8-9 destinationer med nuvarande lösning.

Koden för att förbereda körinstruktioner ligger inuti `availableroutes.cpp`. Koden för själva optimering ligger inuti `route.cpp`.

En fördel med vår egna lösningen är att den är redo att användas offline när offline navigering är implementerat.

#### Möjlig implementation av ruttoptimering med Mapbox Optimization API

Vi undersökte även att använda [Mapbox Optimization API](https://docs.mapbox.com/help/tutorials/optimization-api/).
API:n har support för upp till 12 olika destinationer.

[QGeoRoutingManager](https://doc.qt.io/qt-5/qgeoroutingmanager.html) som används i `navigator.cpp` verkar inte ha någon support för de ändringar som behövs för att använda Optimization API.
Mapbox implementationen i Qt kallar alltid på endpointen `/driving/`.
Vi kan inte hitta någon parameter som gör att den istället skulle använda endpointen `/optimized-trips/`.
Det finns en stor mängd "gömda" parametrar man kan skicka in till funktionen med [`setExtraParameters()`](https://doc.qt.io/qt-5/qgeorouterequest.html#setExtraParameters), en odokumenterad sådan kanske kan användas.

### Turn-by-turn-navigering

Den inbyggda [QML Navigator](https://doc-snapshots.qt.io/qt5-5.11/qml-navigator.html) ska ha support för turn-by-turn men vi kunde inte få detta att fungera ens när navigeringen hämtades i frontend.
Efter navigering flyttades till backend var Navigator inte ens ett möjligt alternativ, så vi valde att implementera turn-by-turn själva.

Turn-by-turn sker i klassen i `traveler.cpp`. Traveler är en QObject som med en rutt och position räknar ut hur långt på rutten den har färdats. 
Traveler har en väldigt stor mängd properties, som inkluderar kommande körmanöver, tid färdats, plats på rutten och en del teknisk data som används av andra klasser.
Traveler använder sig av funktioner i `collisionhelper.cpp` för att se var den överlappar med körvägen.

### Geofencing (geostaket)

Traveler har också en variant av geofencing, för att upptäcka om den ligger inuti en Zon.
Detta sker också med hjälp av `collisionhelper.cpp`, med en punkt i polygon funktion, där zonen matas in som polygon.
Dessa zoner kan även ritas ut på kartan med [MapPolygon](https://doc.qt.io/qt-5/qml-qtlocation-mappolygon.html).

## Offline-läge

Qt Location har olika map plugins för att visa kartor för användaren: Mapbox, Mapbox GL och OpenStreetMap.
Mapbox GL är det enda som gör det möjligt att lagra map tiles i cachen och sedan ladda in dem i appen när displayen är offline.
Både OpenStreetMap och vanliga Mapbox verkar lagrar sina map tiles i varsin cache-mapp, men mapparna används inte när appen startas i offline-läge.

### Generera offline-kartor för Mapbox GL

Cachen kan populeras med verktyg från repot till Mapbox GL.

#### Installera nedladdningsverktyg för Mapbox GL

Klona repot [mapbox-gl-native](https://github.com/mapbox/mapbox-gl-native) och gå in i mappen.

Installera alla dependencies som anges under repots [Linux-dokumentation](https://github.com/mapbox/mapbox-gl-native/tree/master/platform/linux).

Kör `cmake .`

Kör `make` (detta kan ta väldigt många timmar i den virtuella maskinen)

#### Generera map tiles för Mapbox GL

Vi behöver koordinater till en bounding box För att generera map tiles för ett specifikt område.
Det räcker med att välja latitud/longitud för hörnen i nordväst och sydöst.
Koordinater kan till exempel väljas med online-verktyget [mapcoordinates.net](https://www.mapcoordinates.net/en).

Gå in i mappen `bin` som ligger under repot för mapbox-gl-native.
I mappen `bin` finns scriptet `mbgl-offline` som används för att generera map tiles.
`mbgl-offline` kan anropas med flaggan `-h` för att visa alla olika funktioner som finns tillgängliga.
`--token` anger access token för användarkontot till Mapbox.
`--maxZoom` anger hur inzoomad kartan ska kunna visas (högre zoom innebär fler nedladdade bilder).
`--style` anger en speciell URL till en stylesheet som skapats med [Mapbox Studio](https://studio.mapbox.com/).
Följande kod genererar offline map tiles för större delen av Uppsala.

~~~
./mbgl-offline \
  --token='pk.eyJ1IjoiY2Fsdml0b24iLCJhIjoiY2s4anVncTFtMDRhcDNmbWtveXpua2kzbSJ9.mkdCbAYVquQK_uljD4_p0A' \
  --north 59.885147 \
  --west 17.587807 \
  --south 59.815897 \
  --east 17.727127 \
  --maxZoom 16 \
  --style mapbox://styles/calviton/cka3oanhl0lif1iqqj01o9z6r \
  --output uppsala.db
~~~

`uppsala.db` flyttas sedan till `~/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db` (nytt namn)

#### Offline-kartor med flera olika styles (3D-byggnader, satellitbilder, nattläge, etc.)

Ibland vill man kunna växla mellan satellitbilder och vanlig karta, och då behöver både kartorna laddas ner och slås ihop till en gemensam fil.

Generera map tiles enligt ovanstående avsnitt, men ändra argument `--style` och `--output` för respektive kartstil.

Följande kod slår ihop kartor för Uppsala med dag- och nattläge:

~~~
./mbgl-offline \
  --input=uppsala_day.db \
  --merge=uppsala_night.db
~~~

Kartan finns nu både med dag- och nattläge i filen `uppsala_day.db`.

Det går att välja Map style i `Map`-komponenten i QML genom att sätta propertyn `activeMapType` till någon av de första i listan `map.supportedMapTypes`, till exempel `activeMapType: map.supportedMapTypes[0]`.

#### Installera offline-kartor på CCpilot VS

Kopiera över alla map tiles till displayen via SSH:

~~~
scp uppsala.db ccs@192.168.0.163:~
ssh ccs@192.168.0.163
...
sudo su
mv uppsala.db /home/root/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db
~~~

#### Installera offline-kartor i virtuell maskin

Kopiera alla map tiles till cache-mappen:

~~~
cp uppsala.db ~/.cache/QtLocation/5.8/tiles/mapboxgl/mapboxgl.db
~~~

### Generera offline-kartor för OpenStreetMap (används inte)

**OBS:** Vi har ännu inte hittat ett sätt för OpenStreetMap att använda map tiles när appen är offline.
Scripten som finns i repot genererar bilder som liknar cachen som dyker upp när OpenStreetMap används för kartor, men cachen går inte  att använda offline.

I mappen `scripts` finns även olika scripts för att generera map tiles för OpenStreetMap.
Likt Mapbox ska alla genererade bilder flyttas till `~/.cache/QtLocation/5.8/tiles/openstreetmap`.
Inuti scripten finns dokumentation om hur de kan användas och var cache-mappen ligger för OpenStreetMap.

### Offline-navigering

Navigering sker i nuläget med Mapbox servrar och kräver att displayen har internetuppkoppling.
Det går inte att ladda in ny navigeringsinformation när displayen är offline.
En potentiell lösning till detta är att ladda ner navigeringsinformation för alla rutter när displayen väl har internet och lagra informationen till senare (detta har inte implementerats i appen ännu).

Det är dock möjligt att en förare gör mindre avvikelser från den givna rutten, vilket gör att appen skulle behöva visa navigeringsinformation som inte finns.
Om föraren avviker från sin rutt kommer det i nuläget inte upp nya körinstruktioner, utan föraren måste återvända till den ursprungliga rutten för att vägbeskrivningar ska visas igen.

Optimalt skulle navigeringsinformation beräknas helt på displayen, utan att behöva ansluta till Mapbox servrar över huvud taget.
Qt har i nuläget inget stöd för att beräkna navigera helt offline.
