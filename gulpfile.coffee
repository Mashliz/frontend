#################################
############# include #############
#################################
gulp =        require "gulp"

slim =        require "gulp-slim"
htmlmin =     require "gulp-htmlmin"

compass =     require "gulp-compass"
please =      require "gulp-pleeease"
plumber =     require "gulp-plumber"

coffee =      require "gulp-coffee"
uglify =      require "gulp-uglify"
concat =      require "gulp-concat"

rename =      require "gulp-rename"
browsersync = require "browser-sync"


#################################
############# paths ############
#################################

st_root = "./"

assets  = "assets"

targets = 
  html:   "*.html"
  top:    "*.slim"
  pages:  "pages/*.slim"
  css:    "css/*.css"
  sass:   "#{assets}/css/sass/*.sass"
  js:     "#{assets}/js/*.js"
  coffee: "#{assets}/js/coffee/*.coffee"
  jsmod:  "#{assets}/js/mod/*.js"
  jslib:  "#{assets}/js/lib/*.js"

dirs =
  html:   st_root
  assets: "#{assets}"
  pages:  "pages"
  css:    "#{assets}/css"
  cssmin: "#{assets}/css/min"
  sass:   "#{assets}/css/sass"
  img:    "#{assets}/img"
  sprite: "#{assets}/img/sprite"
  js:     "#{assets}/js"
  jsmin:  "#{assets}/js/min"
  jsmod:  "#{assets}/js/mod"


#################################
############# sserver ##############
#################################

gulp.task "browser-sync", ->
  browsersync
    server:
      baseDir: st_root

#################################
############# wached ##############
#################################

gulp.task "top", ->
  gulp.src targets.top
    .pipe slim
      pretty: true
    .pipe gulp.dest dirs.html
    .pipe browsersync.reload
      stream: true
  return

gulp.task "pages", ->
  gulp.src targets.pages
    .pipe slim
      pretty: true
    .pipe gulp.dest dirs.pages
    .pipe browsersync.reload
      stream: true
  return

gulp.task "compass", ->
  gulp.src targets.sass
    .pipe plumber()
    .pipe compass
      css: dirs.css
      sass: dirs.sass
      image: dirs.img
    .pipe please
      autoprefixer: 
        "browsers": ["last 4 versions", "ios 6"]
    .pipe gulp.dest dirs.css
    .pipe browsersync.reload
      stream: true
  return

gulp.task "coffee", ->
  gulp.src targets.coffee
    .pipe plumber()
    .pipe coffee 
      bare: true
    .pipe gulp.dest dirs.jsmod
    .pipe browsersync.reload
      stream: true
  return

#################################
############# manual #############
#################################

gulp.task "minify", ->
  gulp.src targets.js
    .pipe jsmin()
    .pipe rename
      suffix: ".min"
    .pipe gulp.dest dirs.jsmin

  gulp.src targets.html
    .pipe htmlmin
      collapseWhitespace: true
    .pipe gulp.dest dirs.html

gulp.task "libc", ->
  gulp.src targets.jslib
    .pipe concat "lib.js"
    .pipe uglify()
    .pipe rename
      suffix: ".min"
    .pipe gulp.dest dirs.jsmin


#################################
############# waching #############
#################################

gulp.task "watch", ->
  gulp.watch targets.sass, ["compass"]
  gulp.watch targets.coffee, ["coffee"]
  gulp.watch targets.top, ["top"]
  gulp.watch targets.pages, ["pages"]


#################################
############# default #############
#################################

gulp.task "default", ["watch", "browser-sync"]