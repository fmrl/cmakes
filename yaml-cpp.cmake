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

include(cmakes/config.cmake)

find_library(YAMLCPP_LIBRARY libyaml-cpp.a
	HINTS "${YAMLCPP_PREFIX}"
	PATH_SUFFIXES lib
	)

if(YAMLCPP_LIBRARY)
	if (NOT DEFINED YAMLCPP_PREFIX)
		get_filename_component(YAMLCPP_PREFIX 
			"${YAMLCPP_LIBRARY}" PATH)
		# on platforms where multi-configuration builds are supported,
		# the libraries are placed in the appropriate sub-directory of
		# the 'lib" directory.
		# [todo] i don't know if this is actually the case for 
		# libyaml-cpp though.
		# [todo] i want to cannonize this test into a function.
		if("${CMAKE_CONFIGURATION_TYPES}")
			get_filename_component(YAMLCPP_PREFIX 
				"${YAMLCPP_PREFIX}/../.." ABSOLUTE)
		else()
			get_filename_component(YAMLCPP_PREFIX 
				"${YAMLCPP_PREFIX}/.." ABSOLUTE)
		endif()
	endif()

	include_directories("${YAMLCPP_PREFIX}/include")

	can_has(yamlcpp)
	can_has(yaml)
else()
	message(WARNING 
		"i could not find libyaml-cpp on your system. please specify the correct path using the YAMLCPP_PREFIX variable.")
endif()

# $vim:23: vim:set sts=3 sw=3 et:,$






