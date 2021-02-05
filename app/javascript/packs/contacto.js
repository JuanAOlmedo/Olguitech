let map;
const mapDefaultZoom = 16;

function initialize_map() {
    map = new ol.Map({
        target: "map",
        layers: [
            new ol.layer.Tile({
                source: new ol.source.OSM({
                    url: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                }),
            }),
        ],
        view: new ol.View({
            center: ol.proj.fromLonLat([-56.15627, -34.918624]),
            zoom: mapDefaultZoom,
        }),
    });
}

function add_map_point(lat, lng) {
    const vectorLayer = new ol.layer.Vector({
        source: new ol.source.Vector({
            features: [
                new ol.Feature({
                    geometry: new ol.geom.Point(
                        ol.proj.transform(
                            [parseFloat(lng), parseFloat(lat)],
                            "EPSG:4326",
                            "EPSG:3857"
                        )
                    ),
                }),
            ],
        }),
        style: new ol.style.Style({
            image: new ol.style.Icon({
                anchor: [0.6, 0.8],
                anchorXUnits: "fraction",
                anchorYUnits: "fraction",
                src:
                    "https://upload.wikimedia.org/wikipedia/commons/0/0a/Marker_location.png",
            }),
        }),
    });

    map.addLayer(vectorLayer);
}

initialize_map();
add_map_point(-34.918624, -56.15627);
