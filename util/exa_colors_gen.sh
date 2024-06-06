# this is a bit insane but it worked
# if i have to do this again im guna use go

# filetypes found here
# https://github.com/ogham/exa/blob/753150d3747e5ff1c9474bb3c2dd405fe55bb863/src/info/filetype.rs#L55

# NOTE: order matters for some reason

lack="38;2;112;128;144"
luster="38;2;222;238;237"
orange="38;2;255;170;136"
green="38;2;120;153;120"
blue="38;2;119;136;170"
red="38;2;215;0;0"
black="38;2;0;0;0"
gray1="38;2;8;8;8"
gray2="38;2;25;25;25"
gray3="38;2;42;42;42"
gray4="38;2;68;68;68"
gray5="38;2;85;85;85"
gray6="38;2;122;122;122"
gray7="38;2;170;170;170"
gray8="38;2;204;204;204"
gray9="38;2;221;221;221"

exa_group(){
  local result
  for item in "${@:2}"; do
    result+=":${item}=$1"
  done
  echo $result
}

exa_glob_group(){
  local result
  for item in "${@:2}"; do
    result+=":*.${item}=$1"
  done
  echo $result
}

# git
export EXA_COLORS="ga=$green:gd=$orange"
export EXA_COLORS="$EXA_COLORS$(exa_group $blue gm gv gt)"

# permissons
export EXA_COLORS="$EXA_COLORS$(exa_group $gray6 ur uw ux ue gr gw gx tr tw tx su sf xa)"

# size
export EXA_COLORS="$EXA_COLORS$(exa_group $gray5 df sb)"
export EXA_COLORS="$EXA_COLORS$(exa_group $gray7 sn)"

# owners
export EXA_COLORS="$EXA_COLORS$(exa_group $gray5 uu un gu gn)"

# date
export EXA_COLORS="$EXA_COLORS$(exa_group $gray6 da)" 



#control char
export EXA_COLORS="$EXA_COLORS:cc=$blue"

# special file 
export EXA_COLORS="$EXA_COLORS$(exa_group $orange bd cd pi)"

# file
export EXA_COLORS="$EXA_COLORS:fi=$gray8"

# link
export EXA_COLORS="$EXA_COLORS:ln=$lack"
export EXA_COLORS="$EXA_COLORS:lp=$lack"
export EXA_COLORS="$EXA_COLORS:B0=$red"

# dir
export EXA_COLORS="$EXA_COLORS:di=$gray5"

# text 
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray8 md txt json toml yaml js)"

# doc
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray8 djvu doc docx dvi eml eps fotd key odp odt pdf ppt pptx rtf xls xlsx)" 

# compiled
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 'class' 'elc' 'hi' 'o' 'pyc' 'zwc' 'ko')"

# immediate
export EXA_COLORS="$EXA_COLORS$(exa_group $gray8 'Makefile' 'Cargo.toml' 'SConstruct' 'CMakeLists.txt' 'build.gradle' 'pom.xml' 'Rakefile' 'package.json' 'Gruntfile.js' 'Gruntfile.coffee' 'BUILD' 'BUILD.bazel' 'WORKSPACE' 'build.xml' 'Podfile' 'webpack.config.js' 'meson.build' 'composer.json' 'RoboFile.php' 'PKGBUILD' 'Justfile' 'Procfile' 'Dockerfile' 'Containerfile' 'Vagrantfile' 'Brewfile' 'Gemfile' 'Pipfile' 'build.sbt' 'mix.exs' 'bsconfig.json' 'tsconfig.json' 'build.zig' 'build.zig.zon')"

# image 
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 arb bmp cbr cbz cr2 dvi eps gif heif ico jpeg jpg nef orf pbm pgm png pnm ppm ps raw stl svg tif tiff webp xpm)"

#  video
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 avi flv heic m2ts m2v mkv mov mp4 mpeg mpg ogm ogv ts vob webm wmv)"

# audio
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 aac alac ape flac m4a mka mp3 ogg opus wav wma)"

# crypto
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $orange asc enc gpg p12 pfx pgp sig signature)"

# archive
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 7z a ar bz2 deb dmg gz iso lzma par rar rpm tar tc tgz txz z Z zip zst)"

# temp
export EXA_COLORS="$EXA_COLORS$(exa_glob_group $gray6 bak bk swn swo swp tmp)"

# metadata
export EXA_COLORS="$EXA_COLORS$(exa_group $gray4 in bl hd)"
