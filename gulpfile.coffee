#################################
############# include #############
#################################
gulp =        require 'gulp'

plumber =     require 'gulp-plumber'
livereload =  require 'gulp-livereload'
compass =     require 'gulp-compass'
coffee =      require 'gulp-coffee'
slim =        require "gulp-slim"
jsmin =       require 'gulp-jsmin'
cssmin =      require 'gulp-minify-css'
htmlmin =     require 'gulp-htmlmin'
rename =      require 'gulp-rename'
concat =      require 'gulp-concat'
prefix =      require 'gulp-autoprefixer'


#################################
############# paths ############
#################################

st_root = './'

targets = 
  html:   '*.html'
  top:    '*.slim'
  pages:  'pages/*.slim'
  css:    'assets/css/*.css'
  sass:   'assets/css/sass/*.sass'
  js:     'assets/js/*.js'
  coffee: 'assets/js/coffee/*.coffee'
  jsmod:  'assets/js/mod/*.js'

dirs =
  html:   st_root
  assets: 'assets/'
  pages:  'pages/'
  css:    'assets/css/'
  cssmin: 'assets/css/min/'
  sass:   'assets/css/sass/'
  img:    'assets/img/'
  sprite: 'assets/img/sprite/'
  js:     'assets/js/'
  jsmin:  'assets/js/min/'
  jsmod:  'assets/js/mod/'


#################################
############# wached ##############
#################################

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

gulp.task 'compass', ->
  gulp.src targets.sass
    .pipe plumber()
    .pipe compass
      css: dirs.css
      sass: dirs.sass
      image: dirs.img

gulp.task 'pfix', ['compass'], ->
  gulp.src targets.css
    .pipe prefix()
    .pipe gulp.dest dirs.css
    .pipe livereload()
  return

gulp.task 'coffee', ->
  gulp.src targets.coffee
    .pipe coffee 
      bare: true
    .pipe gulp.dest dirs.jsmod

gulp.task 'concat', ['coffee'], ->
  gulp.src targets.jsmod
    .pipe concat 'all.js'
    .pipe gulp.dest dirs.js
  return


#################################
############# manual #############
#################################

gulp.task 'minify', ->
  gulp.src targets.js
    .pipe jsmin()
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dirs.jsmin
  gulp.src targets.css
    .pipe cssmin
      keepBreaks:true
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dirs.cssmin
  gulp.src targets.html
    .pipe htmlmin
      collapseWhitespace: true
    .pipe gulp.dest dirs.html


#################################
############# waching #############
#################################

gulp.task 'watch', ->
  gulp.watch targets.sass, ['compass', 'pfix']
  gulp.watch targets.coffee, ['coffee', 'concat']
  gulp.watch targets.top, ['top']
  gulp.watch targets.pages, ['pages']


#################################
############# default #############
################################# 

gulp.task 'default', ['watch']