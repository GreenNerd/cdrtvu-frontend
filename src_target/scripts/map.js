$(function() {
  var MapCtrl;
  MapCtrl = {
    init: function() {
      var map, marker;
      L.mapbox.accessToken = 'pk.eyJ1IjoiY2RydHZ1IiwiYSI6IjBkNTI1NGJjZjMzN2IwYmRkZWQ0ZDRhNmViMThmN2FjIn0.7RyvkJ19fLl3fIDwWuaAEw';
      map = L.mapbox.map('map', 'cdrtvu.b5429f9b');
      map.scrollWheelZoom.disable();
      map.setView([30.664215, 104.057768], 17);
      marker = L.mapbox.featureLayer({
        type: 'FeatureCollection',
        features: [
          {
            type: 'Feature',
            geometry: {
              type: 'Point',
              coordinates: [104.057768, 30.662915]
            },
            properties: {
              title: "<h3>成都电大直属城中学院</h3>",
              description: "<img style='width: 100%' src='http://7xjkjw.com1.z0.glb.clouddn.com/map-pic.jpg'/>\n<div>四川省成都市东城根上街55号（科技大厦7楼）\n  <a href=\"http://apis.map.qq.com/uri/v1/search?keyword=成都电大直属城中学院，东城根上街55号&region=成都&referer=tengxun\" target='_blank' style='color: hsl(110, 39%, 54%); font-weight: bold;'>导航</a>\n</div><div>400-8611-7088</div>",
              'marker-size': 'large',
              'marker-color': '#a3e46b',
              'marker-symbol': 'college'
            }
          }
        ]
      }).addTo(map);
      return marker.eachLayer(function(m) {
        return m.openPopup();
      });
    }
  };
  if ($('#map').length) {
    return MapCtrl.init();
  }
});
