extends Node
var scale=0.1
var scale2 = 0.05
var height=8
var BLOCKS=5

var noise2=OpenSimplexNoise.new()

func get_height(x,z):
  var h=(noise2.get_noise_2d(x*scale,z*scale)+1)/2*height
  return h
  
func get_block(x,y,z):
  var h=get_height(x,z)
  if y>h or y<0 or y>15:
    return 0
  else:
    var v=(noise2.get_noise_3d(x*scale2,y*scale2,z*scale2)+1)/2*BLOCKS+1
    return v
