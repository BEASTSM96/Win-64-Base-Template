-- Foundation third party include

local p = premake
local m = p.modules.lua

third_party_includes = { }

function third_party_include( name ) 
	include ( name )
	table.insert( third_party_includes, name )
end