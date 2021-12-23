require "../lua/init"
require "../lua/third_party_project"

third_party_project( "ImGui", "StaticLib" )
	files
	{
		"%{prj.name}/imgui*.h",
		"%{prj.name}/imgui*.cpp",

		"%{prj.name}/backends/imgui_impl_opengl3.cpp",
		"%{prj.name}/backends/imgui_impl_glfw.cpp",
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"GLFW_RESIZE_NESW_CURSOR"
	}

	includedirs
	{
		"%{prj.name}/",
		"glfw/include"
	}

	filter "system:windows"
		systemversion "latest"

	filter "system:linux"
		systemversion "latest"

	filter "system:macosx"
		systemversion "11"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"