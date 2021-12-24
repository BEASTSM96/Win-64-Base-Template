/********************************************************************************************
*                                                                                           *
*                                                                                           *
*                                                                                           *
* MIT License                                                                               *
*                                                                                           *
* Copyright (c) 2021 BEAST                                                           		*
*                                                                                           *
* Permission is hereby granted, free of charge, to any person obtaining a copy              *
* of this software and associated documentation files (the "Software"), to deal             *
* in the Software without restriction, including without limitation the rights              *
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell                 *
* copies of the Software, and to permit persons to whom the Software is                     *
* furnished to do so, subject to the following conditions:                                  *
*                                                                                           *
* The above copyright notice and this permission notice shall be included in all            *
* copies or substantial portions of the Software.                                           *
*                                                                                           *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR                *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                  *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE               *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                    *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,             *
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE             *
* SOFTWARE.                                                                                 *
*********************************************************************************************
*/

#define GLFW_EXPOSE_NATIVE_WIN32

#include "Window.h"
#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>

#include "xgl.h"

#include "backends/imgui_impl_opengl3.h"
#include "backends/imgui_impl_glfw.h"

#if defined( WINDOWS )
#include <Windows.h>
#endif

#include <iostream>

void GLFWErrorCallback( int error, const char* desc )
{
	std::cerr << "GLFW Error %i, %c", error, desc;
}

Window::Window()
{
	glfwSetErrorCallback( GLFWErrorCallback );

	if( glfwInit() == GLFW_FALSE )
		return;

	glfwWindowHint( GLFW_OPENGL_DEBUG_CONTEXT, GL_TRUE );
	glfwWindowHint( GLFW_DECORATED, GLFW_TRUE );

	m_Window = glfwCreateWindow( m_Width, m_Height, m_Title.c_str(), nullptr, nullptr );

	glfwMakeContextCurrent( m_Window );

	if( xGL::LoadGL() == false )
	{
		std::cerr << "Failed to load OpenGL with xGL!"; __debugbreak();
	}

	printf( "OpenGL Renderer: %s, %s, %s\n", glGetString( GL_RENDERER ), glGetString( GL_VENDOR ), glGetString( GL_VERSION ) );

	glfwSetWindowUserPointer( m_Window, this );
	glfwSwapInterval( GLFW_TRUE );

	glfwSetWindowCloseCallback( m_Window, []( GLFWwindow* wind ) { Window* self = ( Window* )glfwGetWindowUserPointer( wind ); self->m_PendingClose ^= 1; } );

	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGui::StyleColorsDark();

	// ImGui Theme

	ImGuiIO& io = ImGui::GetIO();

	io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
	io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
	io.ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;

	// When viewports are enabled we tweak WindowRounding/WindowBg so platform windows can look identical to regular ones.
	ImGuiStyle& style = ImGui::GetStyle();
	if( io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable )
	{
		style.WindowRounding = 0.0f;
		style.Colors[ ImGuiCol_WindowBg ].w = 1.0f;
	}

	ImGui_ImplGlfw_InitForOpenGL( m_Window, true );
	ImGui_ImplOpenGL3_Init( "#version 410" );
}

Window::~Window()
{
	ImGui_ImplGlfw_Shutdown();
	ImGui_ImplOpenGL3_Shutdown();

	glfwDestroyWindow( m_Window );
	glfwTerminate();
}

void Window::Refresh()
{
	glfwPollEvents();
}

void Window::Render()
{
	if( m_Rendering )
		return;

	m_Rendering = true;

	ImGui_ImplOpenGL3_NewFrame();
	ImGui_ImplGlfw_NewFrame();

	ImGui::NewFrame();

	ImGuiIO& io = ImGui::GetIO();
	io.DisplaySize = ImVec2( ( float )m_Width, ( float )m_Height );

	ImGui::Render();

	ImGui_ImplOpenGL3_RenderDrawData( ImGui::GetDrawData() );

	if( io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable )
	{
		GLFWwindow* backup_current_context = glfwGetCurrentContext();
		ImGui::UpdatePlatformWindows();
		ImGui::RenderPlatformWindowsDefault();
		glfwMakeContextCurrent( backup_current_context );
	}

	glfwSwapBuffers( m_Window );

	m_Rendering = false;
}

void Window::Maximize()
{
	glfwMaximizeWindow( m_Window );
}

void Window::Minimize()
{
	glfwIconifyWindow( m_Window );
}

void Window::Restore()
{
	glfwRestoreWindow( m_Window );
}

void Window::SetTitle( const std::string& title )
{
	m_Title = title;
	glfwSetWindowTitle( m_Window, m_Title.c_str() );
}

void Window::SizeCallback( GLFWwindow* wind, int h, int w )
{
	Window* self = ( Window* )glfwGetWindowUserPointer( wind );

	self->m_Height = h;
	self->m_Width  = w;
}