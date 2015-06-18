;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2013, 2015 Andreas Enge <andreas@enge.fr>
;;; Copyright © 2013 Joshua Grant <tadni@riseup.net>
;;; Copyright © 2014 David Thompson <davet@gnu.org>
;;; Copyright © 2014, 2015 Mark H Weaver <mhw@netris.org>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (gnu packages gl)
  #:use-module (ice-9 match)
  #:use-module (guix build utils)
  #:use-module ((guix licenses) #:prefix l:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages video)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages zip))

(define-public glu
  (package
    (name "glu")
    (version "9.0.0")
    (source (origin
	     (method url-fetch)
	     (uri (string-append "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-"
				  version ".tar.gz"))
	     (sha256
	      (base32 "0r72yyhj09x3krn3kn629jqbwyq50ji8w5ri2pn6zwrk35m4g1s3"))))
    (build-system gnu-build-system)
    (propagated-inputs
      `(("mesa" ,mesa))) ; according to glu.pc
    (home-page "http://www.opengl.org/archives/resources/faq/technical/glu.htm")
    (synopsis "Mesa OpenGL Utility library")
    (description
     "GLU, or OpenGL Utility Library provides some higher-level functionality
not provided by just OpenGL itself.  Some of GLU's Features
include: Scaling of 2D images and creation of mipmap pyramids,
Transformation of object coordinates into device coordinates and
vice versa, Support for NURBS surfaces, Support for tessellation
of concave or bow tie polygonal primitives, Specialty transformation
matrices for creating perspective and orthographic projections,
positioning a camera, and selection/picking, Rendering of disk,
cylinder, and sphere primitives, Interpreting OpenGL error values
as ASCII text.")
    (license (l:x11-style "http://directory.fsf.org/wiki/License:SGIFreeBv2"))))

(define-public freeglut
  (package
    (name "freeglut")
    (version "2.8.1")
    (source (origin
	     (method url-fetch)
	     (uri (string-append "mirror://sourceforge/project/freeglut/freeglut/"
				  version "/freeglut-" version ".tar.gz"))
	     (sha256
	      (base32 "16lrxxxd9ps9l69y3zsw6iy0drwjsp6m26d1937xj71alqk6dr6x"))))
    (build-system gnu-build-system)
    (inputs `(("mesa" ,mesa)
	      ("libx11" ,libx11)
	      ("libxi" ,libxi)
	      ("libxrandr" ,libxrandr)
	      ("libxxf86vm" ,libxxf86vm)
	      ("inputproto" ,inputproto)
	      ("xinput" ,xinput)))
    (propagated-inputs
     ;; Headers from Mesa and GLU are needed.
     `(("glu" ,glu)
       ("mesa" ,mesa)))
    (home-page "http://freeglut.sourceforge.net/")
    (synopsis "Alternative to the OpenGL Utility Toolkit (GLUT)")
    (description
     "Freeglut is a completely Free/OpenSourced alternative to
the OpenGL Utility Toolkit (GLUT) library.  GLUT was originally
written by Mark Kilgard to support the sample programs in the
second edition OpenGL 'RedBook'.  Since then, GLUT has been used
in a wide variety of practical applications because it is simple,
widely available and highly portable.

GLUT (and hence freeglut) allows the user to create and manage windows
containing OpenGL contexts on a wide range of platforms and also read
the mouse, keyboard and joystick functions.  Freeglut is released under
the X-Consortium license.")
    (license l:x11)))

(define-public ftgl
  (package
    (name "ftgl")
    (version "2.1.3-rc5")
    (source (origin
	     (method url-fetch)
	     (uri (string-append "mirror://sourceforge/project/ftgl/FTGL%20Source/2.1.3~rc5/ftgl-"
				  version ".tar.gz"))
	     (sha256
	      (base32 "0nsn4s6vnv5xcgxcw6q031amvh2zfj2smy1r5mbnjj2548hxcn2l"))))
    (build-system gnu-build-system)
    ;; The pkg-config file lists "freetype2" as Requires.private.
    (propagated-inputs `(("freetype" ,freetype)))
    (inputs `(("libx11" ,libx11)
	      ("mesa" ,mesa)
	      ("glu" ,glu)))
    (home-page "http://ftgl.sourceforge.net")
    (synopsis "Font rendering library for OpenGL applications")
    (description
     "FTGL is a font rendering library for OpenGL applications.  Supported
rendering modes are: Bitmaps, Anti-aliased pixmaps, Texture maps, Outlines,
Polygon meshes, and Extruded polygon meshes")
    (license l:x11)))

(define-public s2tc
  (package
    (name "s2tc")
    (version "1.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/divVerent/s2tc/archive/v" version ".tar.gz"))
       (sha256
        (base32 "0ibfdib277fhbqvxzan0bmglwnsl1y1rw2g8skvz82l1sfmmn752"))
       (file-name (string-append name "-" version ".tar.gz"))))
    (build-system gnu-build-system)
    (native-inputs
     `(("autoconf" ,autoconf)
       ("automake" ,automake)
       ("libtool" ,libtool)))
    (inputs
     `(("mesa-headers" ,mesa-headers)))
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'autogen
          (lambda _
            (zero? (system* "sh" "autogen.sh")))))))
    (home-page "https://github.com/divVerent/s2tc")
    (synopsis "S3 Texture Compression implementation")
    (description
     "S2TC is a patent-free implementation of S3 Texture Compression (S3TC,
also known as DXTn or DXTC) for Mesa.")
    (license l:expat)))

;;; Mesa needs LibVA headers to build its Gallium-based VA API implementation;
;;; LibVA itself depends on Mesa.  We use the following to solve the circular
;;; dependency.
(define libva-without-mesa
  ;; Delay to work around circular import problem.
  (delay
    (package
      (inherit libva)
      (name "libva-without-mesa")
      (inputs (alist-delete "mesa" (package-inputs libva)))
      (arguments
       (strip-keyword-arguments
        '(#:make-flags)
        (substitute-keyword-arguments (package-arguments libva)
          ((#:configure-flags flags)
           '(list "--disable-glx" "--disable-egl"))))))))

(define-public mesa
  (package
    (name "mesa")
    (version "10.5.4")
    (source
      (origin
        (method url-fetch)
        (uri (string-append "ftp://ftp.freedesktop.org/pub/mesa/"
                            version "/mesa-" version ".tar.xz"))
        (sha256
         (base32
          "00v89jna7m6r2w1yrnx09isc97r2bd1hkn4jib445n1078zp47mm"))))
    (build-system gnu-build-system)
    (propagated-inputs
      `(("glproto" ,glproto)
        ;; The following are in the Requires.private field of gl.pc.
        ("libdrm" ,libdrm)
        ("libx11" ,libx11)
        ("libxdamage" ,libxdamage)
        ("libxfixes" ,libxfixes)
        ("libxshmfence" ,libxshmfence)
        ("libxxf86vm" ,libxxf86vm)))
    ;; TODO: Add vdpau.
    (inputs
      `(("udev" ,eudev)
        ("dri2proto" ,dri2proto)
        ("dri3proto" ,dri3proto)
        ("presentproto" ,presentproto)
        ("expat" ,expat)
        ("libva" ,(force libva-without-mesa))
        ("libxml2" ,libxml2)
        ;; TODO: Add 'libxml2-python' for OpenGL ES 1.1 and 2.0 support
        ("libxvmc" ,libxvmc)
        ("makedepend" ,makedepend)
        ("s2tc" ,s2tc)))
    (native-inputs
      `(("pkg-config" ,pkg-config)))
    (arguments
     `(#:configure-flags
       '(;; drop r300 from default gallium drivers, as it requires llvm
         "--with-gallium-drivers=r600,svga,swrast,nouveau"
         ;; Enable various optional features.  TODO: opencl requires libclc,
         ;; omx requires libomxil-bellagio
         "--with-egl-platforms=x11,drm"
         "--enable-glx-tls"        ;Thread Local Storage, improves performance
         ;; "--enable-opencl"
         ;; "--enable-omx"
         "--enable-osmesa"
         "--enable-xa"

         ;; on non-intel systems, drop i915 and i965
         ;; from the default dri drivers
         ,@(match (%current-system)
             ((or "x86_64-linux" "i686-linux")
              '())
             (_
              '("--with-dri-drivers=nouveau,r200,radeon,swrast"))))
       #:phases (alist-cons-after
                 'unpack 'patch-create_test_cases
                 (lambda _
                   (substitute* "src/glsl/tests/lower_jumps/create_test_cases.py"
                     (("/usr/bin/env bash") (which "bash"))))
                 (alist-cons-before
                  'build 'fix-dlopen-libnames
                  (lambda* (#:key inputs outputs #:allow-other-keys)
                    (let ((s2tc (assoc-ref inputs "s2tc"))
                          (udev (assoc-ref inputs "udev"))
                          (out (assoc-ref outputs "out")))
                      ;; Remain agnostic to .so.X.Y.Z versions while doing
                      ;; the substitutions so we're future-safe.
                      (substitute*
                          '("src/gallium/auxiliary/util/u_format_s3tc.c"
                            "src/mesa/main/texcompress_s3tc.c")
                        (("\"libtxc_dxtn\\.so")
                         (string-append "\"" s2tc "/lib/libtxc_dxtn.so")))
                      (substitute* "src/gallium/targets/egl-static/egl_st.c"
                        (("\"libglapi\"")
                         (string-append "\"" out "/lib/libglapi\"")))
                      (substitute* "src/loader/loader.c"
                        (("dlopen\\(\"libudev\\.so")
                         (string-append "dlopen(\"" udev "/lib/libudev.so")))
                      (substitute* "src/glx/dri_common.c"
                        (("dlopen\\(\"libGL\\.so")
                         (string-append "dlopen(\"" out "/lib/libGL.so")))
                      (substitute* "src/egl/drivers/dri2/egl_dri2.c"
                        (("\"libglapi\\.so")
                         (string-append "\"" out "/lib/libglapi.so")))
                      (substitute* "src/gbm/main/backend.c"
                        ;; No need to patch the gbm_gallium_drm.so reference;
                        ;; it's never installed since Mesa removed its
                        ;; egl_gallium support.
                        (("\"gbm_dri\\.so")
                         (string-append "\"" out "/lib/dri/gbm_dri.so")))))
                  %standard-phases))))
    (home-page "http://mesa3d.org/")
    (synopsis "OpenGL implementation")
    (description "Mesa is a free implementation of the OpenGL specification -
a system for rendering interactive 3D graphics.  A variety of device drivers
allows Mesa to be used in many different environments ranging from software
emulation to complete hardware acceleration for modern GPUs.")
    (license l:x11)))

(define-public mesa-headers
  (package
    (inherit mesa)
    (name "mesa-headers")
    (propagated-inputs '())
    (inputs '())
    (native-inputs '())
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (delete 'build)
         (delete 'check)
         (replace 'install
                  (lambda* (#:key outputs #:allow-other-keys)
                    (copy-recursively "include" (string-append
                                                 (assoc-ref outputs "out")
                                                 "/include")))))))))

;;; The mesa-demos distribution contains non-free files, many files with no
;;; clear license information, and many demos that aren't useful for most
;;; people, so we just use this for the mesa-utils package below, and possibly
;;; other packages in the future.  This is modeled after Debian's solution.
(define (mesa-demos-source version)
  (origin
    (method url-fetch)
    (uri (string-append "ftp://ftp.freedesktop.org/pub/mesa/demos/" version
                        "/mesa-demos-" version ".tar.bz2"))
    (sha256 (base32 "14msj0prbl3ljwd24yaqv9pz1xzicdmqgg616xxlppbdh6syrgz4"))))

(define-public mesa-utils
  (package
    (name "mesa-utils")
    (version "8.2.0")
    (source (mesa-demos-source version))
    (build-system gnu-build-system)
    (inputs
     `(("mesa" ,mesa)
       ("glut" ,freeglut)
       ("glew" ,glew)))
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (arguments
     '(#:phases
       (modify-phases %standard-phases
         (replace
          'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let ((out (assoc-ref outputs "out")))
              (mkdir-p (string-append out "/bin"))
              (for-each
               (lambda (file)
                 (copy-file file (string-append out "/bin/" (basename file))))
               '("src/xdemos/glxdemo" "src/xdemos/glxgears"
                 "src/xdemos/glxinfo" "src/xdemos/glxheads"))))))))
    (home-page "http://mesa3d.org/")
    (synopsis "Utility tools for Mesa")
    (description
     "The mesa-utils package contains several utility tools for Mesa: glxdemo,
glxgears, glxheads, and glxinfo.")
    ;; glxdemo is public domain; others expat.
    (license (list l:expat l:public-domain))))

(define-public glew
  (package
    (name "glew")
    (version "1.11.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "mirror://sourceforge/glew/glew-"
                    version
                    ".tgz"))
              (sha256
               (base32
                "1mhkllxz49l1x680dmzrv2i82qjrq017sykah3xc90f2d8qcxfv9"))
              (modules '((guix build utils)))
              (snippet
               '(substitute* "config/Makefile.linux"
                  (("= cc") "= gcc")
                  (("/lib64") "/lib")))))
    (build-system gnu-build-system)
    (arguments
     '(#:phases (alist-delete 'configure %standard-phases)
       #:make-flags (list (string-append "GLEW_PREFIX="
                                         (assoc-ref %outputs "out"))
                          (string-append "GLEW_DEST="
                                         (assoc-ref %outputs "out")))
       #:tests? #f))                              ;no 'check' target
    (inputs
     `(("libxi" ,libxi)
       ("libxmu" ,libxmu)
       ("libx11" ,libx11)
       ("mesa" ,mesa)))

    ;; <GL/glew.h> includes <GL/glu.h>.
    (propagated-inputs `(("glu" ,glu)))

    (home-page "http://glew.sourceforge.net/")
    (synopsis "OpenGL extension loading library for C and C++")
    (description
     "The OpenGL Extension Wrangler Library (GLEW) is a C/C++ extension
loading library.  GLEW provides efficient run-time mechanisms for determining
which OpenGL extensions are supported on the target platform.  OpenGL core and
extension functionality is exposed in a single header file.")
    (license l:bsd-3)))

(define-public guile-opengl
  (package
    (name "guile-opengl")
    (version "0.1.0")
    (source (origin
             (method url-fetch)
             (uri (string-append "mirror://gnu/guile-opengl/guile-opengl-"
                                 version ".tar.gz"))
             (sha256
              (base32
               "13qfx4xh8baryxqrv986l848ygd0piqwm6s2s90pxk9c0m9vklim"))))
    (build-system gnu-build-system)
    (native-inputs `(("pkg-config" ,pkg-config)))
    (inputs `(("guile" ,guile-2.0)
              ("mesa" ,mesa)
              ("glu" ,glu)
              ("freeglut" ,freeglut)))
    (arguments
     '(#:phases (alist-cons-before
                 'build 'patch-dynamic-link
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (define (dynamic-link-substitute file lib input)
                     (substitute* file
                       (("dynamic-link \"lib([a-zA-Z]+)\"" _ lib)
                        (string-append "dynamic-link \""
                                       (assoc-ref inputs input)
                                       "/lib/lib" lib "\""))))
                   ;; Replace dynamic-link calls for libGL, libGLU, and
                   ;; libglut with absolute paths to the store.
                   (dynamic-link-substitute "glx/runtime.scm" "GL" "mesa")
                   (dynamic-link-substitute "glu/runtime.scm" "GLU" "glu")
                   (dynamic-link-substitute "glut/runtime.scm" "glut"
                                            "freeglut"))
                 %standard-phases)))
    (home-page "http://gnu.org/s/guile-opengl")
    (synopsis "Guile binding for the OpenGL graphics API")
    (description
     "Guile-OpenGL is a library for Guile that provides bindings to the
OpenGL graphics API.")
    (license l:lgpl3+)))

(define-public libepoxy
  (package
    (name "libepoxy")
    (version "1.2")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/anholt/libepoxy/archive/v"
                    version
                    ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1xp8g6b7xlbym2rj4vkbl6xpb7ijq7glpv656mc7k9b01x22ihs2"))))
    (arguments
     `(#:phases
       (alist-cons-after
        'unpack 'autoreconf
        (lambda _
          (zero? (system* "autoreconf" "-vif")))
        (alist-cons-before
         'configure 'patch-paths
         (lambda* (#:key inputs #:allow-other-keys)
           (let ((python (assoc-ref inputs "python"))
                 (mesa (assoc-ref inputs "mesa")))
             (substitute* "src/gen_dispatch.py"
               (("/usr/bin/env python") python))
             (substitute* (find-files "." "\\.[ch]$")
               (("libGL.so.1") (string-append mesa "/lib/libGL.so.1"))
               (("libEGL.so.1") (string-append mesa "/lib/libEGL.so.1")))

             ;; XXX On armhf systems, we must add "GLIBC_2.4" to the list of
             ;; versions in test/dlwrap.c:dlwrap_real_dlsym.  It would be
             ;; better to make this a normal patch, but for now we do it here
             ;; to prevent rebuilding on other platforms.
             ,@(if (string-prefix? "arm" (or (%current-target-system)
                                             (%current-system)))
                   '((substitute* '"test/dlwrap.c"
                       (("\"GLIBC_2\\.0\"") "\"GLIBC_2.0\", \"GLIBC_2.4\"")))
                   '())
             #t))
         %standard-phases))))
    (build-system gnu-build-system)
    (native-inputs
     `(("autoconf" ,autoconf)
       ("automake" ,automake)
       ("libtool" ,libtool)
       ("pkg-config" ,pkg-config)
       ("python" ,python)))
    (inputs
     `(("mesa" ,mesa)))
    (home-page "http://github.com/anholt/libepoxy/")
    (synopsis "A library for handling OpenGL function pointer management")
    (description
     "A library for handling OpenGL function pointer management.")
    (license l:x11)))

(define-public soil
  (package
    (name "soil")
    (version "1.0.7")
    (source (origin
              (method url-fetch)
              ;; No versioned archive available.
              (uri "http://www.lonesock.net/files/soil.zip")
              (sha256
               (base32
                "00gpwp9dldzhsdhksjvmbhsd2ialraqbv6v6dpikdmpncj6mnc52"))))
    (build-system gnu-build-system)
    (arguments
     '(#:tests? #f ; no tests
       #:phases (modify-phases %standard-phases
                  (delete 'configure)
                  (add-before 'build 'init-build
                    (lambda* (#:key outputs #:allow-other-keys)
                      (let ((out (assoc-ref outputs "out")))
                        (setenv "CFLAGS" "-fPIC") ; needed for shared library
                        ;; Use alternate Makefile
                        (copy-file "projects/makefile/alternate Makefile.txt"
                                   "src/Makefile")
                        (chdir "src")
                        (substitute* '("Makefile")
                          (("INCLUDEDIR = /usr/include/SOIL")
                           (string-append "INCLUDEDIR = " out "/include/SOIL"))
                          (("LIBDIR = /usr/lib")
                           (string-append "LIBDIR = " out "/lib"))
                          ;; Remove these flags from 'install' commands.
                          (("-o root -g root") ""))))))))
    (native-inputs
     `(("unzip" ,unzip)))
    (inputs
     `(("mesa" ,mesa)))
    (home-page "http://www.lonesock.net/soil.html")
    (synopsis "OpenGL texture loading library")
    (description
     "SOIL is a tiny C library used primarily for uploading textures into
OpenGL.")
    (license l:public-domain)))
