class @Map
  constructor: (@width, @height, @depth, @tile_width, @tile_height, @tile_depth) ->
    @internal_map = []
    for mz in [0...@depth]
      @internal_map[mz] = []
      for my in [0...@height]
        @internal_map[mz][my] = []
        for mx in [0...@width]
          @internal_map[mz][my][mx] = new Block(@, mx, my, mz, 1)

  draw: ->
    for mz in [0...@depth]
      for my in [0...@height]
        for mx in [0...@width]
          block = @internal_map[mz][my][mx]
          block.draw()
