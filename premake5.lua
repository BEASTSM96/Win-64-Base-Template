require "lua/init"
require "lua/project"
require "lua/workspace"
require "lua/third_party_include"

_workspace( "App-Base", "ExePrj" )

third_party_include "third_party/glfw"
third_party_include "third_party/imgui"
third_party_include "third_party/xGL"

_project( "libProject", "StaticLib" )
	includedirs
	{
		"%{prj.name}/src"
	}

_project( "ExePrj", "ConsoleApp" )
	includedirs
	{	
		"%{prj.name}/src/**.h",
		"libProject/src/**.h"
	}

	links
	{
		"libProject"
	}