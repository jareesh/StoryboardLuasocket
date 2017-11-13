package.path = package.path..';./libs/lua/?.lua'
package.cpath = package.cpath..';./libs/socket/?.dll;./libs/mime/?.dll'

local state = 0

local counter = 0
local host, port = "localhost", 12350
--local socket = require("socket")
local s = nil
local c = nil
local e = nil

local socket = nil
function myfunction ()
  local dv = {}
  dv["MyBkgrnd.ShowLog.errlog"] = "Enter myfunction...\n"
  gre.set_data(dv)
  socket = require("socket")
  dv["MyBkgrnd.ShowLog.errlog"] = dv["MyBkgrnd.ShowLog.errlog"].."Exit myfunction...\n"
  gre.set_data(dv)
end

function myerrorhandler( err )
  local dv = {}
  dv["MyBkgrnd.ShowLog.errlog"] = "Start ErrorHandler...\n"
  dv["MyBkgrnd.ShowLog.errlog"] = dv["MyBkgrnd.ShowLog.errlog"].."\npackage.path :"..package.path
  dv["MyBkgrnd.ShowLog.errlog"] = dv["MyBkgrnd.ShowLog.errlog"].."\npackage.cpath :"..package.cpath
  dv["MyBkgrnd.ShowLog.errlog"] = dv["MyBkgrnd.ShowLog.errlog"].."\nERROR :"..err.."\nEnd ErrorHandler"
  gre.set_data(dv)
end

--- @param gre#context mapargs
function test(mapargs) 
  local data = {}
  counter = counter + 1
  data["MyBkgrnd.Status.statustext"] = "Start Server\n"
  gre.set_data(data)
  status = xpcall( myfunction, myerrorhandler)
  data["MyBkgrnd.Status.statustext"] = data["MyBkgrnd.Status.statustext"].."Binding to host " ..host.. " and port " ..port.. "...\n"
  gre.set_data(data)
  s = assert(socket.bind(host, port))
  data["MyBkgrnd.Status.statustext"] = data["MyBkgrnd.Status.statustext"].."Bind success to host " ..host.. " and port " ..port.. "...\n"
  gre.set_data(data)
  i, p   = s:getsockname()
  assert(i, p)
  data["MyBkgrnd.Status.statustext"] = data["MyBkgrnd.Status.statustext"].."Waiting connection from '" .. i .. "':" .. p .. "...\n"
  gre.set_data(data)
  c = assert(s:accept())
end
