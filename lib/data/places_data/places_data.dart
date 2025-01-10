import 'package:tourist_guide/core/utils/user_manager.dart';
import 'package:tourist_guide/data/models/landmark_model.dart';
import 'package:tourist_guide/gen/assets.gen.dart';

class PlacesData {
  static List<String> favPlaces = UserManager().getFavPlaces();

  static List<LandMark> kLandmarks = [
    LandMark(
        id: '0',
        imgPath: [
          Assets.images.sphinx.image(),
          Assets.images.sphinx2.image(),
          Assets.images.sphinx3.image(),
        ],
        name: 'Sphinx',
        governorate: 'Giza',
        rate: '5.0',
        fav: favPlaces.contains('0') ? true : false,
        description: '''
Ancient Egyptian sphinxes represented the king with the body of a lion, in a clear demonstration of his power. The evidence points to the Great Sphinx having been carved during the reign of Khafre (Khefren to the ancient Greeks; c. 2558–2532 BC), the builder of the second of the Giza pyramids.'''),
    LandMark(
        id: '1',
        imgPath: [
          Assets.images.pyramids.image(),
          Assets.images.pyramids2.image(),
          Assets.images.pyramids3.image(),
        ],
        name: 'Pyramids',
        governorate: 'Giza',
        rate: '5.0',
        fav: favPlaces.contains('1') ? true : false,
        description: '''
The Giza pyramid complex (also called the Giza necropolis) in Egypt is home to the Great Pyramid, the Pyramid of Khafre, and the Pyramid of Menkaure, along with their associated pyramid complexes and the Great Sphinx. All were built during the Fourth Dynasty of the Old Kingdom of ancient Egypt, between c. 2600 – c. 2500 BC. The site also includes several temples, cemeteries, and the remains of a workers' village.
The site is at the edge of the Western Desert, approximately 9 km (5.6 mi) west of the Nile River in the city of Giza, and about 13 km (8.1 mi) southwest of the city centre of Cairo. It forms the northernmost part of the 16,000 ha (160 km2; 62 sq mi) Pyramid Fields of the Memphis and its Necropolis UNESCO World Heritage Site, inscribed in 1979.[1] The pyramid fields include the Abusir, Saqqara, and Dahshur pyramid complexes, which were all built in the vicinity of Egypt's ancient capital of Memphis.[1] Further Old Kingdom pyramid fields were located at the sites Abu Rawash, Zawyet El Aryan, and Meidum.'''),
    LandMark(
        id: '2',
        imgPath: [
          Assets.images.grandMuseum.image(),
          Assets.images.grandMuseum2.image(),
        ],
        name: 'Grand Egyptian Museum',
        governorate: 'Giza',
        rate: '4.8',
        fav: favPlaces.contains('2') ? true : false,
        description: '''
The Grand Egyptian Museum, also known as the Giza Museum, is an archaeological museum under construction in Giza, Egypt, about 2 kilometres (1.2 miles) from the Giza pyramid complex. The Museum will host over 100,000 artifacts from ancient Egyptian civilization, including the complete Tutankhamun collection, and many pieces will be displayed for the first time.[4] With 81,000 m2 (872,000 sq ft) of floor space, it will be the world's largest archeological museum.[5] It is being built as part of a new master plan for the Giza Plateau, known as "Giza 2030".
'''),
    LandMark(
        id: '3',
        imgPath: [
          Assets.images.egyptianMuseum.image(),
          Assets.images.egyptianMuseum2.image(),
        ],
        name: 'Egyptian Museum',
        governorate: 'Cairo',
        rate: '4.9',
        fav: favPlaces.contains('3') ? true : false,
        description: '''
The Museum of Egyptian Antiquities, commonly known as the Egyptian Museum , (also called the Cairo Museum), located in Cairo, Egypt, houses the largest collection of Egyptian antiquities in the world.[1] It houses over 120,000 items, with a representative amount on display. Located in Tahrir Square in a building built in 1901, it is the largest museum in Africa. Among its masterpieces are Pharaoh Tutankhamun's treasure, including its iconic gold burial mask, widely considered one of the best-known works of art in the world and a prominent symbol of ancient Egypt.'''),
    LandMark(
        id: '4',
        imgPath: [
          Assets.images.abuSimple.image(),
          Assets.images.abuSimple2.image(),
          Assets.images.abuSimple3.image(),
        ],
        name: 'Abu-Simbel Temple',
        governorate: 'Luxor',
        rate: '4.9',
        fav: favPlaces.contains('4') ? true : false,
        description: '''
The Cairo Tower is a free-standing concrete tower in Cairo, Egypt. At 187 m (614 ft), it was the tallest structure in Egypt for 37 years until 1998, when it was surpassed by the Suez Canal overhead powerline crossing. It was the tallest structure in North Africa for 21 years until 1982, when it was surpassed by the Nador transmitter in Morocco. It was the tallest structure in Africa for one year until 1962, when it was surpassed by Sentech Tower in South Africa.
One of Cairo's well-known modern monuments, sometimes considered Egypt's second most famous landmark after the Pyramids of Giza, it stands in the Gezira district on Gezira Island in the River Nile, close to downtown Cairo.'''),
    LandMark(
        id: '5',
        imgPath: [
          Assets.images.cairoTower.image(),
          Assets.images.cairoTower2.image(),
        ],
        name: 'Cairo Tower',
        governorate: 'Cairo',
        rate: '4.9',
        fav: favPlaces.contains('5') ? true : false,
        description: '''
Abu Simbel is a historic site comprising two massive rock-cut temples in the village of Abu Simbel, Aswan Governorate, Upper Egypt, near the border with Sudan. It is located on the western bank of Lake Nasser, about 230 km (140 mi) southwest of Aswan (about 300 km (190 mi) by road). The twin temples were originally carved out of the mountainside in the 13th century BC, during the 19th Dynasty reign of the Pharaoh Ramesses II. Their huge external rock relief figures of Ramesses II have become iconic. His wife, Nefertari, and children can be seen in smaller figures by his feet. Sculptures inside the Great Temple commemorate Ramesses II's heroic leadership at the Battle of Kadesh.'''),
    LandMark(
        id: '6',
        imgPath: [
          Assets.images.karnak.image(),
          Assets.images.karnak2.image(),
        ],
        name: 'Karnak Temple',
        governorate: 'Luxor',
        rate: '4.9',
        fav: favPlaces.contains('6') ? true : false,
        description: '''
The Karnak Temple Complex, commonly known as Karnak, comprises a vast mix of temples, pylons, chapels, and other buildings near Luxor, Egypt. Construction at the complex began during the reign of Senusret I (reigned 1971–1926 BC) in the Middle Kingdom (c. 2000–1700 BC) and continued into the Ptolemaic Kingdom (305–30 BC),'''),
  ];

  List<LandMark> suggestedPlaces() {
    List<LandMark> suggestedPlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (i.isEven) {
        suggestedPlaces.add(kLandmarks[i]);
      }
    }
    return suggestedPlaces;
  }

  List<LandMark> popularPlaces() {
    List<LandMark> popularPlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (i.isOdd) {
        popularPlaces.add(kLandmarks[i]);
      }
    }
    return popularPlaces;
  }

  List<LandMark> favoritePlaces() {
    List<LandMark> favoritePlaces = [];
    for (int i = 0; i < kLandmarks.length; i++) {
      if (kLandmarks[i].fav) {
        favoritePlaces.add(kLandmarks[i]);
      }
    }
    return favoritePlaces;
  }

  List<LandMark> nearbyPlaces(LandMark landmark) {
    List<LandMark> favoritePlaces = [];
    for (LandMark i in kLandmarks) {
      if (i.governorate == landmark.governorate && i.id != landmark.id) {
        favoritePlaces.add(i);
      }
    }

    return favoritePlaces;
  }
}