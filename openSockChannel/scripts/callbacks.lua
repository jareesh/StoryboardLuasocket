
local state = 0

local counter = 0
local host, port = "localhost", 12350
local socket = require("socket")
local s = nil
local c = nil
local e = nil

-- This will call into our library
--function get_crank_time(mapargs) 
function handle_connect_press(mapargs) 
  print("starting to listen")
  local data = gre.get_data("Layer.showtext.text")
  data["Layer.showtext.text"] = data["Layer.showtext.text"].."Binding to host " ..host.. " and port " ..port.. "...\n"
  gre.set_data(data)
  s = assert(socket.bind(host, port))
  i, p   = s:getsockname()
  assert(i, p)
  print("getsockname i :" ..i.. "' and p :" ..p.. "...")
  data["Layer.showtext.text"] = data["Layer.showtext.text"].."Waiting connection from" .. i .. ":" .. p .. "...\n"
  gre.set_data(data)
  c = assert(s:accept())
  print("A4 accepted")
end

--- @param gre#context mapargs
function send_data(mapargs) 
  print("Connected. Here is the stuff:")
  local data = gre.get_data("Layer.showtext.text")
  data["Layer.showtext.text"] = data["Layer.showtext.text"].."Waiting for data...\n"
  gre.set_data(data)
  c:settimeout(0.5)
  --socket.sleep(1)
  rx, e = c:receive()
  data["Layer.showtext.text"] = data["Layer.showtext.text"]..rx.." - Received...\n"
  gre.set_data(data)
  print(e)
end
