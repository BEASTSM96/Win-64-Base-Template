-- Foundation workspace

local p = premake
local m = p.modules.lua

_outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Use "_" prefix for any types that have the same name.
function outputdir( )
	return _outputdir
end