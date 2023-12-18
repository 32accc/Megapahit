if (NOT ${viewer_VERSION})
  MESSAGE(FATAL_ERROR "Viewer version not known!")
endif (NOT ${viewer_VERSION})

set(INSTALL OFF CACHE BOOL
    "Generate install target.")

if (INSTALL)
  set(INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX} CACHE PATH
      "Top-level installation directory.")

  if (EXISTS ${CMAKE_SYSROOT}/usr/lib/${ARCH}-linux-gnu)
    set(_LIB lib/${ARCH}-linux-gnu)
  elseif (EXISTS /lib64)
    set(_LIB lib64)
  else ()
    set(_LIB lib)
  endif ()

  set(INSTALL_LIBRARY_DIR ${INSTALL_PREFIX}/${_LIB} CACHE PATH
      "Installation directory for read-only shared files.")

  set(INSTALL_SHARE_DIR ${INSTALL_PREFIX}/share CACHE PATH
      "Installation directory for read-only shared files.")

  set(APP_BINARY_DIR ${INSTALL_PREFIX}/bin
      CACHE PATH
      "Installation directory for binaries.")

  set(APP_SHARE_DIR ${INSTALL_SHARE_DIR}/${VIEWER_BINARY_NAME}
      CACHE PATH
      "Installation directory for read-only data files.")

  set(APP_LIBEXEC_DIR ${INSTALL_PREFIX}/libexec/${VIEWER_BINARY_NAME}
      CACHE PATH
      "Installation directory for non-manual executables.")
endif (INSTALL)
