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
include(cmakes/yaml-cpp.cmake)

find_library(
	NYAN_LIBRARY libnyan.a
	HINTS "${NYAN_PREFIX}"
	PATH_SUFFIXES lib)

if(NYAN_LIBRARY)
	if (NOT DEFINED NYAN_PREFIX)
		get_filename_component(NYAN_PREFIX 
			"${NYAN_LIBRARY}" PATH)
		# on platforms where multi-configuration builds are supported,
		# the libraries are placed in the appropriate sub-directory of
		# the 'lib" directory.
		# [todo] i don't know if this is actually the case for 
		# libyaml-cpp though.
		# [todo] i want to cannonize this test into a function.
		if("${CMAKE_CONFIGURATION_TYPES}")
			get_filename_component(NYAN_PREFIX 
				"${NYAN_PREFIX}/../.." ABSOLUTE)
		else()
			get_filename_component(NYAN_PREFIX 
				"${NYAN_PREFIX}/.." ABSOLUTE)
		endif()
	endif()

	# [mlr][todo] boost should be included in this.
	set(NYAN_INCLUDE "${NYAN_PREFIX}/include" ${YAMLCPP_INCLUDE})
	set(NYAN_LIBRARIES ${NYAN_LIBRARY} ${YAMLCPP_LIBRARIES})
	include_directories(${NYAN_INCLUDE})

	can_has(nyan)
else()
	message(WARNING 
		"i could not find libnyan on your system. please specify the correct path using the NYAN_PREFIX variable.")
endif()

# $vim:23: vim:set sts=3 sw=3 et:,$






