#################################
############# include #############
#################################
gulp = require 'gulp'
prefix = require 'gulp-autoprefixer'
plumber = require 'gulp-plumber'
livereload = require 'gulp-livereload'
connect = require 'connect'
compass = require 'gulp-compass'
coffee = require 'gulp-coffee'
slim = require "gulp-slim"
gutil = require 'gulp-util'
jsmin = require 'gulp-jsmin'
cssmin = require 'gulp-minify-css'
htmlmin = require 'gulp-htmlmin'
rename = require 'gulp-rename'
concat = require 'gulp-concat'

#################################
############# filepath ############
#################################
paths = 
  html: './*.html'
  top: './*.slim'
  pages: './pages/*.slim'
  lib: './libs/*.js'
  scss: './assets/*.scss'
  css:'./assets/*.css'
  coffee: './assets/*.coffee'
  js: './assets/*.js'

#################################
############# sserver #############
#################################
gulp.task 'server', (next)-> 
  server = connect()
  server.use connect.static './'
  .listen process.env.PORT || 8080, next

#################################
############# wached ##############
#################################
gulp.task 'compass', ->
  gulp.src paths.scss
    .pipe plumber() 
    .pipe compass
      css: './assets'
      sass: './assets'
    .pipe gulp.dest "./assets"
    .pipe livereload() 

gulp.task 'top', ->
  gulp.src paths.top
    .pipe slim
      pretty: true
    .pipe gulp.dest "./"
    .pipe livereload()

gulp.task 'pages', ->
  gulp.src paths.pages
    .pipe slim
      pretty: true
    .pipe gulp.dest "./pages/"
    .pipe livereload()

gulp.task 'html', ->
  gulp.src paths.html
    .pipe livereload()

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee 
      bare: true
    .on 'error', gutil.log
    .pipe gulp.dest './assets/'
    .pipe livereload()

gulp.task 'js', ->
  gulp.src paths.js
    .pipe livereload()
    
#################################
############# manual  #############
#################################
gulp.task 'concat', ->
  gulp.src paths.lib
    .pipe concat 'lib.js'
    .pipe gulp.dest './lib/'

gulp.task 'prefix', ->
  gulp.src paths.css 
    .pipe prefix ["last 1 version", "> 1%", "ie 8", "ie 7" ], cascade: true
    .pipe gulp.dest './css/'

gulp.task 'minify', ->
  gulp.src paths.js
    .pipe jsmin()
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest './js/'
  gulp.src paths.css
    .pipe cssmin
      keepBreaks:true
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest './css/'
  gulp.src paths.html
    .pipe htmlmin
      collapseWhitespace: true
    .pipe gulp.dest './'

#################################
############# waching #############
#################################
gulp.task 'watch', ->
  gulp.watch paths.js, ['js']
  gulp.watch paths.scss, ['compass']
  gulp.watch paths.coffee, ['coffee']
  gulp.watch paths.top, ['top']
  gulp.watch paths.pages, ['pages']

#################################
############# default #############
################################# 
gulp.task 'default', ['server', 'watch']


