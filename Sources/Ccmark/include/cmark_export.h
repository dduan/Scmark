
#ifndef CMARK_EXPORT_H
#define CMARK_EXPORT_H

#ifdef CMARK_STATIC_DEFINE
#  define CMARK_EXPORT
#  define CMARK_NO_EXPORT
#else
#  ifndef CMARK_EXPORT
#    ifdef libcmark_EXPORTS
        /* We are building this library */
#      define CMARK_EXPORT __attribute__((visibility("default")))
#    else
        /* We are using this library */
#      define CMARK_EXPORT __attribute__((visibility("default")))
#    endif
#  endif

#  ifndef CMARK_NO_EXPORT
#    define CMARK_NO_EXPORT __attribute__((visibility("hidden")))
#  endif
#endif
#endif /* CMARK_EXPORT_H */
