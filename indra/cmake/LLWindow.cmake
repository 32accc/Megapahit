# -*- cmake -*-

include(Variables)
include(GLEXT)
include(Prebuilt)

include_guard()
add_library( ll::SDL INTERFACE IMPORTED )

if (USESYSTEMLIBS)
  include(FindPkgConfig)
  pkg_check_modules(Sdl2 REQUIRED sdl2)
  target_compile_definitions( ll::SDL INTERFACE LL_SDL=1)
  target_include_directories(ll::SDL SYSTEM INTERFACE ${Sdl2_INCLUDE_DIRS})
  target_link_directories(ll::SDL INTERFACE ${Sdl2_LIBRARY_DIRS})
  if (LINUX OR CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
    list(APPEND Sdl2_LIBRARIES X11)
  endif ()
  target_link_libraries(ll::SDL INTERFACE ${Sdl2_LIBRARIES})
  return ()
endif ()


if (LINUX)
  #Must come first as use_system_binary can exit this file early
  target_compile_definitions( ll::SDL INTERFACE LL_SDL=1)

  use_system_binary(SDL)
  use_prebuilt_binary(SDL)

  target_include_directories( ll::SDL SYSTEM INTERFACE ${LIBS_PREBUILT_DIR}/include)
  target_link_libraries( ll::SDL INTERFACE SDL directfb fusion direct X11)
endif (LINUX)


