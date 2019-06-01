extends Node

var scale=2.0
var scale2 = 0.9
var height=15
var BLOCKS=8



var noise2=OpenSimplexNoise.new()

func get_height(x,z):
  var h=(noise2.get_noise_2d(x*scale,z*scale)+1)/2*height
  return h
  
func get_block(x,y,z):
  #return 1
  var h=get_height(x,z)
  if y>h or y<0 or y>15:
    return 0
  else:
    var v=floor((noise2.get_noise_3d(x*scale2,y*scale2,z*scale2)+1.0)/2.0*(BLOCKS-1)+1.0)
    return v
