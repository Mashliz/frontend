#################################
############# include #############
#################################
gulp =        require 'gulp'

plumber =     require 'gulp-plumber'
livereload =  require 'gulp-livereload'
compass =     require 'gulp-compass'
coffee =      require 'gulp-coffee'
slim =        require "gulp-slim"
gutil =       require 'gulp-util'
jsmin =       require 'gulp-jsmin'
cssmin =      require 'gulp-minify-css'
htmlmin =     require 'gulp-htmlmin'
rename =      require 'gulp-rename'
concat =      require 'gulp-concat'


#################################
############# paths ############
#################################

st_root = './'

targets = 
  html:   './*.html'
  top:    './*.slim'
  pages:  './pages/*.slim'
  css:    './assets/css/*.css'
  sass:   './assets/css/sass/*.sass'
  js:     './assets/js/*.js'
  coffee: './assets/js/coffee/*.coffee'
  jsmod:  './assets/js/mod/*.js'

dirs =
  html:   './'
  assets: './assets/'
  pages:  './pages/'
  css:    './assets/css/'
  sass:   './assets/css/sass/'
  img:    './assets/img/'
  sprite: './assets/img/sprite/'
  js:     './assets/js/'
  jsmod:  './assets/js/mod/'


#################################
############# wached ##############
#################################

gulp.task 'compass', ->
  gulp.src targets.sass
    .pipe plumber()
    .pipe compass
      css: dirs.css
      sass: dirs.sass
      image: dirs.img
    .on 'error', gutil.log
    .pipe gulp.dest dirs.assets
    .pipe livereload()
  return

gulp.task 'top', ->
  gulp.src targets.top
    .pipe slim
      pretty: true
    .pipe gulp.dest dirs.html
    .pipe livereload()
  return

gulp.task 'pages', ->
  gulp.src targets.pages
    .pipe slim
      pretty: true
    .pipe gulp.dest dirs.pages
    .pipe livereload()
  return

gulp.task 'html', ->
  gulp.src targets.html
    .pipe livereload()
  return

gulp.task 'coffee', ['concat'], ->
  gulp.src targets.coffee
    .pipe coffee 
      bare: true
    .on 'error', gutil.log
    .pipe gulp.dest dirs.jsmod
  return


#################################
############# manual  #############
#################################

gulp.task 'concat', ->
  gulp.src targets.jsmod
    .pipe concat 'all.js'
    .pipe gulp.dest dirs.js
  return

gulp.task 'minify', ->
  gulp.src targets.js
    .pipe jsmin()
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dirs.js
  gulp.src targets.css
    .pipe cssmin
      keepBreaks:true
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dirs.css
  gulp.src targets.html
    .pipe htmlmin
      collapseWhitespace: true
    .pipe gulp.dest dirs.html
  return


#################################
############# waching #############
#################################

gulp.task 'watch', ->
  gulp.watch targets.sass, ['compass']
  gulp.watch targets.coffee, ['coffee']
  gulp.watch targets.top, ['top']
  gulp.watch targets.pages, ['pages']


#################################
############# default #############
################################# 

gulp.task 'default', ['watch']