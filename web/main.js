$(document).ready(function(){
  main();
});

function main() {
  canvas = document.getElementById("canvas");
  g = canvas.getContext("2d");
  // g.fillStyle = "#FF0000";
  // g.beginPath();
  // g.moveTo(50,50);
  // g.lineTo(150,50);
  // g.lineTo(200,100);
  // g.lineTo(100,100);
  // // g.lineTo(50,50);
  // g.fill(); // Draw it

  var map = load_map(1);
  draw(map);
}

var map_X = 10;
var map_Y = 10;
var map_Z = 3;
var tile_w = 20;
var tile_h = 10;
var tile_z = 20;

function load_map(map_indentifier){
  var map = {};

  // x, y, and z coords of the map
  for (var mz = 0; mz < map_Z; mz++) {
    map[mz] = {};
    for (var my = 0; my < map_Y; my++) {
      map[mz][my] = {};
      for (var mx = 0; mx < map_X; mx++) {
        map[mz][my][mx] = 1;
      }
    }
  }

  map[2][4][5] = 0;
  map[2][5][5] = 0;
  map[2][5][4] = 0;
  map[2][4][4] = 0;
  return map;
}

function draw(map){
  for (var mz = 0; mz < map_Z; mz++) {
    for (var my = 0; my < map_Y; my++) {
      for (var mx = 0; mx < map_X; mx++) {
        var block_value = map[mz][my][mx];
        if (block_value >= 1) {
          block_draw(mx, my, mz, block_value);
        }
      }
    }
  }
}

function block_draw(mx, my, mz, type){
  var offset = 200;

  var x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8;
  var iso_coords = axono(mx, my, mz);
  var vertices = rhombi(iso_coords[0], iso_coords[1]);
  x1 = vertices[0] + offset;
  y1 = vertices[1] + offset;
  x2 = vertices[2] + offset;
  y2 = vertices[3] + offset;
  x3 = vertices[4] + offset;
  y3 = vertices[5] + offset;
  x4 = vertices[6] + offset;
  y4 = vertices[7] + offset;
  x5 = vertices[8] + offset;
  y5 = vertices[9] + offset;
  x6 = vertices[10] + offset;
  y6 = vertices[11] + offset;
  x7 = vertices[12] + offset;
  y7 = vertices[13] + offset;
  x8 = vertices[14] + offset;
  y8 = vertices[15] + offset;

  g.strokeStyle = "#000000";
  g.fillStyle = "#FF9966";
  face_draw(x1, y1, x2, y2, x6, y6, x5, y5);
  g.fillStyle = "#FF9999";
  face_draw(x2, y2, x3, y3, x7, y7, x6, y6);
  g.fillStyle = "#FF6666";
  face_draw(x5, y5, x6, y6, x7, y7, x8, y8);
}

function axono(x, y, z){
  var xpos, ypos;
  // xpos = (map_Y * x - map_X * y) * tile_w;
  // ypos = (map_Y * y + map_X * x) * tile_h - z * tile_z;

  xpos = (x - y) * tile_w;
  ypos = (y + x) * tile_h - z * tile_z;
  return [xpos, ypos];
}

function rhombi(x, y){
  return [
    x + tile_w, y + tile_z/2,
    x, y + tile_h + tile_z/2,
    x - tile_w, y + tile_z/2,
    x, y - tile_h + tile_z/2,

    x + tile_w, y - tile_z/2,
    x, y + tile_h - tile_z/2,
    x - tile_w, y - tile_z/2,
    x, y - tile_h - tile_z/2
  ];
}

function face_draw(x1, y1, x2, y2, x3, y3, x4, y4){
  g.beginPath();
  g.moveTo(x1,y1);
  g.lineTo(x2,y2);
  g.lineTo(x3,y3);
  g.lineTo(x4,y4);
  g.fill();
  g.stroke();
}
