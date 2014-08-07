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
############# paths ############
#################################

st_root = './'

targets = 
  html: './*.html'
  top: './*.slim'
  pages: './pages/*.slim'
  lib: './libs/*.js'
  scss: './assets/*.scss'
  css:'./assets/*.css'
  coffee: './assets/*.coffee'
  js: './assets/*.js'

dests =
  html: './'
  assets: './assets'
  pages: './pages/'
  css: './css/'
  js: './js/'
  lib: './lib/'


#################################
############# sserver #############
#################################

gulp.task 'server', (next)-> 
  server = connect()
  server.use connect.static st_root
  .listen process.env.PORT || 8080, next


#################################
############# wached ##############
#################################

gulp.task 'compass', ->
  gulp.src targets.scss
    .pipe plumber() 
    .pipe compass
      css: './assets'
      sass: './assets'
    .pipe gulp.dest dests.assets
    .pipe livereload() 

gulp.task 'top', ->
  gulp.src targets.top
    .pipe slim
      pretty: true
    .pipe gulp.dest dests.html
    .pipe livereload()

gulp.task 'pages', ->
  gulp.src targets.pages
    .pipe slim
      pretty: true
    .pipe gulp.dest dests.pages
    .pipe livereload()

gulp.task 'html', ->
  gulp.src targets.html
    .pipe livereload()

gulp.task 'coffee', ->
  gulp.src targets.coffee
    .pipe coffee 
      bare: true
    .on 'error', gutil.log
    .pipe gulp.dest dests.assets
    .pipe livereload()

gulp.task 'js', ->
  gulp.src targets.js
    .pipe livereload()
  

#################################
############# manual  #############
#################################

gulp.task 'concat', ->
  gulp.src targets.lib
    .pipe concat 'lib.js'
    .pipe gulp.dest dests.lib

gulp.task 'prefix', ->
  gulp.src targets.css 
    .pipe prefix ["last 1 version", "> 1%", "ie 8", "ie 7" ], cascade: true
    .pipe gulp.dest dests.css

gulp.task 'minify', ->
  gulp.src targets.js
    .pipe jsmin()
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dests.js
  gulp.src targets.css
    .pipe cssmin
      keepBreaks:true
    .pipe rename
      suffix: '.min'
    .pipe gulp.dest dests.css
  gulp.src targets.html
    .pipe htmlmin
      collapseWhitespace: true
    .pipe gulp.dest dests.html


#################################
############# waching #############
#################################

gulp.task 'watch', ->
  gulp.watch targets.js, ['js']
  gulp.watch targets.scss, ['compass']
  gulp.watch targets.coffee, ['coffee']
  gulp.watch targets.top, ['top']
  gulp.watch targets.pages, ['pages']


#################################
############# default #############
################################# 

gulp.task 'default', ['server', 'watch']


