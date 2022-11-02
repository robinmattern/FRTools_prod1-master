#!/bin/bash

        aCmd="$1 $2 $3"

        aVer2="_v1"

        aCSSfile="main${aVer2}.css"

        aVer1=_v2-20530-master

        aCSSfile="index${aVer1}.css"
#       aCSSfile="main-navbar_v4.css"
        aCSSfile="index.css"

        aCSSfile="src/components.css"

# ----------------------------------------------------------

#      "Step 1c" # Add section titles and lines to shared_v1.css and main_v1.css
#      "Step 1h  # Add section titles and lines to index_v1.html

#      "Step 2h" # Comment out unsed sections on index_v1.html into index_v2.html
#      "Step 2c" # Remove unused styles from index_v1.css into index_v2.css

# aCmd="Step 3"  # Combine, format and rename class names into index_v2.css
#      "Step 3"  # Rename class names into into index_v2.html

# ----------------------------------------------------------

#       index_v0s.html          -- original with spacing to match ...
#       shared_v0s.css          --
#       main_v0s.css            --

#       index_v2-20530.html     -- Max's Original Class Names with Comment Titles and Lines
#       index_v2-20530.css      --

#       index_v3-20530.html     -- 8020's Modified Class Names with Comment Titles and Lines and Sections commented out
#       index_v3-20530.css      -- 8020's Modified Class Names with No Unused Styles

# -------------------------------------------------------------------------------

#  aCmd="Format CSS"  #

   if [ "${aCmd}" == "Format CSS" ]; then

        bDoit=1

#       aTS=$( date '+%y%m%d-%H%M' ); aTS="-${aTS:1}"
        aTS=$( date '+%y%m%d'      ); aTS="-${aTS:1}"

#       nRenClasses=0   # Don't rename anything
        nRenClasses=1   # Rename class names fFrom Max's to 8020's
#       nRenClasses=2   # Rename class names from 8020's to Max's

        aVer1="_v1"
        aVer2="_v2${aTS}"
        aVer3="_v3-20530-master"
        aVer4="_v4${aTS}"

#       declare -a mFilesIn=( "index${aVer4}.css"  "main-navbar${aVer4}.css"  "footer${aVer4}.css" )
#       declare -a mFilesIn=( "shared${aVer1}.css" "main${aVer1}.css" )
        declare -a mFilesIn=( "index${aVer3}.css" )

        declare -a mFilesIn=( "index.css" )

#                  aFileOut="index${aVer2}.css"
#                  aFileOut="index${aVer2}.css"
                   aFileOut="index${aVer4}.css"
        fi
# ----------------------------------------------------------

#  aCmd="Format HTML"  #
#       nRenClasses=1   # From Max's to 8020's
#       nRenClasses=2   # From 8020's to Max's

# -------------------------------------------------------------------------------


#  aCmd="Show Level 1"  #
#  aCmd="Show Level 2"  #
#  aCmd="Show Level 3"  #

#  echo "aCmd: ${aCmd}"

# ----------------------------------------------------------------------------------------------

   renClasses0='
function  renClass( a ) {
# return  NR ": " a
  return  a
          }'

# -----------------------------------------------------------------------------

   renClasses1='
function  renClass( a ) {
          sub( /\.backdrop/                 , ".backdrop"                 , a )
          sub( /\.button/                   , ".button"                   , a )
          sub( /\.main-footer__links/       , ".main-footer-links"        , a )
          sub( /\.main-footer__link/        , ".main-footer-link"         , a )
          sub( /\.main-footer/              , ".main-footer"              , a )
          sub( /\.main-header__brand/       , ".main-header-brand"        , a )
          sub( /\.main-header/              , ".main-header"              , a )
          sub( /\.main-nav__items/          , ".main-nav-items"           , a )
          sub( /\.main-nav__item--cta/      , ".main-nav-item-cta"        , a )
          sub( /\.main-nav__item/           , ".main-nav-item"            , a )
          sub( /\.main-nav/                 , ".main-nav"                 , a )
          sub( /\.mobile-nav__items/        , ".mobile-nav-items"         , a )
          sub( /\.mobile-nav__item/         , ".mobile-nav-item"          , a )
          sub( /\.mobile-nav__item--cta/    , ".mobile-nav-item-cta"      , a )
          sub( /\.mobile-nav/               , ".mobile-nav"               , a )
          sub( /\.open/                     , ".open"                     , a )
          sub( /\.toggle-button__bar/       , ".toggle-button-bar"        , a )
          sub( /\.toggle-button/            , ".toggle-button"            , a )

          sub( /#key-features/              , "#key-features"             , a )
          sub( /#product-overview/          , "#product-overview"         , a )
          sub( /\.key-feature__description/ , ".key-feature-description"  , a )
          sub( /\.key-feature__image/       , ".key-feature-image"        , a )
          sub( /\.key-feature__list/        , ".key-feature-list"         , a )
          sub( /\.key-feature/              , ".key-feature"              , a )
          sub( /\.modal__action--negative/  , ".modal-action-negative"    , a )
          sub( /\.modal__actions/           , ".modal-actions"            , a )
          sub( /\.modal__action/            , ".modal-action"             , a )
          sub( /\.modal__title/             , ".modal-title"              , a )
          sub( /\.modal/                    , ".modal"                    , a )
          sub( /\.plan__annotation/         , ".plan-annotation"          , a )
          sub( /\.plan__features/           , ".plan-features"            , a )
          sub( /\.plan__feature/            , ".plan-feature"             , a )
          sub( /\.plan__list/               , ".plan-list"                , a )
          sub( /\.plan__price/              , ".plan-price"               , a )
          sub( /\.plan__title/              , ".plan-title"               , a )
          sub( /\.plan--highlighted/        , ".plan-highlighted"         , a )
          sub( /\.plan/                     , ".plan"                     , a )
          sub( /\.section-title/            , ".section-title"            , a )
# return  NR ": " a
  return  a
          }'
# -----------------------------------------------------------------------------

   renClasses2='
function  renClass( a ) {
          sub( /\.backdrop/                 , ".backdrop"                  , a )
          sub( /\.button/                   , ".button"                    , a )
          sub( /\.main-footer-links/        , ".main-footer__links"        , a )
          sub( /\.main-footer-link/         , ".main-footer__link"         , a )
          sub( /\.main-footer/              , ".main-footer"               , a )
          sub( /\.main-header-brand/        , ".main-header__brand"        , a )
          sub( /\.main-header/              , ".main-header"               , a )
          sub( /\.main-nav-items/           , ".main-nav__items"           , a )
          sub( /\.main-nav-item-cta/        , ".main-nav__item--cta"       , a )
          sub( /\.main-nav-item/            , ".main-nav__item"            , a )
          sub( /\.main-nav/                 , ".main-nav"                  , a )
          sub( /\.mobile-nav-items/         , ".mobile-nav__items"         , a )
          sub( /\.mobile-nav-item/          , ".mobile-nav__item"          , a )
          sub( /\.mobile-nav-item-cta/      , ".mobile-nav__item--cta"     , a )
          sub( /\.mobile-nav/               , ".mobile-nav"                , a )
          sub( /\.open/                     , ".open"                      , a )
          sub( /\.toggle-button-bar/        , ".toggle-button__bar"        , a )
          sub( /\.toggle-button/            , ".toggle-button"             , a )

          sub( /#key-features/              , "#key-features"              , a )
          sub( /#product-overview/          , "#product-overview"          , a )
          sub( /\.key-feature-description/  , ".key-feature__description"  , a )
          sub( /\.key-feature-image/        , ".key-feature__image"        , a )
          sub( /\.key-feature-list/         , ".key-feature__list"         , a )
          sub( /\.key-feature/              , ".key-feature"               , a )
          sub( /\.modal-action-negative/    , ".modal__action--negative"   , a )
          sub( /\.modal-actions/            , ".modal__actions"            , a )
          sub( /\.modal-action/             , ".modal__action"             , a )
          sub( /\.modal-title/              , ".modal__title"              , a )
          sub( /\.modal/                    , ".modal"                     , a )
          sub( /\.plan-annotation/          , ".plan__annotation"          , a )
          sub( /\.plan-features/            , ".plan__features"            , a )
          sub( /\.plan-feature/             , ".plan__feature"             , a )
          sub( /\.plan-list/                , ".plan__list"                , a )
          sub( /\.plan-price/               , ".plan__price"               , a )
          sub( /\.plan-title/               , ".plan__title"               , a )
          sub( /\.plan-highlighted/         , ".plan--highlighted"         , a )
          sub( /\.plan/                     , ".plan"                      , a )
          sub( /\.section-title/            , ".section-title"             , a )
# return  NR ": " a
  return  a
          }'
# ----------------------------------------------------------------------------------------------

#   echo "${renClasses}" >renClasses.awk

# ----------------------------------------------------------------------------------------------

     if [ "${aCmd}" = "Format HTML" ]; then

#       nRenClasses=1   # From Max's to 8020's
#       nRenClasses=2   # From 8020's to Max's

   if [ "${nRenClasses}" == "0" ]; then renClasses="${renClasses0}"; fi
   if [ "${nRenClasses}" == "1" ]; then renClasses="${renClasses1}"; fi
   if [ "${nRenClasses}" == "2" ]; then renClasses="${renClasses2}"; fi

# -------------------------------------------------------------------------------

   fmtHTML='
function prnt1( a ) {
         n = match( a, /:/ );
         b = substr( a, n + 1 ); sub( /^ +/, "", b ); b = ( match( b, /^[-"#]/ ) ? "" : " " ) b
         aFmt = (n < 17) ? "%-15s" : "%-25s"
# return sprintf( aFmt " : %s\n", substr( a, 1, n-1 ), b
         printf   aFmt " : %s\n", substr( a, 1, n-1 ), b
         }
'$( echo "${renClasses}" )'

BEGIN{ }
     /^[:@]/    {                   print;                next }
     /^\/\*\* / {                   print NR ": " $0;     next }
     /^ *[\.#]/ { sub( /^ +/, "" ); print renClass( $0 ); next }
     /^ *\/\* / { sub( /^ +/, "" ); sub( /\/\* */, "/*  "); prnt1( $0 ); next }
     /^ *--/    { sub( /^ +/, "" ); prnt1( "  "     $0 ); next }
     /^ *}/     { sub( /^ +/, "" ); print  "    "   $0;   next }
     /:/        { sub( /^ +/, "" ); prnt1( "    "   $0 ); next }
#               { sub( /^ +/, "" ); print           $0 }
                {                   print           $0 }
END{ }'

# -------------------------------------------------------------------------------

#         fmtCSS="${fmtCSS/{renCLasses}/${renClasses}}"
# echo "${fmtCSS}"; exit
  echo "${fmtCSS}" >fmtCSS.awk;  # exit

#       aTS=$( date '+%y%m%d-%H%M' ); aTS="-${aTS:1}"
        aTS=$( date '+%y%m%d'      ); aTS="-${aTS:1}"

#       cat index_v1.html | awk "${fmtHTML}"    >> index_v2${aTS}.html

        echo "  Done"

        exit

        fi  # eif
# --------------------------------------------------------------------------------------------

     if [ "${aCmd}" = "Format CSS" ]; then

#       nRenClasses=1   # From Max's to 8020's
#       nRenClasses=2   # From 8020's to Max's

   if [ "${nRenClasses}" == "0" ]; then renClasses="${renClasses0}"; aDir="rename:none"; fi
   if [ "${nRenClasses}" == "1" ]; then renClasses="${renClasses1}"; aDir="rename:Max-to-8020"; fi
   if [ "${nRenClasses}" == "2" ]; then renClasses="${renClasses2}"; aDir="rename:8020-to-Max"; fi

# -------------------------------------------------------------------------------

   fmtCSS='
function  prnt1( a ) {
          sub( / *:/, ":", a )
          n = match( a, /:/ ); if (n == 0) { print a; return }
          b = substr( a, n + 1 ); sub( /^ +/, "", b ); b = ( match( b, /^[-"#]/ ) ? "" : " " ) b

          aFmt = (n < 17) ? "%-15s" : "%-19s"

#  return sprintf( aFmt " : %s\n", substr( a, 1, n-1 ), b
          printf   aFmt " : %s\n", substr( a, 1, n-1 ), b
          }
'$( echo "${renClasses}" )'

BEGIN{ }
     /^[:@]/ {                      print;                next }
     /^\/\*\* / {                   print $0;             next }
     /^\/\*  -/ {                   print $0;             next }
     /^ *[.#]/  { sub( /^ +/, "" ); print renClass( $0 ); next }
     /^ *\/\* / { sub( /^ +/, "" ); sub( /\/\* */, "/*  " ); prnt1( $0 ); next }
     /^ *--/    { sub( /^ +/, "" ); prnt1( "  "     $0 ); next }
     /^ *}/     { sub( /^ +/, "" ); print  "    "   $0;   next }
     /:/        { sub( /^ +/, "" ); prnt1( "    "   $0 ); next }
#               { sub( /^ +/, "" ); print           $0 }
                {                   print           $0 }
END{ }'

# -------------------------------------------------------------------------------

#         fmtCSS="${fmtCSS/{renCLasses}/${renClasses}}"
# echo "${fmtCSS}"; exit
  echo "${fmtCSS}" >fmtCSS.awk;  # exit

          echo ""
       if [ -f "${aFileOut}" ]; then rm "${aFileOut}"; fi

          touch        "${aFileOut}"; # exit
#         echo "Files: ${#mFilesIn}"

   for (( i=0; i < ${#mFilesIn}; i++ )); do
       if [ "${mFilesIn[$i]}" != "" ]; then
#         printf "%2d %15s %99s", ${i}, "cat '${mFilesIn[$i]}'",                       "| awk -f fmtCSS.awk  >>\"${aFileOut}\""
          echo "${i}      '${mFilesIn[$i]}'" | awk '{ printf "%2d %-25s %s\n", $1, $2, "| awk -f fmtCSS.awk >>\"'${aFileOut}'\" ('${aDir}')" }'
#         echo "${i}: cat '${mFilesIn[$i]}'                                             | awk -f fmtCSS.awk  >>\"${aFileOut}\""

   if [ "${bDoit}" == "1" ]; then
                      cat "${mFilesIn[$i]}"  | awk "${fmtCSS}"  >> "${aFileOut}"
#                     cat "${mFilesIn[$i]}"  | awk "${fmtCSS}"
          fi; fi
          done

#       cat index${aVer1}.css                    >"${aCSSfile}"
#       cat main-navbar${aVer1}.css             >>"${aCSSfile}"
#       cat footer${aVer1}.css                  >>"${aCSSfile}"

# echo "cat shared_v1.css | awk -f  fmtCSS.awk"
#       cat shared_v1.css | awk -f  fmtCSS.awk   > shared_v2${aTS}.css; exit

#       cat shared_v1.css | awk "${fmtCSS}"      > index_v2${aTS}.css
#       cat main_v1.css   | awk "${fmtCSS}"     >> index_v2${aTS}.css

        echo "    Done"

        exit

        fi
# --------------------------------------------------------------------------------------------

     if [ "${aCmd}" = "Show Level 1" ]; then

#                                     Before File Name              ;    File & Section Name
        cat "${aCSSfile}"  | awk '/\/\*\* =/ { print "\n" $0; next }; /\/\*\* /  { print      $0; next }'
        fi
#  ------------------------------------------------------------------

     if [ "${aCmd}" = "Show Level 2" ]; then

#                                     Before File Name              ;    File & Section Name            ;                                  ;   Section Line
        cat "${aCSSfile}"  | awk '/\/\*\* =/ { print "\n" $0; next }; /\/\*\* /  { print      $0; next };                                    /\/\*   -/ { print }'
        fi
#  ------------------------------------------------------------------

     if [ "${aCmd}" = "Show Level 3" ]; then

#                                     Before File Name              ;    Section Name                   ;       File Name                  ;   Section Line      ;                        Selector Name
#       cat "${aCSSfile}"  | awk '/\/\*\* =/ { print "\n" $0; next }; /\/\*\*  / { print      $0; next }; /\/\*\* / { print "\n" $0       }; /\/\*  -/  { print }; /{/ { a = (1 == match( $0, "[.#@:*]" ) ? "" : " " ); sub( /{.*/, "" ); print "    " a $0 }'
        cat "${aCSSfile}"  | awk '/\/\*\* =/ { print "\n" $0; next }; /\/\*\*  / { print "\n" $0; next }; /\/\*\* / { print      $0; next }; /\/\*   -/ { print }; /{/ { a = (1 == match( $0, "[.#@:*]" ) ? "" : " " ); sub( /{.*/, "" ); print "    " a $0 }'
#       cat "${aCSSfile}"  | awk '/\/\*\* =/ { print "\n" $0; next }; /\/\*\* /                        || /\/\*  -/                                         ; /{/ {                                                     sub( /{.*/, "" ); print "    "   $0 }'
        fi
#  ------------------------------------------------------------------
# --------------------------------------------------------------------------------------------


#  index_v0.html        - Original
#  index_v1.html        - Section comments & lines
#  index_v2.html        - Unused code commented out
#  index_v3.html        - Clean new version
#  index_v4.html        - Change comments

#  ------------------------------------------------------------------

#  shared_v0.css        - Original css
#  main_v0.css          - Original css
#  index_v0.html        - Original html

#  main_v1.css          - Combined with section comments & lines
#  index_v1.html        - Renamed with section comments and lines

#  main_v1.css          - Reformatted, Renamed and Combined with section comments & lines
#  index_v1.html        - Renamed with section comments and lines


#  index_v1.css         - Split with section comments & lines
#  main-navbar_v1.css   - Split with section comments & lines
#  footer_v1.css        - Split with section comments & lines


#  index_v2.css         - Unused code commented removed
#  index_v3.css         - Clean new version
#  index_v4.css         - Change comments

# --------------------------------------------------------------------------------------------
