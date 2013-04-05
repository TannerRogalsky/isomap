class @Block
  constructor: (@map, @grid_x, @grid_y, @grid_z, @value) ->

  draw: ->
    offset = 200

    [iso_x, iso_y] = Block.axono(@grid_x, @grid_y, @grid_z, @map.tile_width, @map.tile_height, @map.tile_depth)
    vertices = Block.rhombi(iso_x, iso_y, @map.tile_width, @map.tile_height, @map.tile_depth)

    for index in [0...vertices.length]
      vertices[index] += offset

    [x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, x7, y7, x8, y8] = vertices

    g.strokeStyle = "#000000"
    g.fillStyle = "#FF9966"
    @draw_face(x1, y1, x2, y2, x6, y6, x5, y5)
    g.fillStyle = "#FF9999"
    @draw_face(x2, y2, x3, y3, x7, y7, x6, y6)
    g.fillStyle = "#FF6666"
    @draw_face(x5, y5, x6, y6, x7, y7, x8, y8)

  draw_face: (x1, y1, x2, y2, x3, y3, x4, y4) ->
    g.beginPath()
    g.moveTo(x1,y1)
    g.lineTo(x2,y2)
    g.lineTo(x3,y3)
    g.lineTo(x4,y4)
    g.fill()
    g.stroke()

  # converts grid coords to pixel coords
  @axono: (x, y, z, width, height, depth) ->
    # xpos = (map_Y * x - map_X * y) * tile_w
    # ypos = (map_Y * y + map_X * x) * tile_h - z * tile_z
    xpos = (x - y) * width
    ypos = (y + x) * height - z * depth
    return [xpos, ypos]

  # given pixel coords, gives the vertices of the cube at those coords
  @rhombi: (x, y, width, height, depth) ->
    return [
      x + width, y + depth / 2,
      x, y + height + depth / 2,
      x - width, y + depth / 2,
      x, y - height + depth / 2,

      x + width, y - depth / 2,
      x, y + height - depth / 2,
      x - width, y - depth / 2,
      x, y - height - depth / 2
    ]
