-- Foundation workspace

local p = premake
local m = p.modules.lua

_outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Use "_" prefix for any types that have the same name.
function outputdir( )
	return _outputdir
end

function get_kind( _kind )
	if _kind == "StaticLib" then 
		return "StaticLib" 
	elseif _kind == "SharedLib" then 
		return "SharedLib" 
	elseif _kind == "ConsoleApp" then 
		return "ConsoleApp" 
	else 
		return "WindowedApp" 
	end
end