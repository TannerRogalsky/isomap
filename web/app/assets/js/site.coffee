#= require vendor/jquery.js
#= require vendor/bootstrap.js
#= require_tree shared
#= require_tree app

[map_X, map_Y, map_Z] = [10, 10, 3]
[tile_w, tile_h, tile_z] = [20, 10, 20]

$ =>
  @g = $("#canvas")[0].getContext("2d")
  main()
  @requestAnimationFrame animation_loop

main = ->
  @map = new Map(map_X, map_Y, map_Z, tile_w, tile_h, tile_z)

animation_loop = (time) ->
  @requestAnimationFrame animation_loop
  @map.draw()
