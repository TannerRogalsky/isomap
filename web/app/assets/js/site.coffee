#= require vendor/jquery.js
#= require vendor/bootstrap.js
#= require_tree shared

$ ->
  main()

g = $("#canvas")[0].getContext("2d")
[map_X, map_Y, map_Z] = [10, 10, 3]
[tile_w, tile_h, tile_z] = [20, 10, 20]

main = ->
  map = load_map()
  draw(map)

load_map = ->
  map = []

  for mz in [0...map_Z]
    map[mz] = []
    for my in [0...map_Y]
      map[mz][my] = []
      for mx in [0...map_X]
        map[mz][my][mx] = 1

  return map

draw = (map) ->
  for mz in [0...map_Z]
    for my in [0...map_Y]
      for mx in [0...map_X]
        block_value = map[mz][my][mx]
        block_draw(mx, my, mz, block_value)

block_draw = (mx, my, mz, block_value) ->
  offset = 200

  [iso_x, iso_y] = axono(mx, my, mz)
  vertices = rhombi(iso_x, iso_y)

  for index in [0...vertices.length]
    vertices[index] += offset

  [x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8] = vertices

  g.strokeStyle = "#000000"
  g.fillStyle = "#FF9966"
  face_draw(x1, y1, x2, y2, x6, y6, x5, y5)
  g.fillStyle = "#FF9999"
  face_draw(x2, y2, x3, y3, x7, y7, x6, y6)
  g.fillStyle = "#FF6666"
  face_draw(x5, y5, x6, y6, x7, y7, x8, y8)

axono = (x, y, z) ->
  # xpos = (map_Y * x - map_X * y) * tile_w
  # ypos = (map_Y * y + map_X * x) * tile_h - z * tile_z
  xpos = (x - y) * tile_w
  ypos = (y + x) * tile_h - z * tile_z
  return [xpos, ypos]

rhombi = (x, y) ->
  return [
    x + tile_w, y + tile_z/2,
    x, y + tile_h + tile_z/2,
    x - tile_w, y + tile_z/2,
    x, y - tile_h + tile_z/2,

    x + tile_w, y - tile_z/2,
    x, y + tile_h - tile_z/2,
    x - tile_w, y - tile_z/2,
    x, y - tile_h - tile_z/2
  ]

face_draw = (x1, y1, x2, y2, x3, y3, x4, y4) ->
  g.beginPath()
  g.moveTo(x1,y1)
  g.lineTo(x2,y2)
  g.lineTo(x3,y3)
  g.lineTo(x4,y4)
  g.fill()
  g.stroke()
