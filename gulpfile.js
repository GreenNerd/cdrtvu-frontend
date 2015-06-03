var gulp = require("gulp");
var config = require('./config.json');
var coffee = require('gulp-coffee');
var sass = require('gulp-sass');
var jade = require('gulp-jade');
var jadeGlob = require('gulp-jade-globbing');
var path = require('path');
var watch = config.development.watch;
var exec = require('child_process').exec;

function compileCoffee(source) {
  gulp
    .src(source, {base: '.' + watch.coffee.sourceDir})
    .pipe(coffee(watch.coffee.options))
    .pipe(gulp.dest('.' + watch.coffee.targetDir));
};

function compileSass(source) {
  gulp
    .src(source, {base: '.' + watch.sass.sourceDir})
    .pipe(sass())
    .pipe(gulp.dest('.' + watch.sass.targetDir));
};

function compileJade(source) {
  gulp
    .src(source, {base: '.' + watch.jade.sourceDir})
    .pipe(jadeGlob())
    .pipe(jade(watch.jade.options))
    .pipe(gulp.dest('.' + watch.jade.targetDir))
};

gulp.task("watchcoffee", function(){
  gulp.watch('.' + watch.coffee.sourceDir + '/**/*.coffee', function(event){
    var changedPath = './' + path.relative(process.cwd(), event.path);
    console.log('File ' + changedPath + ' was ' + event.type + ', running task compile coffee');
    compileCoffee(changedPath);
  });
});

gulp.task('watchsass', function(){
  gulp.watch('.' + watch.sass.sourceDir + '/**/*.scss', function(event){
    var changedPath = './' + path.relative(process.cwd(), event.path);
    console.log('File ' + changedPath + ' was ' + event.type + ', running tast compile sass');
    compileSass('./src/stylesheets/index.scss');
  });
});

gulp.task('watchjade', function(){
  gulp.watch('.' + watch.jade.sourceDir + '/**/*.jade', function(event){
    var changedPath = './' + path.relative(process.cwd(), event.path);
    console.log('File ' + changedPath + ' was ' + event.type + ', running task compile jade');
    compileJade('./src/templates/index.jade');
    compileJade('./src/templates/FAQ.jade');
    compileJade('./src/templates/category.jade');
    compileJade('./src/templates/page.jade');
    compileJade('./src/templates/aboutme.jade');
  });
});

gulp.task('default', ['watchjade', 'watchsass', 'watchcoffee']);
