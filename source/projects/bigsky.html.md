---
title: Big Sky
---

# Big Sky

[Big Sky](https://bigsky.io) is a platform to help anyone easily report and share their geographic data. You can bring your own custom data or use an integration such as Google Analytics or Facebook to create useful and beautiful reports.

<div class="mobile landscape"><iframe src="//bigsky.io/maps/503f45d" frameborder="0"></iframe></div>

The examples on this page make use of open data from the QLD Government.

<div class="tablet landscape"><iframe src="//bigsky.io/maps/fa9156e5b9694d1cd9bbe55fe3b7ef19" frameborder="0"></iframe></div>

Find out more at [bigsky.io](https://bigsky.io)

<style>

  @media print {
    .map { display: none; }
  }

  .map {
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1;
    pointer-events: none;
    opacity: .15;
    height: 100vh !important;
    overflow: hidden;
  }

  .map:after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 50vh !important;
    z-index: 0;
    background: -webkit-linear-gradient(rgba(255,255,255, 0), white);
    background: linear-gradient(rgba(255,255,255, 0), white);
  }

  .layer {
    position: absolute;
  }

  .tile {
    position: absolute;
    width: 256px;
    height: 256px;
  }

  .tile path {
    fill: none;
    stroke: #000;
    stroke-linejoin: round;
    stroke-linecap: round;
  }

  .tile .major_road { stroke: #777; }
  .tile .minor_road { stroke: #ccc; }
  .tile .highway { stroke: #222; stroke-width: 1.5px; }
  .tile .rail { stroke: #666; stroke-dasharray: 15, 10, 5; }

</style>

<script src="http://d3js.org/d3.v3.min.js"></script>
<script src="http://d3js.org/d3.geo.tile.v0.min.js"></script>
<script>
  var width = window.innerWidth,
      height = window.innerHeight,
      prefix = prefixMatch(["webkit", "ms", "Moz", "O"]);

  var tile = d3.geo.tile()
      .size([width, height]);

  var projection = d3.geo.mercator()
      .scale((1 << 21) / 2 / Math.PI)
      .translate([-width / 2, -height / 2]); // just temporary

  var tileProjection = d3.geo.mercator();

  var tilePath = d3.geo.path()
      .projection(tileProjection);

  var zoom = d3.behavior.zoom()
      .scale(projection.scale() * 2 * Math.PI)
      .scaleExtent([1 << 20, 1 << 23])
      .translate(projection([153.0234, -27.4685]).map(function(x) { return -x; }))
      .on("zoom", zoomed);

  var map = d3.select("body").append("div")
      .attr("class", "map")
      .style("width", width + "px")
      .style("height", height + "px")
      .call(zoom)
      .on("mousemove", mousemoved);

  var layer = map.append("div")
      .attr("class", "layer");

  var info = map.append("div")
      .attr("class", "info");

  zoomed();

  function zoomed() {
    var tiles = tile
        .scale(zoom.scale())
        .translate(zoom.translate())
        ();

    projection
        .scale(zoom.scale() / 2 / Math.PI)
        .translate(zoom.translate());

    var image = layer
        .style(prefix + "transform", matrix3d(tiles.scale, tiles.translate))
      .selectAll(".tile")
        .data(tiles, function(d) { return d; });

    image.exit()
        .each(function(d) { this._xhr.abort(); })
        .remove();

    image.enter().append("svg")
        .attr("class", "tile")
        .style("left", function(d) { return d[0] * 256 + "px"; })
        .style("top", function(d) { return d[1] * 256 + "px"; })
        .each(function(d) {
          var svg = d3.select(this);
          this._xhr = d3.json("http://" + ["a", "b", "c"][(d[0] * 31 + d[1]) % 3] + ".tile.openstreetmap.us/vectiles-highroad/" + d[2] + "/" + d[0] + "/" + d[1] + ".json", function(error, json) {
            var k = Math.pow(2, d[2]) * 256; // size of the world in pixels

            tilePath.projection()
                .translate([k / 2 - d[0] * 256, k / 2 - d[1] * 256]) // [0°,0°] in pixels
                .scale(k / 2 / Math.PI);

            svg.selectAll("path")
                .data(json.features.sort(function(a, b) { return a.properties.sort_key - b.properties.sort_key; }))
              .enter().append("path")
                .attr("class", function(d) { return d.properties.kind; })
                .attr("d", tilePath);
          });
        });
  }

  function mousemoved() {
    info.text(formatLocation(projection.invert(d3.mouse(this)), zoom.scale()));
  }

  function matrix3d(scale, translate) {
    var k = scale / 256, r = scale % 1 ? Number : Math.round;
    return "matrix3d(" + [k, 0, 0, 0, 0, k, 0, 0, 0, 0, k, 0, r(translate[0] * scale), r(translate[1] * scale), 0, 1 ] + ")";
  }

  function prefixMatch(p) {
    var i = -1, n = p.length, s = document.body.style;
    while (++i < n) if (p[i] + "Transform" in s) return "-" + p[i].toLowerCase() + "-";
    return "";
  }

  function formatLocation(p, k) {
    var format = d3.format("." + Math.floor(Math.log(k) / 2 - 2) + "f");
    return (p[1] < 0 ? format(-p[1]) + "°S" : format(p[1]) + "°N") + " "
         + (p[0] < 0 ? format(-p[0]) + "°W" : format(p[0]) + "°E");
  }

</script>
