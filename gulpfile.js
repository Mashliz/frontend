var gulp = require('gulp'),
    autoprefixer = require('gulp-autoprefixer'),
    plumber = require('gulp-plumber'),
    livereload = require('gulp-livereload'),
    connect = require('connect'),
    compass = require('gulp-compass'),
    coffee = require('gulp-coffee'),
    slim = require("gulp-slim"),
    gutil = require('gulp-util'),
    concat = require('gulp-concat');

var paths = {
  html: ['./*.html'],
  scss: ['./scss/*.scss'],
  coffee: ['./js/*.coffee'],
  js: ['./js/*.js'],
  slim: ['./*.slim']
};
  
gulp.task('server', function(next) {
  var server = connect();
  server.use(connect.static('./')).listen(process.env.PORT || 8080, next);
});
  
gulp.task('compass', function() {
  gulp.src(paths.scss)
    .pipe(plumber())
    .pipe(compass({
      config_file: './config.rb',
      css: 'css',
      sass: 'scss'
    }))
    .pipe(livereload());
});
 
gulp.task('slim', function(){
  gulp.src(paths.slim)
    .pipe(slim({
      pretty: true
    }))
    .pipe(gulp.dest("./"))
    .pipe(livereload());
});

gulp.task('scripts', function() {
  gulp.src('./lib/*.js')
    .pipe(concat('lib.js'))
    .pipe(gulp.dest('./js/'));
});
  
gulp.task('html', function () {
  gulp.src(paths.html)
    .pipe(livereload());
});

gulp.task('coffee', function() {
  gulp.src(paths.coffee)
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./js/'))
    .pipe(livereload());
});

gulp.task('js', function() {
  gulp.src(paths.coffee)
    .pipe(livereload());
})
  
gulp.task('watch', function() {
  gulp.watch(paths.js, ['js']);
  gulp.watch(paths.scss, ['compass']);
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.slim, ['slim']);  
});
  
gulp.task('default', ['server', 'watch']);
  