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

function(set_cache_builtin TYPE NAME)
	set(GUARD ${PROJECT_NAME}_${NAME}_IS_CONFIGURED)
	if(NOT ${GUARD})
		set(${NAME} "${ARGN}" CACHE ${TYPE} "see CMakeFile.txt for more details." FORCE)
		set(${GUARD} YES CACHE INTERNAL 
			"a guard variable used by set_default_cache().")
	endif()
endfunction()

function(optional_cache_string NAME DESCRIPTION)
	# set up cache variable defaults for ramalloc compile-time options.
	set(${NAME} "DEFAULT" CACHE STRING "${DESCRIPTION}")
	if(NOT ${NAME} STREQUAL DEFAULT)
		set(${NAME}_SPECIFIED YES PARENT_SCOPE)
	endif()
endfunction()

# $vim:23: vim:set sts=3 sw=3 et:,$

