-- Foundation workspace

local p = premake
local m = p.modules.lua

workspaces = { }

-- Use "_" prefix for any types that have the same name.
function _workspace( name, startprj )
	workspace ( name )
		architecture "x86_64"
		if name ~= "" then 
			startproject( startprj ) 
		end
		configurations { "Debug", "Release" }
		flags { "MultiProcessorCompile" }
	
	table.insert( workspaces, name )
end