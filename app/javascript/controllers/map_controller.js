import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="map"
// Code to show map
export default class extends Controller {
    static values = {
        defaultZoom: Number,
        longitude: Number,
        latitude: Number,
    };

    initialize() {
        this.map;
    }

    connect() {
        try {
            this.initialize_map();
            this.add_map_point();
        } catch {
            console.log("Error building map");
        }
    }

    initialize_map() {
        this.map = new ol.Map({
            target: "map",
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.OSM({
                        url: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    }),
                }),
            ],
            view: new ol.View({
                center: ol.proj.fromLonLat([
                    this.longitudeValue,
                    this.latitudeValue,
                ]),
                zoom: this.defaultZoomValue,
            }),
        });
    }

    add_map_point() {
        const vectorLayer = new ol.layer.Vector({
            source: new ol.source.Vector({
                features: [
                    new ol.Feature({
                        geometry: new ol.geom.Point(
                            ol.proj.transform(
                                [
                                    parseFloat(this.longitudeValue),
                                    parseFloat(this.latitudeValue),
                                ],
                                "EPSG:4326",
                                "EPSG:3857",
                            ),
                        ),
                    }),
                ],
            }),
            style: new ol.style.Style({
                image: new ol.style.Icon({
                    anchor: [0.6, 0.8],
                    anchorXUnits: "fraction",
                    anchorYUnits: "fraction",
                    src: "https://upload.wikimedia.org/wikipedia/commons/0/0a/Marker_location.png",
                }),
            }),
        });

        this.map.addLayer(vectorLayer);
    }
}
