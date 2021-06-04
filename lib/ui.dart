/*
TODO: Load map from csv
Map<String, String> getPicoName(String csvPath) {
  final d = FirstOccurrenceSettingsDetector(textDelimiters: [':']);
  final converter = CsvToListConverter(csvSettingsDetector: d);
  /*final input = File('csvPath').openRead();
  final lines = await input.transform(utf8.decoder).transform(converter).toList().whenComplete(() => null);*/
  print("Starting convert CSV");
  print(StackTrace.current);
  final fileContent = rootBundle.loadString(csvPath); //.readAsStringSync();
  print("fileContent = $fileContent");
  //final lines =  ).transform(converter).toList().whenComplete(() => null);
  final lines = converter.convert(fileContent);
  Map<String, String> map = { for (final line in lines) line[0]: line[1] };
  print(map);
  return map;
}

Map<String, String> pictoIdToName = getPicoName("picto/jeuDeDonneesPictos.csv");*/

//"noms des fichiers" : "Indices commerciaux"
const pictoIdToName = {
  "7": "07genRVB.svg",
  "8": "08genRVB.svg",
  "20": "20genRVB.svg",
  "21": "21genRVB.svg",
  "22": "22genRVB.svg",
  "24": "24genRVB.svg",
  "25": "25genRVB.svg",
  "26": "26genRVB.svg",
  "27": "27genRVB.svg",
  "28": "28genRVB.svg",
  "29": "29genRVB.svg",
  "30": "30genRVB.svg",
  "31": "31genRVB.svg",
  "32": "32genRVB.svg",
  "35": "35genRVB.svg",
  "38": "38genRVB.svg",
  "39": "39genRVB.svg",
  "40": "40genRVB.svg",
  "42": "42genRVB.svg",
  "43": "43genRVB.svg",
  "45": "45genRVB.svg",
  "46": "46genRVB.svg",
  "47": "47genRVB.svg",
  "48": "48genRVB.svg",
  "52": "52genRVB.svg",
  "54": "54genRVB.svg",
  "56": "56genRVB.svg",
  "57": "57genRVB.svg",
  "58": "58genRVB.svg",
  "59": "59genRVB.svg",
  "60": "60genRVB.svg",
  "61": "61genRVB.svg",
  "62": "62genRVB.svg",
  "63": "63genRVB.svg",
  "64": "64genRVB.svg",
  "66": "66genRVB.svg",
  "67": "67genRVB.svg",
  "68": "68genRVB.svg",
  "69": "68genRVB.svg",
  "70": "70genRVB.svg",
  "71": "71genRVB.svg",
  "72": "72genRVB.svg",
  "73": "73genRVB.svg",
  "74": "74genRVB.svg",
  "75": "75genRVB.svg",
  "76": "76genRVB.svg",
  "77": "77genRVB.svg",
  "80": "80genRVB.svg",
  "82": "82genRVB.svg",
  "83": "83genRVB.svg",
  "84": "84genRVB.svg",
  "85": "85genRVB.svg",
  "86": "86genRVB.svg",
  "87": "87genRVB.svg",
  "88": "88genRVB.svg",
  "89": "89genRVB.svg",
  "91": "91genRVB.svg",
  "92": "92genRVB.svg",
  "93": "93genRVB.svg",
  "94": "94genRVB.svg",
  "95": "95genRVB.svg",
  "96": "96genRVB.svg",
  "98": "PCgenRVB.svg",
  "101": "101genRVB.svg",
  "102": "102genRVB.svg",
  "103": "103genRVB.svg",
  "104": "104genRVB.svg",
  "105": "105genRVB.svg",
  "106": "106genRVB.svg",
  "107": "107genRVB.svg",
  "108": "108genRVB.svg",
  "109": "109genRVB.svg",
  "110": "110genRVB.svg",
  "111": "111genRVB.svg",
  "112": "112genRVB.svg",
  "113": "113genRVB.svg",
  "114": "114genRVB.svg",
  "115": "115genRVB.svg",
  "116": "116genRVB.svg",
  "117": "117genRVB.svg",
  "118": "118genRVB.svg",
  "119": "119genRVB.svg",
  "120": "120genRVB.svg",
  "121": "121genRVB.svg",
  "122": "122genRVB.svg",
  "123": "123genRVB.svg",
  "124": "124genRVB.svg",
  "125": "125genRVB.svg",
  "126": "126genRVB.svg",
  "127": "127genRVB.svg",
  "128": "128genRVB.svg",
  "129": "129genRVB.svg",
  "131": "131genRVB.svg",
  "132": "132genRVB.svg",
  "133": "133genRVB.svg",
  "134": "134genRVB.svg",
  "137": "137genRVB.svg",
  "138": "138genRVB.svg",
  "139": "139genRVB.svg",
  "140": "140genRVB.svg",
  "141": "141genRVB.svg",
  "143": "143genRVB.svg",
  "144": "144genRVB.svg",
  "145": "145genRVB.svg",
  "146": "146genRVB.svg",
  "147": "147genRVB.svg",
  "148": "148genRVB.svg",
  "150": "150genRVB.svg",
  "151": "151genRVB.svg",
  "152": "152genRVB.svg",
  "153": "153genRVB.svg",
  "154": "154genRVB.svg",
  "156": "156genRVB.svg",
  "157": "157genRVB.svg",
  "158": "158genRVB.svg",
  "159": "159genRVB.svg",
  "160": "160genRVB.svg",
  "161": "161genRVB.svg",
  "162": "162genRVB.svg",
  "163": "163genRVB.svg",
  "164": "164genRVB.svg",
  "165": "165genRVB.svg",
  "166": "166genRVB.svg",
  "167": "167genRVB.svg",
  "168": "168genRVB.svg",
  "169": "169genRVB.svg",
  "170": "170genRVB.svg",
  "171": "171genRVB.svg",
  "172": "172genRVB.svg",
  "173": "173genRVB.svg",
  "174": "174genRVB.svg",
  "175": "175genRVB.svg",
  "176": "176genRVB.svg",
  "177": "177genRVB.svg",
  "178": "178genRVB.svg",
  "179": "179genRVB.svg",
  "180": "180genRVB.svg",
  "181": "181genRVB.svg",
  "182": "182genRVB.svg",
  "183": "183genRVB.svg",
  "184": "184genRVB.svg",
  "185": "185genRVB.svg",
  "186": "186genRVB.svg",
  "187": "187genRVB.svg",
  "188": "188genRVB.svg",
  "189": "189genRVB.svg",
  "190": "190genRVB.svg",
  "191": "191genRVB.svg",
  "192": "192genRVB.svg",
  "194": "194genRVB.svg",
  "195": "195genRVB.svg",
  "196": "196genRVB.svg",
  "197": "197genRVB.svg",
  "199": "199genRVB.svg",
  "201": "201genRVB.svg",
  "203": "203genRVB.svg",
  "206": "206genRVB.svg",
  "207": "207genRVB.svg",
  "210": "210genRVB.svg",
  "211": "211genRVB.svg",
  "212": "212genRVB.svg",
  "213": "213genRVB.svg",
  "214": "214genRVB.svg",
  "215": "215genRVB.svg",
  "216": "216genRVB.svg",
  "217": "217genRVB.svg",
  "220": "220genRVB.svg",
  "221": "221genRVB.svg",
  "234": "234genRVB.svg",
  "235": "235genRVB.svg",
  "237": "237genRVB.svg",
  "238": "238genRVB.svg",
  "239": "239genRVB.svg",
  "240": "240genRVB.svg",
  "241": "241genRVB.svg",
  "244": "244genRVB.svg",
  "247": "247genRVB.svg",
  "248": "248genRVB.svg",
  "249": "249genRVB.svg",
  "250": "250genRVB.svg",
  "251": "251genRVB.svg",
  "252": "252genRVB.svg",
  "253": "253genRVB.svg",
  "254": "254genRVB.svg",
  "255": "255genRVB.svg",
  "256": "256genRVB.svg",
  "258": "258genRVB.svg",
  "259": "259genRVB.svg",
  "260": "260genRVB.svg",
  "261": "261genRVB.svg",
  "262": "262genRVB.svg",
  "267": "267genRVB.svg",
  "268": "268genRVB.svg",
  "269": "269genRVB.svg",
  "270": "270genRVB.svg",
  "272": "272genRVB.svg",
  "274": "274genRVB.svg",
  "275": "275genRVB.svg",
  "276": "276genRVB.svg",
  "278": "278genRVB.svg",
  "279": "279genRVB.svg",
  "281": "281genRVB.svg",
  "283": "283genRVB.svg",
  "285": "285genRVB.svg",
  "286": "286genRVB.svg",
  "289": "289genRVB.svg",
  "290": "290genRVB.svg",
  "291": "291genRVB.svg",
  "292": "292genRVB.svg",
  "293": "293genRVB.svg",
  "294": "294genRVB.svg",
  "295": "295genRVB.svg",
  "297": "297genRVB.svg",
  "299": "299genRVB.svg",
  "301": "301genRVB.svg",
  "302": "302genRVB.svg",
  "303": "303genRVB.svg",
  "304": "304genRVB.svg",
  "306": "306genRVB.svg",
  "308": "308genRVB.svg",
  "310": "310genRVB.svg",
  "312": "312genRVB.svg",
  "317": "317genRVB.svg",
  "318": "318genRVB.svg",
  "319": "319genRVB.svg",
  "320": "320genRVB.svg",
  "321": "321genRVB.svg",
  "322": "322genRVB.svg",
  "323": "323genRVB.svg",
  "325": "325genRVB.svg",
  "330": "330genRVB.svg",
  "333": "333genRVB.svg",
  "334": "334genRVB.svg",
  "337": "337genRVB.svg",
  "341": "341genRVB.svg",
  "346": "346genRVB.svg",
  "347": "347genRVB.svg",
  "348": "348genRVB.svg",
  "349": "349genRVB.svg",
  "350": "350genRVB.svg",
  "351": "351genRVB.svg",
  "352": "352genRVB.svg",
  "353": "353genRVB.svg",
  "354": "354genRVB.svg",
  "355": "355genRVB.svg",
  "356": "356genRVB.svg",
  "357": "357genRVB.svg",
  "358": "358genRVB.svg",
  "360": "360genRVB.svg",
  "361": "361genRVB.svg",
  "363": "363genRVB.svg",
  "366": "366genRVB.svg",
  "367": "367genRVB.svg",
  "368": "368genRVB.svg",
  "370": "370genRVB.svg",
  "372": "372genRVB.svg",
  "378": "378genRVB.svg",
  "379": "379genRVB.svg",
  "380": "380genRVB.svg",
  "385": "385genRVB.svg",
  "388": "388genRVB.svg",
  "389": "389genRVB.svg",
  "390": "390genRVB.svg",
  "391": "391genRVB.svg",
  "392": "392genRVB.svg",
  "393": "393genRVB.svg",
  "394": "394genRVB.svg",
  "395": "395genRVB.svg",
  "396": "396genRVB.svg",
  "399": "399genRVB.svg",
  "421": "421genRVB.svg",
  "426": "426genRVB.svg",
  "427": "427genRVB.svg",
  "428": "428genRVB.svg",
  "429": "429genRVB.svg",
  "459": "459genRVB.svg",
  "460": "460genRVB.svg",
  "467": "467genRVB.svg",
  "469": "469genRVB.svg",
  "471": "471genRVB.svg",
  "475": "475genRVB.svg",
  "485": "485genRVB.svg",
  "486": "486genRVB.svg",
  "487": "487-genRVB.svg",
  "488": "488genRVB.svg",
  "492": "492genRVB.svg",
  "495": "495genRVB.svg",
  "496": "496genRVB.svg",
  "499": "499genRVB.svg",
  "501": "501genRVB.svg",
  "506": "506genRVB.svg",
  "512": "512genRVB.svg",
  "513": "513genRVB.svg",
  "515": "515genRVB.svg",
  "518": "518genRVB.svg",
  "519": "519genRVB.svg",
  "520": "520genRVB.svg",
  "524": "524genRVB.svg",
  "526": "526genRVB.svg",
  "528": "528genRVB.svg",
  "537": "537genRVB.svg",
  "538": "538genRVB.svg",
  "542": "542genRVB.svg",
  "545": "545genRVB.svg",
  "546": "546genRVB.svg",
  "551": "551genRVB.svg",
  "556": "556genRVB.svg",
  "559": "559genRVB.svg",
  "560": "560genRVB.svg",
  "562": "562genRVB.svg",
  "563": "563genRVB.svg",
  "564": "564genRVB.svg",
  "565": "565genRVB.svg",
  "566": "566genRVB.svg",
  "569": "569genRVB.svg",
  "571": "571genRVB.svg",
  "572": "572genRVB.svg",
  "573": "573genRVB.svg",
  "576": "576genRVB.svg",
  "577": "577genRVB.svg",
  "578": "578genRVB.svg",
  "579": "579genRVB.svg",
  "580": "580genRVB.svg",
  "581": "581genRVB.svg",
  "582": "582genRVB.svg",
  "583": "583genRVB.svg",
  "585": "585genRVB.svg",
  "587": "587genRVB.svg",
  "592": "592genRVB.svg",
  "593": "593genRVB.svg",
  "594": "594genRVB.svg",
  "595": "595genRVB.svg",
  "601": "601genRVB.svg",
  "602": "602genRVB.svg",
  "603": "603genRVB.svg",
  "604": "604genRVB.svg",
  "605": "605genRVB.svg",
  "606": "606genRVB.svg",
  "607": "607genRVB.svg",
  "609": "609genRVB.svg",
  "610": "610genRVB.svg",
  "611": "611genRVB.svg",
  "613": "613genRVB.svg",
  "615": "615genRVB.svg",
  "616": "616genRVB.svg",
  "617": "617genRVB.svg",
  "618": "618genRVB.svg",
  "619": "619genRVB.svg",
  "620": "620genRVB.svg",
  "623": "623genRVB.svg",
  "627": "627genRVB.svg",
  "637": "637genRVB.svg",
  "640": "640genRVB.svg",
  "641": "641genRVB.svg",
  "642": "642genRVB.svg",
  "644": "644genRVB.svg",
  "645": "645genRVB.svg",
  "690": "690genRVB.svg",
  "900": "900genRVB.svg",
  "901": "901genRVB.svg",
  "902": "902genRVB.svg",
  "903": "903genRVB.svg",
  "208a": "208a-genRVB.svg",
  "208ab": "208ab-genRVB.svg",
  "208abs": "208abs-genRVB.svg",
  "208b": "208b-genRVB.svg",
  "208s": "208s-genRVB.svg",
  "320a": "320agenRVB.svg",
  "320b": "320bgenRVB.svg",
  "340-ocre": "340-ocre-genRVB.svg",
  "340-rose": "340-rose-genRVB.svg",
  "485s": "485sgenRVB.svg",
  "487a": "487a-genRVB.svg",
  "487b": "487b-genRVB.svg",
  "487c": "487c-genRVB.svg",
  "487d": "487d-genRVB.svg",
  "541-Buseolien1": "541-Buseolien1-gen-RVB.svg",
  "541-Buseolien2": "541-Buseolien2-gen-RVB.svg",
  "544-AS-Azur": "544-AS-Azur-genRVB.svg",
  "544-AS-Perv": "544-AS-Perv-genRVB.svg",
  "544-AS-Sap": "544-AS-Sap-genRVB.svg",
  "559a": "559agenRVB.svg",
  "559b": "559bgenRVB.svg",
  "559c": "559cgenRVB.svg",
  "559d": "559dgenRVB.svg",
  "574-TUC-E": "574-TUC-E-genRVB.svg",
  "574-TUC-O": "574-TUC-O-genRVB.svg",
  "580-t-igr": "580-t-igr-genRVB.svg",
  "584-Valouette-V5-perv": "584-Valouette-V5-perv-genRVB.svg",
  "584-Valouette-V5-vert": "584-Valouette-V5-vert-genRVB.svg",
  "586-la colombe-Lilas": "586-la colombe-Lilas-genRVB.svg",
  "586-la colombe-Parme": "586-la colombe-Parme-genRVB.svg",
  "589-Tuvim-a": "589-Tuvim-a-genRVB.svg",
  "589-Tuvim-b": "589-Tuvim-b-genRVB.svg",
  "589-Tuvim-c": "589-Tuvim-c-genRVB.svg",
  "597-l'Hirondelle": "597-l'Hirondelle-genRVB.svg",
  "597-l'Hirondelle-B": "597-l'Hirondelle-B-genRVB.svg",
  "COP21": "COP21genRVB.svg",
  "funiculaire": "funiculaireRVB.svg",
  "M1": "M1genRVB.svg",
  "M10": "M10genRVB.svg",
  "M11": "M11genRVB.svg",
  "M12": "M12genRVB.svg",
  "M13": "M13genRVB.svg",
  "M14": "M14genRVB.svg",
  "M2": "M2genRVB.svg",
  "M3": "M3genRVB.svg",
  "M3bis": "M3bisgenRVB.svg",
  "M4": "M4genRVB.svg",
  "M5": "M5genRVB.svg",
  "M6": "M6genRVB.svg",
  "M7": "M7genRVB.svg",
  "M7bis": "M7bisgenRVB.svg",
  "M8": "M8genRVB.svg",
  "M9": "M9genRVB.svg",
  "NavetteRERA-01": "NavetteRERAgenRVB-01.svg",
  "N01": "Noct-01-genRVB.svg",
  "N02": "Noct-02-genRVB.svg",
  "N11": "Noct-11-genRVB.svg",
  "N12": "Noct-12-genRVB.svg",
  "N122": "Noct-122-genRVB.svg",
  "N13": "Noct-13-genRVB.svg",
  "N130": "Noct-130-genRVB.svg",
  "N131": "Noct-131-genRVB.svg",
  "N132": "Noct-132-genRVB.svg",
  "N133": "Noct-133-genRVB.svg",
  "N134": "Noct-134-genRVB.svg",
  "N135": "Noct-135-genRVB.svg",
  "N14": "Noct-14-genRVB.svg",
  "N140": "Noct-140-genRVB.svg",
  "N141": "Noct-141-genRVB.svg",
  "N142": "Noct-142-genRVB.svg",
  "N143": "Noct-143-genRVB.svg",
  "N144": "Noct-144-genRVB.svg",
  "N145": "Noct-145-genRVB.svg",
  "N15": "Noct-15-genRVB.svg",
  "N150": "Noct-150-genRVB.svg",
  "N151": "Noct-151-genRVB.svg",
  "N152": "Noct-152-genRVB.svg",
  "N153": "Noct-153-genRVB.svg",
  "N154": "Noct-154-genRVB.svg",
  "N16": "Noct-16-genRVB.svg",
  "N21": "Noct-21-genRVB.svg",
  "N22": "Noct-22-genRVB.svg",
  "N23": "Noct-23-genRVB.svg",
  "N24": "Noct-24-genRVB.svg",
  "N31": "Noct-31-genRVB.svg",
  "N32": "Noct-32-genRVB.svg",
  "N33": "Noct-33-genRVB.svg",
  "N34": "Noct-34-genRVB.svg",
  "N35": "Noct-35-genRVB.svg",
  "N41": "Noct-41-genRVB.svg",
  "N42": "Noct-42-genRVB.svg",
  "N43": "Noct-43-genRVB.svg",
  "N44": "Noct-44-genRVB.svg",
  "N45": "Noct-45-genRVB.svg",
  "N51": "Noct-51-genRVB.svg",
  "N52": "Noct-52-genRVB.svg",
  "N53": "Noct-53-genRVB.svg",
  "N61": "Noct-61-genRVB.svg",
  "N62": "Noct-62-genRVB.svg",
  "N63": "Noct-63-genRVB.svg",
  "N66": "Noct-66-genRVB.svg",
  "N71": "Noct-71-genRVB.svg",
  "Orlyval": "OrlyvalRVB.svg",
  "P15": "P15-genRVB.svg",
  "P17-Hourtoule": "P17-Hourtoule-genRVB.svg",
  "P20": "P20-genRVB.svg",
  "P20-MOBICAPS": "P20-MOBICAPS-genRVB.svg",
  "P24": "P24-genRVB.svg",
  "P30": "P30-genRVB.svg",
  "P307": "P307-genRVB.svg",
  "P34": "P34-genRVB.svg",
  "P39,07-SAVAC": "P39,07-SAVAC-genRVB.svg",
  "P40-Phebus": "P40-Phebus-genRVB.svg",
  "P45": "P45-genRVB.svg",
  "P4-MOBICAPS": "P4-MOBICAPS-genRVB.svg",
  "P50": "P50-genRVB.svg",
  "P60": "P60-genRVB.svg",
  "P91,08": "P91,08-genRVB.svg",
  "PCastor": "PCastor-genRVB.svg",
  "RER A": "RERAgenRVB.svg",
  "RER B": "RERBgenRVB.svg",
  "T1": "T1genRVB.svg",
  "T2": "T2genRVB.svg",
  "T3a": "T3a-genRVB.svg",
  "T3b": "T3b-genRVB.svg",
  "T5": "T5genRVB.svg",
  "T6": "T6genRVB.svg",
  "T7": "T7genRVB.svg",
  "T8": "T8genRVB.svg",
  "TVM": "TVMgenRVB.svg",
  "B": "B-flou0-160x160-bleu.svg",
  "T": "T-flou0-160x160-bleu.svg",
  "R": "R-flou0-160x160-bleu.svg",
  "M": "M-flou0-160x160-bleu.svg",
  "Tr": "Tr-flou0-160x160-bleu.svg",
};
