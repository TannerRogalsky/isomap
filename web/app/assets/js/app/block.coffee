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

  set_face_color: (dist, angle) ->
    {h, s, l} = Block.colors[@value]

    # create a field of view
    l = l * (1 - dist/0xA)

    # desature out of view
    s = s * (1 - dist/0xA)

    # drop shadows under things
    l = l * (1 + angle/0x4)

    # choose a minimum cap of light
    l = l > 0x10 and l or 0x10
    # YOU GOT THE CAP OF LIGHT

    # collect and format
    [r, g, b] = Block.hsl_to_rgb(h, s, l)

    # setColor
    gr.setColor(r, g, b, alpha)

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

  @colors:
    ground:
      h: 0.20
      s: 0.40
      l: 0.40
    air:
      h: 0
      s: 0
      l: 0
      a: 0

  @hsl_to_rgb: (h, s, l) ->
    if s == 0
      r = g = b = l # achromatic
    else
      hue2rgb = (p, q, t) ->
        if t < 0 then t += 1
        if t > 1 then t -= 1
        if t < 1/6 then return p + (q - p) * 6 * t
        if t < 1/2 then return q
        if t < 2/3 then return p + (q - p) * (2/3 - t) * 6
        return p

    q = if l < 0.5 then l * (1 + s) else l + s - l * s
    p = 2 * l - q
    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)

    return [r * 255, g * 255, b * 255]
