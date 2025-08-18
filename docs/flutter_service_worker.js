'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "2eed4658e6c4bae4f6547483463147a2",
"version.json": "7e16d4ebb19a0059b34f89f12465db4f",
"index.html": "df78020ef32a5f5f67d013807834f640",
"/": "df78020ef32a5f5f67d013807834f640",
"main.dart.js": "8efb86e98e2036c394a6effa33f21dfe",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "28984f0be62c9c3c4075634e7fa0019e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "80e3510b6c97ce58fd4e8b9179966228",
"assets/AssetManifest.json": "26f5cbc469cea07a5b219c18adf2eae0",
"assets/NOTICES": "336ddb403df8123d0c51a6351ecf5c00",
"assets/FontManifest.json": "75b75544e50da191cc9afeb53948aa0b",
"assets/AssetManifest.bin.json": "49bb4363fb69ef97b92b3c5215a5f0a8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ce314257adeff05c48c8ac05207c3941",
"assets/fonts/MaterialIcons-Regular.otf": "a8b6766916ab150502c915f032c54ef1",
"assets/assets/riddles/stickmanriddle.png": "e083958526a34859d1d7f090ec624ea8",
"assets/assets/londonmap/londonmap.png": "3686a896d271f957a98d3f75d0dfb7bb",
"assets/assets/londonmap/stationappear/eniac.png": "7aa1e6decc20f5c97a4c9159486fed5c",
"assets/assets/londonmap/stationappear/teleport8.png": "89bc703953d1b5ffd89b83c7394fe84a",
"assets/assets/londonmap/stationappear/towerbridge.png": "ade3764e1f7c48f05a23938641b51460",
"assets/assets/londonmap/stationappear/teleport9.png": "59f54872109d1431cbb07cc003d2c103",
"assets/assets/londonmap/stationappear/christina.png": "ed1401862fd16093d540b6917fcf2a7f",
"assets/assets/londonmap/stationappear/borobudurtemple.png": "7a970d200f9129c6a61f2c96d8dea7ec",
"assets/assets/londonmap/stationappear/u4.png": "7943ecb60721d77494a9cee10000b036",
"assets/assets/londonmap/stationappear/teotihuacan.png": "dfde9795e5dd65d8e04aae572f3b5bc2",
"assets/assets/londonmap/stationappear/u6.png": "53c46966b05ac2ad24c13794ff2b793a",
"assets/assets/londonmap/stationappear/hammurabi.png": "3f7a3c2ddd995d39c07ed491d7cfeef1",
"assets/assets/londonmap/stationappear/dolly.png": "13ac6066740a50755f21edc35d7dfa8f",
"assets/assets/londonmap/stationappear/plant.png": "aeffaab7d2a970db15aef553bb7908ac",
"assets/assets/londonmap/stationappear/lamia.png": "1397fd179904c63053efee251fdffa8b",
"assets/assets/londonmap/stationappear/victoria.png": "1227e633badd5e3bf1faf7e460274d7e",
"assets/assets/londonmap/stationappear/napoleon.png": "3d2a0a5902e86c1382fbc4292009d00d",
"assets/assets/londonmap/stationappear/kinglouisxiv.png": "854c5db78c11852ab82ce5972ad9f009",
"assets/assets/londonmap/stationappear/train.png": "1fb497f995c1bcb00b30ba013575b6e4",
"assets/assets/londonmap/stationappear/burgerking.png": "2b4b36f05836b967325f0c44bb40cd3d",
"assets/assets/londonmap/stationappear/leiferikson.png": "4eaa132394b78f9e549a0d381affb2e5",
"assets/assets/londonmap/stationappear/cailleach.png": "543481e4f782ccc320eb01681ffe36b9",
"assets/assets/londonmap/stationappear/u7.png": "26a2780d4b34ac90156d2feaa42ddd78",
"assets/assets/londonmap/stationappear/u3.png": "cec622f9e49bd7c995fbdc2db5387629",
"assets/assets/londonmap/stationappear/nakizumo.png": "ed0ea0f57753566aa322043030e3b572",
"assets/assets/londonmap/stationappear/hatshepsut.png": "3aa186b2a548cf75a4e36754c335a485",
"assets/assets/londonmap/stationappear/prometheus.png": "79ffa78965b3c22126ab8a2c66295909",
"assets/assets/londonmap/stationappear/atlantis.png": "e9fb035e8736efb979c8fbcd9071b9e2",
"assets/assets/londonmap/stationappear/bread.png": "15aeaeb4b6c03499421d0aadef8eaf0e",
"assets/assets/londonmap/stationappear/u2.png": "b7abbb5dfe621658b9e99bca95c8a679",
"assets/assets/londonmap/stationappear/diocletian.png": "50429bf44e68abaadaabec42722f0335",
"assets/assets/londonmap/stationappear/qinshihuang.png": "6f60e47bd0b7a4cf32e12f5c2f62f677",
"assets/assets/londonmap/stationappear/minotaur.png": "a6632081d99aa3db1f27e551ea90e16f",
"assets/assets/londonmap/stationappear/m&ms.png": "2401b247d7d627d34174a27a93dbf042",
"assets/assets/londonmap/stationappear/achilles.png": "34aa71ec42fc24b76eb43f4bd38e4d39",
"assets/assets/londonmap/stationappear/thesilkroad.png": "5476916aeff70439cea23acfb591239b",
"assets/assets/londonmap/stationappear/remis.png": "b43e2e4112ff08a5adc92ebba380fcda",
"assets/assets/londonmap/stationappear/u1.png": "c7baeaf3c6456238ddad682992c2df3f",
"assets/assets/londonmap/stationappear/yurigagarin.png": "29378e60cbf8bd0aac0c2f203d1654d5",
"assets/assets/londonmap/stationappear/sirimavobandaranaike.png": "52425b83cd3e1e6a827f609f5b7d9fa7",
"assets/assets/londonmap/stationappear/teleport10.png": "92c7e42e2f8341f2ed9c120d9885ce5a",
"assets/assets/londonmap/stationappear/selkie.png": "1704330ca625fe2ecb57ce96d1ae38af",
"assets/assets/londonmap/stationappear/fenrir.png": "224c538e5bdd69fb7736f6c8112b505b",
"assets/assets/londonmap/stationappear/genghiskhan.png": "e799f99f89e574934f29375406ae3205",
"assets/assets/londonmap/stationappear/kingkamehameha.png": "59dcf79fbe847ccff29b63c400bc1794",
"assets/assets/londonmap/stationappear/chupacabra.png": "493be5cdfcbcab9b9bef124cc2031b6b",
"assets/assets/londonmap/stationappear/timbernerslee.png": "994fc9f4f8da7185f6e6df57d16eb9ac",
"assets/assets/londonmap/stationappear/goldengatebridge.png": "5d902a0970398004b9836fdbf8a940cc",
"assets/assets/londonmap/stationappear/skittles.png": "49bc6fef4d2de20e8f4dc112f0acc36e",
"assets/assets/londonmap/stationappear/shahjahan.png": "3f88137950bdec99ddd7561a50dbda1c",
"assets/assets/londonmap/stationappear/thebombe.png": "3d51828e4365c9fd957ca278652bf6fe",
"assets/assets/londonmap/stationappear/ibm.png": "800be4efb9734191b9636376dcc55b94",
"assets/assets/londonmap/stationappear/honey.png": "3becc37fd4d5a71435cd767efdc7eb7e",
"assets/assets/londonmap/stationappear/kitkat.png": "bc07fb30f39cb387cba75e3d79928246",
"assets/assets/londonmap/stationappear/einsteinium.png": "32eea31846df6e95eeaa1c1b973f90f6",
"assets/assets/londonmap/stationappear/excalibur.png": "18fb608f5d8e55fecd38c08630c3eb0f",
"assets/assets/londonmap/stationappear/henrymortonstanley.png": "14484916437625f17eb643ae20e85b04",
"assets/assets/londonmap/stationappear/newzealand.png": "4afbcd5292f02d40d1956b2414dab09e",
"assets/assets/londonmap/stationappear/mariecurie.png": "399eb0044c010546b30570422cbe68d1",
"assets/assets/londonmap/stationappear/poyekhali.png": "281301a1e3d04f665569cb252fb2b0a5",
"assets/assets/londonmap/stationappear/persepolis.png": "4f79ac73511b879cb534a9fa4084541a",
"assets/assets/londonmap/stationappear/vigor.png": "294995c7036bf4bb7499e52e820d7604",
"assets/assets/londonmap/stationappear/infocernch.png": "6635b51ce023bb0bad288e9835b92452",
"assets/assets/londonmap/stationappear/doublegloucester.png": "55e1e8dffbb55ee4e98009cd7cc4b0e6",
"assets/assets/londonmap/stationappear/go%25CC%2588beklitepe.png": "a9c097228fb1afa9dbda67fb9204e69d",
"assets/assets/londonmap/stationappear/nissin.png": "a0fe229c499ebc46af6e144196fe834f",
"assets/assets/londonmap/stationappear/hypatia.png": "8c6fabaefa584203be309159ea1ccafb",
"assets/assets/londonmap/stationappear/light.png": "f71fcd292f0bc17187bf305a13f9d375",
"assets/assets/londonmap/stationappear/santamaria.png": "7ccf24a83ba4dbf4075b3c7f597ffcb5",
"assets/assets/londonmap/stationappear/pegasus.png": "55f67a7bb94e1404a90aa60d7bc7a783",
"assets/assets/londonmap/stationappear/stone.png": "3e174f566a95167815d26e53b471ff27",
"assets/assets/londonmap/stationappear/atahualpa.png": "2636b0700f146db79f1dc07333ca76ca",
"assets/assets/londonmap/stationappear/machupicchu.png": "a2ae7a52f5c6fb5e6af291ba48987a9f",
"assets/assets/londonmap/stationappear/u1497.png": "1d48acbf90bbb98ee1c8f489b8a463da",
"assets/assets/londonmap/stationappear/anansi.png": "5032bf0698d4f2337b73bd63dd6403a8",
"assets/assets/londonmap/stationappear/scylla.png": "f3bd1dc6c455665531bc0d5c1ad2fd71",
"assets/assets/londonmap/stationappear/prize.png": "5c367091d42c4942ede5912a49cb0ccd",
"assets/assets/londonmap/stationappear/mjolnir.png": "8a49923edf624e94c5feb8236616675d",
"assets/assets/londonmap/stationappear/anvil.png": "ca868a97b5e54572e2bbc6e677d86bd9",
"assets/assets/londonmap/stationappear/robertballard.png": "5e074a8b671aa6f9cc790c826acff656",
"assets/assets/londonmap/stationappear/shahismail.png": "2e9874655d8caefa91ad3f9c3371df62",
"assets/assets/londonmap/stationappear/petra.png": "23af7382b8a83bb1e3bbeb063603e6c3",
"assets/assets/londonmap/stationappear/cuneiform.png": "3908d960563962088d699a84bd9c4fc9",
"assets/assets/londonmap/stationappear/babayaga.png": "09d0281507f473f4e2e33021a073a3bc",
"assets/assets/londonmap/stationappear/northcarolina.png": "11d42284580f79217c57ef954a59bc08",
"assets/assets/londonmap/stationappear/meatthezoo.png": "58e0aed58d95cf0ae394973caf721505",
"assets/assets/londonmap/stationappear/medusa.png": "00071e88d2ce359ee34abc06b8a03ef5",
"assets/assets/londonmap/stationappear/camahueto.png": "73a7ff63d655380eab621b8ae1241672",
"assets/assets/londonmap/stationappear/brooklynbridge.png": "2e152e35b265477debc7b1ec66f217ed",
"assets/assets/londonmap/stationappear/alexanderthegreat.png": "d7ab48d4e0cb7004783c461afa610aa4",
"assets/assets/londonmap/stationappear/srilanka.png": "5d75979318d34b9376f3f4b8e6af1f9e",
"assets/assets/londonmap/stationappear/advancemap.png": "5ca8b40938bffb3ae0f48bf842aca338",
"assets/assets/londonmap/stationappear/might.png": "3bb82af8ac654909c50ca255cab12814",
"assets/assets/londonmap/stationappear/cocaleaves.png": "b4b5e4ff2dca935a5be47f2f88858900",
"assets/assets/londonmap/stationappear/charlesbridge.png": "c7ede7e1bc4e9fcfb4902acc6231c267",
"assets/assets/londonmap/stationappear/mehmedii.png": "b5c845f519943a44e30318e182c27f18",
"assets/assets/londonmap/stationappear/jamesphipps.png": "c97bbb672341a7512140773fb9ba68ad",
"assets/assets/londonmap/stationappear/khufu.png": "f9b2e2b3ebd2fae2fef48e5329ccb6fc",
"assets/assets/londonmap/stationappear/alexandergrahambell.png": "7c195c536ea0e357f482096adcf42d2e",
"assets/assets/londonmap/stationappear/dinersclub.png": "6da4e2514b3f57ad911a7a75fb8ba142",
"assets/assets/londonmap/stationappear/hirohito.png": "fdabed2e0e16b88c05aa1abbbc63c39a",
"assets/assets/londonmap/stationappear/mansamusa.png": "7f98c7996e42c48e0d0f8d14331246b7",
"assets/assets/londonmap/stationappear/teleport1.png": "f01131634c29c33a0a347aa4f2f55ea5",
"assets/assets/londonmap/stationappear/avalon.png": "419b71b00488baaf351e952f1f3c7542",
"assets/assets/londonmap/stationappear/shakazulu.png": "dae92cb656b44daede823049b62ec162",
"assets/assets/londonmap/stationappear/u42.png": "c37f065460662b8a2ed591db829a768f",
"assets/assets/londonmap/stationappear/djenne%25CC%2581.png": "43207c29cdc0ec1508db65c505b5b4c5",
"assets/assets/londonmap/stationappear/huginandmunin.png": "55b690ce825343d4ca1ba255ed9c9f9f",
"assets/assets/londonmap/stationappear/pompeii.png": "7e79b81a351f1d9c1fe677fecb18aa99",
"assets/assets/londonmap/stationappear/creeper.png": "afe3aaef35d1a9d762cc333c17d7e45c",
"assets/assets/londonmap/stationappear/thejazzsinger.png": "0487cb61f0dcc7e36c8b7b4b39d19484",
"assets/assets/londonmap/stationappear/teleport2.png": "7324f079cb6e847bfc5dc717137d2b3e",
"assets/assets/londonmap/stationappear/glass.png": "1a9e96ee3c87f938d0750c6160c34589",
"assets/assets/londonmap/stationappear/brave.png": "918d582d2ce1d4d4fec505abd3d054a9",
"assets/assets/londonmap/stationappear/kamchatka.png": "f8c04738f297d4e2b5ef1601885b108a",
"assets/assets/londonmap/stationappear/xerxes.png": "4828888e486babe16a521219611ad94a",
"assets/assets/londonmap/stationappear/teleport3.png": "569ab745aa65b4240b8830137a5efeef",
"assets/assets/londonmap/stationappear/charlemagne.png": "401c6b0fc72b74364e694b1198cfc559",
"assets/assets/londonmap/stationappear/thingvellir.png": "ab0acfa0433e85587403b35372ba0ec9",
"assets/assets/londonmap/stationappear/ingahildgrathmer.png": "4e95fe5e31386c3dbcbb945e79b94783",
"assets/assets/londonmap/stationappear/banshee.png": "9871f7e8a93e9d5411883dd49e8d440c",
"assets/assets/londonmap/stationappear/laika.png": "68ef71897070120da3144c6d5450e0eb",
"assets/assets/londonmap/stationappear/brahmasphutasiddhanta.png": "829c75a791760da480e4756ed51b4e6e",
"assets/assets/londonmap/stationappear/theodosius.png": "5922b377f2ee255b5c111627feac3032",
"assets/assets/londonmap/stationappear/kinghenryviii.png": "2f78086ea34ed30ce595f5772186a05b",
"assets/assets/londonmap/stationappear/teleport7.png": "75c02e02aa80ca7294eedb76fb91e20e",
"assets/assets/londonmap/stationappear/themayflower.png": "c0fc884bc60632e235639e83f3b75421",
"assets/assets/londonmap/stationappear/hawaii.png": "055ad6a238455e9c34f5fb5f573edabf",
"assets/assets/londonmap/stationappear/teleport6.png": "3b28cbe633e29c4e477b4f444cba294c",
"assets/assets/londonmap/stationappear/robertfitzroy.png": "0a2eb7c9c4b24fecd4ad443b4659ffe1",
"assets/assets/londonmap/stationappear/crown.png": "9e150793467d0ad26a6b627d09dd6637",
"assets/assets/londonmap/stationappear/radish.png": "66810e3bae83428b5e07fcc4cdb355c8",
"assets/assets/londonmap/stationappear/u9.png": "4decf65fb2d877ff7a840d93ad30c8ea",
"assets/assets/londonmap/stationappear/start.png": "05f2df2fc2b872b085fb3f83472171ee",
"assets/assets/londonmap/stationappear/ham.png": "15a5e0c1c31442b30f92ef1aac5437de",
"assets/assets/londonmap/stationappear/phoenix.png": "b49132fb93b4728a5f680c6e88b77b4f",
"assets/assets/londonmap/stationappear/teleport4.png": "3327ef8c6a1f0dad528ebf057fc751f7",
"assets/assets/londonmap/stationappear/dmitrimendelev.png": "378778505aa37ba58845fef7091cd17c",
"assets/assets/londonmap/stationappear/gustavusadolphus.png": "1b8e0925545e5c55b54286fec931207b",
"assets/assets/londonmap/stationappear/teleport5.png": "6c44966781b4472a5878d41afe6365cb",
"assets/assets/londonmap/stationappear/roaldamundsen.png": "ebd18ab65787a78d47ed01f98f4b3f68",
"assets/assets/londonmap/stationappear/ashoka.png": "6d65f3130a97753279c5090f2ce7f47c",
"assets/assets/londonmap/stationappear/brownie.png": "d1ba2c5ede6ba8fb2973d16e158adb07",
"assets/assets/londonmap/stationappear/qwertyuiop.png": "8da86583403f685c81c1c0fda95f4666",
"assets/assets/londonmap/stationappear/u8.png": "03616be1bcf53b8888c91b028d6b5aa8",
"assets/assets/londonmap/stationappear/cerberus.png": "e3604358aafa45238b64682b1fcc953d",
"assets/assets/londonmap/korttest.svg": "bfe1220516c20dc9e24a2dd5b07d3bcd",
"assets/assets/londonmap/masks/maskmjolnir.svg": "dfeb2ecf1a4ae74d32329d8cdd27f2d4",
"assets/assets/londonmap/masks/maskvigor.svg": "ea2e7d93231db85a1fdbffb836766ee6",
"assets/assets/londonmap/masks/maskavalon.svg": "1768a181fa8ba6e11c70b94f9818fd0a",
"assets/assets/londonmap/masks/masksantamaria.svg": "e1b6cc7073275643892c4020a73c0246",
"assets/assets/londonmap/masks/maskpoyekhali.svg": "ea811e6a96b44b61696aaa100c3847fd",
"assets/assets/londonmap/masks/masksirimavobandaranaike.svg": "013df46014569f333cecc5f0be8abde9",
"assets/assets/londonmap/masks/doublegloucester.svg": "14fdb46948a12e45a733090261557a94",
"assets/assets/londonmap/masks/maskexcalibur.svg": "e55ba79717310b5aafaff1104386cf85",
"assets/assets/londonmap/masks/maskm&ms.svg": "35b0958d7a42d18207a5e50668b269bd",
"assets/assets/londonmap/masks/maskthemayflower.svg": "a5bd40816b354d2613305abdc619f1bf",
"assets/assets/londonmap/masks/maskpegasus.svg": "b2d562d15899b0eb14d03d3943b7c25f",
"assets/assets/londonmap/masks/maskhypatia.svg": "a23350a0a0c80d996fcf9dca929876b9",
"assets/assets/londonmap/masks/maskxerxes.svg": "2e3ce6381cc9c3e3d719d0a3fb122383",
"assets/assets/londonmap/masks/maskdoublegloucester.svg": "14fdb46948a12e45a733090261557a94",
"assets/assets/londonmap/masks/maskshahismail.svg": "d375487e648c0697e2630128f9a7fdba",
"assets/assets/londonmap/masks/maskhoney.svg": "aabaa0a0e03563839b75cb7045562123",
"assets/assets/londonmap/masks/masksrilanka.svg": "62aee528e3ed5d1dbca833987a31563c",
"assets/assets/londonmap/masks/maskthingvellir.svg": "ea4b60b0fd6c198c5f143ae54f26748a",
"assets/assets/londonmap/masks/maskcharlemagne.svg": "1acc51f9ff71b29a2126d41cea704f38",
"assets/assets/londonmap/masks/maskgobeklitepe.svg": "2d9915f7ff41b658ca750fc2328fe793",
"assets/assets/londonmap/masks/maskmehmedii.svg": "ba63f15b777080947d739c9ac5b932df",
"assets/assets/londonmap/masks/maskradish.svg": "64b97120c3550b0575d3fbca9a0c3386",
"assets/assets/londonmap/masks/maskmeatthezoo.svg": "26928b09aa28e1debe102aae5e22f81d",
"assets/assets/londonmap/masks/maskhawaii.svg": "5e62d93d4b8a2d603513ec95b22f66f2",
"assets/assets/londonmap/masks/maskbabayaga.svg": "dc1e9baf2b4084a6c91180125d176965",
"assets/assets/londonmap/masks/maskgoldengatebridge.svg": "b7c062545268d4f282cf8557f94ac3a9",
"assets/assets/londonmap/masks/maskcocaleaves.svg": "28820ab5b3d1e22cedaca6d6df4bcb36",
"assets/assets/londonmap/masks/maskshahjahan.svg": "1e9059b81415358224d4ddc079c2a393",
"assets/assets/londonmap/masks/maskhenrymortonstanley.svg": "7f82dcbb507fc899eabca882616dc485",
"assets/assets/londonmap/masks/masktimbernerslee.svg": "e9b18f6d141a313c0adf2459af6ee378",
"assets/assets/londonmap/masks/maskjamesphipps.svg": "19f8e3b86a33a777bb7bda92ecb842bd",
"assets/assets/londonmap/masks/maskashoka.svg": "84ea9d2b28aaa1d8992bbebb22d839c1",
"assets/assets/londonmap/masks/maskdinersclub.svg": "e878a45322007cb7361ea8c05fea062c",
"assets/assets/londonmap/masks/maskham.svg": "15bc79f1c1bd65c534b212ea0ecba5e9",
"assets/assets/londonmap/masks/maskssvg.svg": "d0d9cbe1ec22ac8d7a379f0c6169530b",
"assets/assets/londonmap/masks/maskbanshee.svg": "88bd8bab1e9de39601fd35faf565a6d4",
"assets/assets/londonmap/masks/maskkingkamehameha.svg": "1444ba4794d65c9fa5a6f8fccf810b83",
"assets/assets/londonmap/masks/maskcreeper.svg": "31b16da3d89430539db831c2462b42ca",
"assets/assets/londonmap/masks/maskdjenne.svg": "c6e98397643f690b409c76f9a12f1f46",
"assets/assets/londonmap/masks/maskhirohito.svg": "27147f36ae539627f72d3ea490406152",
"assets/assets/londonmap/masks/maskpompeii.svg": "eea221b94f6f50b2c9584596f88de8aa",
"assets/assets/londonmap/masks/maskscylla.svg": "320e69e719925647806d7889c9dba795",
"assets/assets/londonmap/masks/maskanansi.svg": "f690f646dba6a94888147ca26c85d8a4",
"assets/assets/londonmap/masks/maskbread.svg": "4f20e7bec322679f83927bed5301df87",
"assets/assets/londonmap/masks/lalaal.svg": "bfe1220516c20dc9e24a2dd5b07d3bcd",
"assets/assets/londonmap/masks/maskteleport9.svg": "d935598c3274873cecdbc092b96ee7fc",
"assets/assets/londonmap/masks/masku8.svg": "e629cc8371a28c0e9739ad77e00b8bef",
"assets/assets/londonmap/masks/maskdolly.svg": "684a09d207e409f2cab3153ba27988a2",
"assets/assets/londonmap/masks/maskplant.svg": "aa3c6aaa223d095de214d7722fd49984",
"assets/assets/londonmap/masks/maskbrownie.svg": "5b610c8e5c4711cb119e70dce9e7439e",
"assets/assets/londonmap/masks/masklamia.svg": "632b57d7a2290367db38da77a5865eb5",
"assets/assets/londonmap/masks/maskchristina.svg": "c9534b05f725e2573135e8ff631cd176",
"assets/assets/londonmap/masks/masktheodosius.svg": "072b064c3fecfbdde9d3d464e1d6cf11",
"assets/assets/londonmap/masks/maskalexanderthegreat.svg": "817079ade3cbc35b5eaca0e42ecc0c88",
"assets/assets/londonmap/masks/maskmedusa.svg": "81e7f4cfec2a52ac4fc6ef77f577945e",
"assets/assets/londonmap/masks/maskcerberus.svg": "fcb90dc0ea31404cae190b5b1a27746a",
"assets/assets/londonmap/masks/masku9.svg": "f49f8a330cd0c64e5959a0f94182ec5f",
"assets/assets/londonmap/masks/maskphoenix.svg": "ef7616ba51fbfb6415100a34bee4ea7a",
"assets/assets/londonmap/masks/masktrain.svg": "a4af4da19d102cb2066c8b56e6178d3c",
"assets/assets/londonmap/masks/maskteleport8.svg": "66a3c85511c0652f8281a4573b4658ac",
"assets/assets/londonmap/masks/maskmachupicchu.svg": "e89afc7c3dc8821861df94c760031e02",
"assets/assets/londonmap/masks/maskcailleach.svg": "a687251a996d67de8717becd546b209e",
"assets/assets/londonmap/masks/maskeniac.svg": "c4344b2f4967b664bb7ad232a9b711f3",
"assets/assets/londonmap/masks/maskqwertyuiop.svg": "62f932ef7ed6bef769fe57de490b7eea",
"assets/assets/londonmap/masks/maskhammurabi.svg": "50c501124079cb782382abb05ba38e58",
"assets/assets/londonmap/masks/maskalexandergrahambell.svg": "eddf80a14eebbe9c435b92d94cc8f06b",
"assets/assets/londonmap/masks/masku42.svg": "4e3ba6781de63f9c37d15503f2dda938",
"assets/assets/londonmap/masks/maskvictoria.svg": "4ab3b17db2b1b6a7888dea02917aa3c7",
"assets/assets/londonmap/masks/maskteleport6.svg": "b48fcb5079b24b933695646d57f845ca",
"assets/assets/londonmap/masks/masknapoleon.svg": "9207a758e4c0ee5d1a08d993f45216f1",
"assets/assets/londonmap/masks/maskrobertfitzroy.svg": "9836b50c813b498a439595f17a0c89eb",
"assets/assets/londonmap/masks/maskfenrir.svg": "c853013afda50bec36b2b15a809984b8",
"assets/assets/londonmap/masks/masku7.svg": "06583a0c82179667c80ecea8bb112e24",
"assets/assets/londonmap/masks/maskstart.svg": "ae3cdd796ba04c584484d5ac06e44d75",
"assets/assets/londonmap/masks/maskselkie.svg": "01e004dd3fe0715893cfdb721f1fca9a",
"assets/assets/londonmap/masks/masku6.svg": "0b7deae6613c177b63a9994099776e81",
"assets/assets/londonmap/masks/maskkinghenryviii.svg": "160d92eefcbae1538aafbcd887d8152f",
"assets/assets/londonmap/masks/maskteleport7.svg": "b52639ffd7242aa437d30bac2f84316c",
"assets/assets/londonmap/masks/maskteleport5.svg": "aa6af298c641306336b3049086e749c9",
"assets/assets/londonmap/masks/maskroaldamundsen.svg": "d20fd3efd03e0fcdda0c03b395688240",
"assets/assets/londonmap/masks/masku4.svg": "3689e7e0ec97221d1b81e89228bd8f02",
"assets/assets/londonmap/masks/maskkitkat.svg": "e1d53fcf4b308da3c3960c0bc00f6bd6",
"assets/assets/londonmap/masks/maskgustavusadolphus.svg": "182eaacfbf471a78d0ed49fd05a2facd",
"assets/assets/londonmap/masks/masklaika.svg": "c93290b81db81007b976ae8d7430dabf",
"assets/assets/londonmap/masks/maskburgerking.svg": "3cacf6735f1f092dde228c89141eb5e6",
"assets/assets/londonmap/masks/maskcrown.svg": "e770be60d13480a5efea8784869a34fd",
"assets/assets/londonmap/masks/masku5.svg": "a12f0cea458107134dde3f0a4d559041",
"assets/assets/londonmap/masks/maskteleport4.svg": "02e516246b9fad7de11c7f44d407c16e",
"assets/assets/londonmap/masks/maskshakazulu.svg": "4d81f4d6ec234b2d49e9dd1a2715a251",
"assets/assets/londonmap/masks/maskhuginandmunin.svg": "bd60dac7bf4877459fda3b5abfb4b342",
"assets/assets/londonmap/masks/maskachilles.svg": "edcb695908a4162deacc7378a6d53214",
"assets/assets/londonmap/masks/masku1.svg": "72d4f7d14cf384d7db0ac74c12c0ac04",
"assets/assets/londonmap/masks/maskeinsteinium.svg": "dbdf3b7f3fb613411b91ffe5df5c6465",
"assets/assets/londonmap/masks/maskprometheus.svg": "1c7d113d3e17cbe63bd7ee81b934ea0b",
"assets/assets/londonmap/masks/maskhatshepsut.svg": "f2d86ab0fb0f1262f71c6a0e1c80bd19",
"assets/assets/londonmap/masks/maskminotaur.svg": "5ec0f1b4712f71e6cf063f223aaddda5",
"assets/assets/londonmap/masks/maskmansamusa.svg": "cae4fe6e44d35e03772a5abff15173e7",
"assets/assets/londonmap/masks/maskglass.svg": "61be63c1271c3b22e1e5224831fedfa0",
"assets/assets/londonmap/masks/maskbrave.svg": "fb9136443b137db13055eaccf7b21cd8",
"assets/assets/londonmap/masks/maskdiocletian.svg": "b38a404efecaee7555333eb44472ba06",
"assets/assets/londonmap/masks/maskteleport1.svg": "dd25ff53442e0a77eae0c8d957d64f32",
"assets/assets/londonmap/masks/maskkamchatka.svg": "4589f48527d0c38f776c212b47291095",
"assets/assets/londonmap/masks/maskteleport3.svg": "45428a9c100567c1b7c601f3e17f6cf8",
"assets/assets/londonmap/masks/masku2.svg": "a56c437844a53a08d213d20f182755e8",
"assets/assets/londonmap/masks/maskingahildgrathmer.svg": "eb697933c6d3480d861ea1138d3e4bfa",
"assets/assets/londonmap/masks/maskbrooklynbridge.svg": "d5c004b9fa245a857afc2ca2bc846556",
"assets/assets/londonmap/masks/masknakizumo.svg": "15873cd5ba4ab0fd690728b3e8ed9d74",
"assets/assets/londonmap/masks/maskbrahmasphutasiddhanta.svg": "f4b898081e0ac7e7a5224d155657b3d6",
"assets/assets/londonmap/masks/maskkhufu.svg": "574c5426fa56335ba22abaf169880454",
"assets/assets/londonmap/masks/masknissin.svg": "1b670cb3ec2c4326aa1f246588e82fec",
"assets/assets/londonmap/masks/maskatlantis.svg": "95a519844546da09321a9c0e013be368",
"assets/assets/londonmap/masks/maskgenghiskhan.svg": "fb362547ebbd7fa21f6d04921b074fbe",
"assets/assets/londonmap/masks/masku3.svg": "840109c0790efbb34c2fd73a9305e972",
"assets/assets/londonmap/masks/maskyurigagarin.svg": "54010fa006779c0b3116a39f74e0c9b5",
"assets/assets/londonmap/masks/maskthejazzsinger.svg": "c634d1968cd447069ef56d7fe735e21f",
"assets/assets/londonmap/masks/maskteleport2.svg": "1dc6bfebc2acece854f77efd2de7801c",
"assets/assets/londonmap/masks/maskmight.svg": "4ec95c434106bbf1f336944d676d3eac",
"assets/assets/londonmap/masks/maskteleport10.svg": "832060fd964b4983e048450d6c2f2c87",
"assets/assets/londonmap/masks/maskthesilkroad.svg": "4fe296e079260120997c8da2f98b7d42",
"assets/assets/londonmap/masks/maskskittles.svg": "37f3ebd7cd729e91ebb7e2b8e6205286",
"assets/assets/londonmap/masks/maskthebombe.svg": "9162a12195bb731f737f43ef9df09709",
"assets/assets/londonmap/masks/maskcuneiform.svg": "16b48cc3f7c32c431fad4713185bd87f",
"assets/assets/londonmap/masks/masknorthcarolina.svg": "a04f8659ee030b0ae66bc6348eb485a9",
"assets/assets/londonmap/masks/maskqinshihuang.svg": "4dd98d42a27e1542dec8ae469f109da6",
"assets/assets/londonmap/masks/maskchupacabra.svg": "6a93bd2ec79e96a4e08436b8e875f64b",
"assets/assets/londonmap/masks/maskpetra.svg": "d72bfe8e83deeae6edda05071dd67e55",
"assets/assets/londonmap/masks/maskcharlesbridge.svg": "6446d1412168b14ad4787442de6b415f",
"assets/assets/londonmap/masks/maskcamahueto.svg": "09ece0433b5f2b8e48fb8778e2cd4861",
"assets/assets/londonmap/masks/maskborobudurtemple.svg": "085587548f85a32d8c3ce09c020ee596",
"assets/assets/londonmap/masks/maskprize.svg": "b0e48754d0db4541e09901b6bcbe340f",
"assets/assets/londonmap/masks/maskibm.svg": "c3f34911e4298313486be1b0162ddec9",
"assets/assets/londonmap/masks/maskleiferikson.svg": "8a9aa29bfef00f7a0d4db19b7d6cc109",
"assets/assets/londonmap/masks/maskatahualpa.svg": "25cc4be9d0a30155dbf69bfb633d480b",
"assets/assets/londonmap/masks/masklama.svg": "632b57d7a2290367db38da77a5865eb5",
"assets/assets/londonmap/masks/maskanvil.svg": "fdaa93e60f42d08d26115b7a9f5376ec",
"assets/assets/londonmap/masks/masknewzealand.svg": "ab830af924338869d707ada343ff349b",
"assets/assets/londonmap/masks/maskkinglouisxiv.svg": "3b9ca4e8e862e7a472c353c2e7af5b95",
"assets/assets/londonmap/masks/maskreims.svg": "3a8bcfcc38706419374569988fbfee66",
"assets/assets/londonmap/masks/maskteotihuacan.svg": "7b2c9ade6dde2f7f0d9c9cb8fbb472c3",
"assets/assets/londonmap/masks/maskmariecurie.svg": "fe5c227fcc3e177530403e5c6072a712",
"assets/assets/londonmap/masks/maskdmitrimendelev.svg": "d1a10255444af3007bfdf8f70c0609e0",
"assets/assets/londonmap/masks/maskpersepolis.svg": "64793ddbbf0e51cfc0d25e5e824ed5aa",
"assets/assets/londonmap/masks/mapsbrooklynbridge.svg": "d5c004b9fa245a857afc2ca2bc846556",
"assets/assets/londonmap/masks/masklight.svg": "eee94e89e4880c3b033bea9a00febfc7",
"assets/assets/londonmap/masks/maskinfocernch.svg": "6f8579f0a67299aa55895b3cb4a1d740",
"assets/assets/londonmap/masks/maskrobertballard.svg": "ffc616ad0169817376ceb024e08e9754",
"assets/assets/londonmap/masks/masktowerbridge.svg": "071d9ab8eceed08481602bda4c57f313",
"assets/assets/londonmap/masks/maskstone.svg": "785093d5a3de9844624f9b9ccfd4b1d9",
"assets/assets/londonmap/masks/masku1497.svg": "bcf93008e627cac9051cb77b4299d8a4",
"assets/assets/trophies/enigma.png": "a8e2f5cdef62ecdc6a3ec132b80a02d5",
"assets/assets/trophies/thebeginning.png": "803280e0bae31feaa209a4945dd458bc",
"assets/assets/trophies/letterriddle.png": "4900fda1f8dbae04115ec95ed37d73f5",
"assets/assets/trophies/labyrinth.png": "ecbdc5b45db2a7dccbd0a2dc2cf1527b",
"assets/assets/trophies/towerofhanoi10.png": "f1c5c9bb71bc637407492e9e7a00c11b",
"assets/assets/trophies/fibonacci.png": "ef1a266d5c4a844370c59e1aac196cec",
"assets/assets/trophies/towerofhanoi.png": "83b4ba55359c1aa2d853fc4b40ad9c8d",
"assets/assets/trophies/invisible.png": "944f43481138cb90c22defbae14374ec",
"assets/assets/trophies/themom.png": "6a5fae914dc1d2f96391a2c3beb33e0c",
"assets/assets/trophies/compass.png": "3a3f3ea377470d3cf356f0070fec3cad",
"assets/assets/trophies/loggedin.png": "9ba707e0e27e1b4cebaa52b847896e8a",
"assets/assets/trophies/theexpedition.png": "c5d45f685d46e8bb8cb12bdf66417bb1",
"assets/assets/trophies/staircase.png": "7284b38193b5801b0636220009e91639",
"assets/assets/trophies/stickmanriddle.png": "b30e65454012500c39f3f7b890df2783",
"assets/assets/trophies/genius.png": "0260d4baeb0ab1eb5c0ef95d55c30fb3",
"assets/assets/trophies/20sticksgame.png": "b9b35af9d0030476e4e0520d00ccf600",
"assets/assets/trophies/theeasyone.png": "a4d36f025de5ef230f109d83cdfbde3b",
"assets/assets/fonts/Digital-7.ttf": "c924522e16a8265f257d56ae2a3b19cf",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
