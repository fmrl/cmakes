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

include(cmakes/debug.cmake)

if(NOT DEFINED generate_config_header)

function(generate_config_header NAMESPACE)

	string(TOUPPER ${NAMESPACE} CAN_HAS_NAMESPACE)

	# CAN_HAS contains information about which feature macros
	# we can generate.
	foreach(I ${CAN_HAS})
		string(TOUPPER ${I} S) 
		set(S ${CAN_HAS_NAMESPACE}_CAN_HAS_${S})
		set(${S} YES)
		debug_message("#define ${S} 1")
	endforeach()

	# to namespace header file substitutions, i use a two-pass
	# subtitution method i encountered on the CMake mailing list:
	# http://public.kitware.com/pipermail/cmake/2006-March/008685.html
	set(CMAKEDEFINE "#cmakedefine01")
	set(TMPFILE "${CMAKE_CURRENT_BINARY_DIR}/tmp.fmrl.config/${NAMESPACE}/config.h.in")
	configure_file(cmakes/config.h.in ${TMPFILE} @ONLY)
	configure_file(${TMPFILE} ${CMAKE_CURRENT_BINARY_DIR}/include/${NAMESPACE}/config.h)

endfunction()

function(can_has FEATURE)
	list(APPEND CAN_HAS ${FEATURE})
	set(CAN_HAS ${CAN_HAS} PARENT_SCOPE)
endfunction()

endif()

# $vim:23: vim:set sts=3 sw=3 et:,$








