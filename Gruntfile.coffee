'use strict'

module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  production = process.env.GRUNT_ENV is 'production'

  if production
    grunt.registerTask 'default', [ 'copy', 'stylus', 'coffee', 'jade', 'requirejs' ]
  else
    grunt.registerTask 'default', [ 'copy', 'stylus', 'coffee', 'jade', 'watch' ]

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    copy:
      release:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '**/*', '!**/*.{coffee,styl,jade}' ]
          dest: 'public'
          filter: 'isFile'
        }]

    coffee:
      options:
        sourceMap: yes
      release:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ '*.coffee', '**/*.coffee' ]
          dest: 'public'
          ext: '.js'
        }]

    stylus:
      options:
        compress: yes
      release:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ 'css/app.styl' ]
          dest: 'public'
          ext: '.css'
        }]

    jade:
      options:
        data:
          version: '<%= pkg.version %>'
      release:
        files: [{
          expand: yes
          cwd: 'assets'
          src: [ 'index.jade' ]
          dest: 'public'
          ext: '.html'
        }]

    # minifier

    requirejs:
      release:
        options:
          baseUrl: 'public/js/app'
          mainConfigFile: 'public/js/config.js'
          out: 'public/js/app.js'
          include: [ '../production', '../config' ]
          optimize: 'uglify2'
          wrap: yes
          name: '../lib/almond'
          skipModuleInsertion: no
          generateSourceMaps: yes
          preserveLicenseComments: no

    # continuous

    watch:
      options:
        livereload: yes
        interrupt: yes
      static:
        tasks: [ 'copy' ]
        files: [ 'assets/**/*', '!assets/**/*.{coffee,styl,jade}' ]
      coffee:
        tasks: if production then [ 'coffee', 'requirejs' ] else [ 'coffee' ]
        files: [ 'assets/**/*.coffee' ]
      stylus:
        tasks: [ 'stylus' ]
        files: [ 'assets/**/*.styl' ]
      jade:
        tasks: [ 'jade' ]
        files: [ 'assets/**/*.jade' ]

