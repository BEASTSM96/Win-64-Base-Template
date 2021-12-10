require "../lua/init"
require "../lua/third_party_project"

third_party_project( "imgui", "StaticLib" )
	files
	{
		"%{prj.name}/imgui**.h",
		"%{prj.name}/imgui**.cpp",

		"%{prj.name}/exmaples/imgui_impl_opengl3.cpp",
		"%{prj.name}/exmaples/imgui_impl_opengl3.h",
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}
	
	includedirs
	{
		"%{prj.name}/imgui**.h",
		"%{prj.name}/exmaples/imgui_impl_opengl3.h"
	}