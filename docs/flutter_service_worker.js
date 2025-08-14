'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "282e3211810163eeddaf11d239053ffe",
"version.json": "7e16d4ebb19a0059b34f89f12465db4f",
"index.html": "df78020ef32a5f5f67d013807834f640",
"/": "df78020ef32a5f5f67d013807834f640",
"main.dart.js": "b215848dfabd7c8c10f07c75d1ce1184",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "28984f0be62c9c3c4075634e7fa0019e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "80e3510b6c97ce58fd4e8b9179966228",
"assets/AssetManifest.json": "aa7a75cd81e67c450487a01f6f77d654",
"assets/NOTICES": "8548ffdce8542370ca859b009b6715d6",
"assets/FontManifest.json": "75b75544e50da191cc9afeb53948aa0b",
"assets/AssetManifest.bin.json": "96e5a22c100d9e33aa2b0fb96d9ba959",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "79ac578cd448f4a51433c0c97e989601",
"assets/fonts/MaterialIcons-Regular.otf": "aa9f783500aa58384a93ad080c2fe828",
"assets/assets/riddles/stickmanriddle.png": "e083958526a34859d1d7f090ec624ea8",
"assets/assets/londonmap/londonmap.png": "3686a896d271f957a98d3f75d0dfb7bb",
"assets/assets/londonmap/stationappear/victoria.png": "1227e633badd5e3bf1faf7e460274d7e",
"assets/assets/londonmap/stationappear/leiferikson.png": "4eaa132394b78f9e549a0d381affb2e5",
"assets/assets/londonmap/stationappear/thesilkroad.png": "5476916aeff70439cea23acfb591239b",
"assets/assets/londonmap/stationappear/timbernerslee.png": "994fc9f4f8da7185f6e6df57d16eb9ac",
"assets/assets/londonmap/stationappear/thebombe.png": "3d51828e4365c9fd957ca278652bf6fe",
"assets/assets/londonmap/stationappear/einsteinium.png": "32eea31846df6e95eeaa1c1b973f90f6",
"assets/assets/londonmap/stationappear/henrymortonstanley.png": "14484916437625f17eb643ae20e85b04",
"assets/assets/londonmap/stationappear/newzealand.png": "4afbcd5292f02d40d1956b2414dab09e",
"assets/assets/londonmap/stationappear/poyekhali.png": "281301a1e3d04f665569cb252fb2b0a5",
"assets/assets/londonmap/stationappear/hypatia.png": "8c6fabaefa584203be309159ea1ccafb",
"assets/assets/londonmap/stationappear/santamaria.png": "7ccf24a83ba4dbf4075b3c7f597ffcb5",
"assets/assets/londonmap/stationappear/machupicchu.png": "a2ae7a52f5c6fb5e6af291ba48987a9f",
"assets/assets/londonmap/stationappear/u1497.png": "1d48acbf90bbb98ee1c8f489b8a463da",
"assets/assets/londonmap/stationappear/robertballard.png": "5e074a8b671aa6f9cc790c826acff656",
"assets/assets/londonmap/stationappear/northcarolina.png": "11d42284580f79217c57ef954a59bc08",
"assets/assets/londonmap/stationappear/advancemap.png": "5ca8b40938bffb3ae0f48bf842aca338",
"assets/assets/londonmap/stationappear/jamesphipps.png": "c97bbb672341a7512140773fb9ba68ad",
"assets/assets/londonmap/stationappear/alexandergrahambell.png": "7c195c536ea0e357f482096adcf42d2e",
"assets/assets/londonmap/stationappear/teleport1.png": "f01131634c29c33a0a347aa4f2f55ea5",
"assets/assets/londonmap/stationappear/u42.png": "c37f065460662b8a2ed591db829a768f",
"assets/assets/londonmap/stationappear/teleport2.png": "7324f079cb6e847bfc5dc717137d2b3e",
"assets/assets/londonmap/stationappear/kamchatka.png": "f8c04738f297d4e2b5ef1601885b108a",
"assets/assets/londonmap/stationappear/teleport3.png": "569ab745aa65b4240b8830137a5efeef",
"assets/assets/londonmap/stationappear/brahmasphutasiddhanta.png": "829c75a791760da480e4756ed51b4e6e",
"assets/assets/londonmap/stationappear/themayflower.png": "c0fc884bc60632e235639e83f3b75421",
"assets/assets/londonmap/stationappear/hawaii.png": "055ad6a238455e9c34f5fb5f573edabf",
"assets/assets/londonmap/stationappear/teleport6.png": "3b28cbe633e29c4e477b4f444cba294c",
"assets/assets/londonmap/stationappear/robertfitzroy.png": "0a2eb7c9c4b24fecd4ad443b4659ffe1",
"assets/assets/londonmap/stationappear/start.png": "05f2df2fc2b872b085fb3f83472171ee",
"assets/assets/londonmap/stationappear/teleport4.png": "3327ef8c6a1f0dad528ebf057fc751f7",
"assets/assets/londonmap/stationappear/dmitrimendelev.png": "378778505aa37ba58845fef7091cd17c",
"assets/assets/londonmap/stationappear/teleport5.png": "6c44966781b4472a5878d41afe6365cb",
"assets/assets/londonmap/korttest.svg": "1e0f9c7d9b1006500be59b124c79e8b4",
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
