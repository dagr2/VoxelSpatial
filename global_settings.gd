extends Node

var _vchunks
var times={}
var player

var chunks={}
var cmutex=Mutex.new()

func has_chunk(k):
  cmutex.lock()
  var res=false
  if chunks.has(k):
    res=true
  cmutex.unlock()
  return res
  
func set_chunk(k,v):
  cmutex.lock()
  chunks[k]=v
  cmutex.unlock()
  
func get_chunk(k):
  cmutex.lock()
  var res=chunks[k]
  cmutex.unlock()
  return res
    
func set_vchunks(c):
    _vchunks=c
    
func start(f):
    var time={}
    time.f=f
    time.t = OS.get_unix_time()
    times[f]=time
    return f
    
func stop(f):
    var time=times[f]
    return OS.get_unix_time() - time.t

func pstop(f): 
  var d=stop(f)
  if d>1:
    print(f+" took "+str(d)+"ms")
    
 