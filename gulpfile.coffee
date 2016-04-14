require('gulp-lazyload')
  gulp:       'gulp'
  connect:    'gulp-connect'
  concat:     'gulp-concat'
  coffee:     'gulp-coffee'
  preprocess: 'gulp-preprocess'
  iife:       'gulp-iife-wrap'
  uglify:     'gulp-uglify'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'

gulp.task 'default', ['build', 'watch'], ->

dependencies = [{require: 'jquery', global: '$'}]

gulp.task 'build', ->
  gulp.src('source/jquery-transform.coffee')
  .pipe plumber()
  .pipe preprocess()
  .pipe iife({dependencies})
  .pipe concat('jquery-transform.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('jquery-transform.js')
  .pipe gulp.dest('build')

gulp.task 'build-min', ->
  gulp.src('build/jquery-transform.js')
  .pipe uglify()
  .pipe rename('jquery-transform.min.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']