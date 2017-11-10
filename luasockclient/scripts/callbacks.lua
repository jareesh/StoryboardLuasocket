local counter = 0
local host, port = "localhost", 12350
local socket = require("socket")
local c = nil
--- @param gre#context mapargs
function start_sock(mapargs) 
  -- change here to the host an port you want to contact
  --print("Attempting connection to host '" ..host.. "' and port " ..port.. "...")
  local data = {}
  data["screenlayer.message.text"] = "Attempting connection to host '" ..host.. "' and port " ..port.. "...\n"
  gre.set_data(data)
  c = assert(socket.connect(host, port))
  data["screenlayer.message.text"] = data["screenlayer.message.text"].."Connected to host '" ..host.. "' and port " ..port.. "...\n"
  gre.set_data(data)  
  counter = counter + 1 
  tx = counter.." - hello to the server"
  data["screenlayer.message.text"] = data["screenlayer.message.text"].."sending :"..tx.."\n"
  gre.set_data(data)  
  --print("sending :"..tx)
  assert(c:send(tx .. "\n"))
  print("sent :"..tx)
end
