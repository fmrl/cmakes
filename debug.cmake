# $legal:226:
# 
# Copyright (c) 2012, Michael Lowell Roberts.
# All rights reserved.
# 
# Redistribution or use in source or binary forms, with or without
# modification, is prohibited without the express permission of the
# author.
# 
# ,$
option(WANT_DEBUG_CMAKE 
	"select this option if you would like to see extra logging from the CMake scripts."
	NO)
mark_as_advanced(WANT_DEBUG_CMAKE)

if(NOT DEFINED debug_message)

macro(debug_message)
	if(WANT_DEBUG_CMAKE)
		message(STATUS "${ARGN}")
	endif()
endmacro()

endif()

# $vim:23: vim:set sts=3 sw=3 et:,$
