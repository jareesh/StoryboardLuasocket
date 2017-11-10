
--[[
External JAR file loader.  This is based loosely on the Stack Overflow posts:

 http://stackoverflow.com/questions/11453614/how-can-i-load-a-jar-file-dynamically-in-an-android-application-4-0-3

 http://stackoverflow.com/questions/11929850/loading-classes-from-jar-on-android

Standard Java JAR libraries must be converted to the Android DEX format and
packaged into a new JAR library before they can be used on an Android target.  

To do this, first install the Android SDK development tools.  Then you can 
run the following commands

> dx --verbose --dex --output=classes.dex <your_java_lib.jar>
> aapt add -v <java_lib_name>.jar classes.dex

For example, if there was a library /home/crank/ajavalib.jar then
to prepare an Android version in the "java" directory of "myproject"
using the same library base name execute the following commands:

> cd myproject/java
> dx --verbose --dex --output=classes.dex /home/crank/ajavalib.jar
> aapt add -v ajavalib.jar classes.dex

]]

-- This is a local error message routine that you can use to help
-- diagnose loading faults with your applications by re-directing
-- the output to whatever facility is practical.
local function emsg(msg)
	print(msg)
--	local dv = {}
--	dv["Layer1.errmsg.text"] = msg
--	gre.set_data(dv)
end

-- Load a class from an external jar file
--
--@param className The fully qualified string of the class to load
--@param jarFilename The absolute path of the jar file to load
--@return An object representing the class provided or nil
function loadClassFromJar(className, jarFilename)
	local lj = luajava
	if(lj == nil) then
		emsg("Missing Lua Java")
		return
	end
	emsg("Have Lua Java")

	local na = luajava.nativeActivity()
	if(na == nil) then
		emsg("Can't get native activity")
		return
	end	
	emsg("Have native activity")
	
	local naClassLoader = na:getClassLoader()
	if(naClassLoader == nil) then
		emsg("No class native activity")
		return
	end
	emsg("Have native activity class loader")

	local cacheDir = na:getBaseContext():getDir("dex", 0):getAbsolutePath();
	emsg("Have DEX Cache " .. tostring(cacheDir))
	
	emsg("Load: " .. jarFilename .. "\nCache Dir:" .. cacheDir)
	local dexCL = lj.newInstance("dalvik.system.DexClassLoader", 
								 jarFilename, 
								 cacheDir, 
								 nil, 
								 naClassLoader);
    if(dexCL == nil) then
		emsg("Can't create a new DexClassLoader loading " .. tostring(jarFilename))
		return
	end
	emsg("Have DexClassLoader, loading " .. tostring(className))
	    	
    local myClass = dexCL:loadClass(className);
	if(myClass == nil) then
		emsg("Can't get a class for " .. tostring(className))
	end
	
	return myClass
end