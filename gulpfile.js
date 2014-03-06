
var gulp = require('gulp');

var scripts = {
  page: 'index.html',
  main: 'src/bt.js',
  sources: ['src/**/*.js'],
  tests: ['test/**/*.js']
};

var copyright = 'Anders Nissen';

var dist = './dist/';

gulp.task('lint', function() {
  var jshint = require('gulp-jshint');
  var jshintStylish = require('jshint-stylish');
  var jscs = require('gulp-jscs');

  gulp.src(scripts.sources)
    .pipe(jshint())
    .pipe(jshint.reporter(jshintStylish))
    .pipe(jscs());
});

gulp.task('cover', function (cb) {
  var istanbul = require('gulp-istanbul');
  var mocha = require('gulp-mocha'); // Using mocha here, but any test framework will work

  gulp.src(scripts.sources)
    .pipe(istanbul()) // Covering files
    .on('end', function () {
      gulp.src(scripts.tests)
        .pipe(mocha())
        .pipe(istanbul.writeReports()) // Creating the reports after tests runned
        .on('end', cb);
    });
});

gulp.task('test', function () {
  var mocha = require("gulp-mocha");

  gulp.src(scripts.tests, { read: false })
    .pipe(mocha({ reporter: 'spec', growl: 'true' }));
});


gulp.task('build', function() {
  var browserify = require('gulp-browserify');
  var concat = require("gulp-concat");
  var header = require("gulp-header");
  var bytediff = require('gulp-bytediff');
  var rename = require("gulp-rename");
  var uglify = require("gulp-uglify");
  var license = require('gulp-license');
  var gutil = require("gulp-util");
  var notify = require("gulp-notify");

  gulp.src(scripts.main) // sources
    .pipe(browserify({
      //transform: ['es6ify']
      //debug: true /* source maps */ }
    }))
    .pipe(concat('index.js'))
    .pipe(rename('bundle.js'))
    .pipe(header('/* This is a header for ${name} version ${version}! */\n', { name: 'gulp test', version: '0.0.2' } ))
    .pipe(license('MIT', { tiny: false, organization: copyright }))
    .pipe(gulp.dest(dist + 'bundle'))
    .pipe(rename('bundle.min.js'))
    .pipe(bytediff.start())
    .pipe(uglify())
    .pipe(bytediff.stop())
    .pipe(header('/* This is a header for minified  ${name} version ${version}! */\n', { name: 'gulp test', version: '0.0.2' } ))
    .pipe(license('MIT', { tiny: true, organization: copyright }))
    .pipe(gulp.dest(dist + 'bundle'))
    .pipe(gutil.env.type === 'ci' ? gutil.noop() : notify({ message: 'build task completed' }));
});

gulp.task('watch', function() {
  gulp.watch(scripts.sources, ['test']);
});

gulp.task('sloc', function(){
  var sloc = require('gulp-sloc');

  gulp.src(scripts.sources)
    .pipe(sloc());
});

gulp.task('plato', function () {
  var plato = require('gulp-plato');

  gulp.src(scripts.sources)
    .pipe(plato('report'));
});

var lr = require('tiny-lr');
var server = lr();

gulp.task('dev-scripts', function() {
  var browserify = require('gulp-browserify');
  var concat = require('gulp-concat');
  var livereload = require('gulp-livereload');
  var util = require('gulp-util');
  
  gulp.src(scripts.main)
    .pipe(browserify({
      debug: true /*,
      transform: ['es6ify']
      */
    })).on('error', util.log)
    .pipe(concat('index.js'))
    .pipe(gulp.dest(dist + 'dev'))
    .pipe(livereload(server));
});

gulp.task('dev', function() {
  var port = 35729;
  server.listen(port, function(err) {
    if(err) return console.log(err);
    console.log('Listening on localhost:%s', port);
    console.log('Include <script src="http://localhost:35729/livereload.js"></script> in your HTML');

    gulp.watch([scripts.sources, scripts.page], ['dev-scripts']);
  });
});

gulp.task('bump', function() {
  var bump = require('gulp-bump');
  return gulp.src('package.json')
    .pipe(bump({ bump: 'patch' }))
    .pipe(gulp.dest('.'));
});

gulp.task('tag', function () {
  var pkg = require('./package.json');
  var v = 'v' + pkg.version;
  var message = 'Release ' + v;

  var git = require('gulp-git');
  return gulp.src('./')
    .pipe(git.commit(message))
    .pipe(git.tag(v, message))
    .pipe(git.push('origin', 'master', '--tags'))
    .pipe(gulp.dest('./'));
});

gulp.task('ci', [/*'lint',*/ 'test', 'build']);

// for sequential tasks: https://github.com/OverZealous/gulp-run-sequence
// for an improved watch task use: https://github.com/floatdrop/gulp-watch

gulp.task('default', function(){
  // place code for your default task here
});
