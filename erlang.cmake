# $legal:1599:
# 
# Copyright (c) 2011-2012, Michael Lowell Roberts.  
# All rights reserved. 
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are 
# met: 
# 
#   - Redistributions of source code must retain the above copyright 
#   notice, this list of conditions and the following disclaimer. 
# 
#   - Redistributions in binary form must reproduce the above copyright 
#   notice, this list of conditions and the following disclaimer in the 
#   documentation and/or other materials provided with the distribution.
#  
#   - Neither the name of the copyright holder nor the names of 
#   contributors may be used to endorse or promote products derived 
#   from this software without specific prior written permission. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER 
# OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
# 
# ,$

include(cmakes/config.cmake)
include(cmakes/debug.cmake)

if(BUILD_TYPE)
   set(FLAVOR BUILD_TYPE)
else()
   set(FLAVOR RELEASE)
endif()

# [mlr] according to erl_interface/src/Makefile.in, the meaning of the 
# suffixes depends upon THR_DEFS, which is defined as 
# "-DWIN32_THREADS" for Windows platforms (see configure.in, 
# same directory). therefore:
#
#   - no suffix is multi-threaded, static linkage.
#   - _st should be single-threaded but these aren't provided in 
# Windows.
#   - _md is multi-threaded, dynamic linkage.
#   - _mdd is multi-threaded, dynamic linkage with debugging 
# symbols.
if(WIN32 AND NOT Threads_FOUND)
   message(SEND_ERROR 
      "erlang.cmake: erl_interface requires thread support for Windows platforms.")
endif()

find_file(ERLANG_ERL erl
   HINTS "${ERLANG_PREFIX}"
   PATH_SUFFIXES bin)

if(ERLANG_ERL)
   message(STATUS "erlang.cmake: i found erl at ${ERLANG_ERL}.")

   execute_process(
      COMMAND erl -noshell -eval 
         "io:format(\"~s\", [code:lib_dir(erl_interface)])" -s erlang halt
         OUTPUT_VARIABLE ERLANG_FFI_PREFIX)
   debug_message("erlang.cmake: ERLANG_FFI_PREFIX=${ERLANG_FFI_PREFIX}")

   function(find_ffi_library PREFIX NAME FLAVOR)
      if(Threads_FOUND)
         # [mlr] dynamic linkage only appears to be available on Windows.
         if(WIN32 AND NOT WANT_STATIC_LIBS)
            set(DEBUG_SUFFIX "_mdd")
            set(RELEASE_SUFFIX "_md")
         endif()
      else()
         set(DEBUG_SUFFIX "_st")
         set(RELEASE_SUFFIX "_st")
      endif()
      # [mlr][todo] constructing the library name should be done in a
      # separate function, in a portable manner.
      set(VARNAME ${PREFIX}_${FLAVOR})
      set(FILEN "lib${NAME}${${FLAVOR}_SUFFIX}.a")
      debug_message("erlang.cmake: (in find_ffi_library) FILEN=${FILEN}")
      find_library(
         ${VARNAME}
         ${FILEN}
         HINTS "${ERLANG_FFI_PREFIX}"
         PATH_SUFFIXES lib)
      if(${VARNAME})
         message("erlang.cmake: i found ${NAME} at ${${VARNAME}}.")
      else()
         message("erlang.cmake: i failed to find ${NAME} (${FILEN}).")
      endif()
      set(${VARNAME} ${${VARNAME}} PARENT_SCOPE)
      debug_message(
         "erlang.cmake: (in find_ffi_library) ${VARNAME}=${${VARNAME}}")
   endfunction()

   find_ffi_library(ERLANG_EI_LIBRARY ei DEBUG)
   find_ffi_library(ERLANG_EI_LIBRARY ei RELEASE)
   find_ffi_library(ERLANG_ERL_INTERFACE_LIBRARY erl_interface DEBUG)
   find_ffi_library(ERLANG_ERL_INTERFACE_LIBRARY erl_interface RELEASE)
else()
   message("erlang.cmake: i failed to find erl.")
endif()

if(ERLANG_EI_LIBRARY_${FLAVOR})
   if(ERLANG_ERL_INTERFACE_LIBRARY_${FLAVOR})
      set(ERLANG_FOUND YES)
   endif()
endif()

if(ERLANG_FOUND)
   set(ERLANG_EI_LIBRARY ${ERLANG_EI_LIBRARY_${FLAVOR}})
   set(ERLANG_ERL_INTERFACE_LIBRARY 
      ${ERLANG_ERL_INTERFACE_LIBRARY_${FLAVOR}})
   message("erlang.cmake: i found erlang.")
   can_has(erlang)
   # [mlr] erlang C interface libraries require __WIN32__ to be defined
   # for windows platforms. also, the symbol `erl_errno` doesn't appear
   # to link unless the preprocessor symbol `_REENTRANT` is defined.
   if(WIN32)
      set(ERLANG_DEFINITIONS "/D__WIN32__ /D_REENTRANT")
   else()
      if(Threads_FOUND)
         set(ERLANG_DEFINITIONS "-D_REENTRANT")
      endif()
   endif()
   debug_message(
      "erlang.cmake: ERLANG_DEFINITIONS=${ERLANG_DEFINITIONS}")
   # [mlr][todo] do i want to offer the option to disable the following
   # step?
   add_definitions(${ERLANG_DEFINITIONS})
   # [mlr] the ordering of the libraries is important to avoid link
   # errors.
   set(ERLANG_LIBRARIES 
      ${ERLANG_ERL_INTERFACE_LIBRARY} ${ERLANG_EI_LIBRARY})
   set(ERLANG_INCLUDE "${ERLANG_FFI_PREFIX}/include")
   debug_message(
      "erlang.cmake: ERLANG_INCLUDE=${ERLANG_INCLUDE}")
   include_directories(${ERLANG_INCLUDE})
else()
   message("erlang.cmake: i failed to find erlang.")
endif()

# $vim:23: vim:set sts=3 sw=3 et:,$






