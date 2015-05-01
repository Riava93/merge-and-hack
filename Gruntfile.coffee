# Generated on 2014-07-06 using generator-angular 0.9.1

module.exports = (grunt) ->

  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt)

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt)

  # Define the configuration for all the tasks
  grunt.initConfig({

  # Project settings
    config: grunt.file.readJSON './config.json'
    dir:
      tmp: '.tmp'
      app: 'app'
      game: 'game'
      dist: 'out'
      test: 'test'

    aws_s3:
      options:
        accessKeyId: '<%= config.accessKeyId %>'
        secretAccessKey: '<%= config.secretAccessKey %>'
        region: 'us-east-1'
      deploy:
        options:
          bucket: '<%= config.bucketName %>'
          differential: true
        files: [{
          action: 'upload'
          expand: true
          cwd: '<%= dir.dist %>'
          src: ['**']
          dest: '/'
        }]

    bower_concat:
      all:
        exclude: [],
        dest: '<%= dir.tmp %>/bower.js'

    connect:
      options:
        port: 9000,
        # Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost'
        livereload: 35729
      livereload:
        options:
          open: true,
          middleware: (connect) ->
            return [
              connect.static 'out'
            ]

    coffee:
      main:
        options:
          bare: yes
        files:
          '<%= dir.tmp %>/app.js': [
            '<%= dir.app %>/app.coffee',
            '<%= dir.app %>/**/**.coffee'
          ]

    concat:
      sass:
        src: ['<%= dir.app %>/_config/**.sass', '<%= dir.app %>/app.sass', '<%= dir.app %>/**/**.sass'],
        dest: '<%= dir.tmp %>/app.sass'
      js:
        src: [
          '<%= dir.tmp %>/game.js',
          '<%= dir.tmp %>/bower.js',
          '<%= dir.tmp %>/app.js'
        ],
        dest: '<%= dir.dist %>/app.js'

    copy:
      html:
        src: '<%= dir.app %>/index.html'
        dest: '<%= dir.dist %>/index.html'

    compass:
      options:
        sassDir: '<%= dir.tmp %>'
        cssDir: '<%= dir.dist %>'
        generatedImagesDir: '<%= dir.tmp %>/images/generated'
        imagesDir: '<%= dir.app %>/images'
        javascriptsDir: '<%= dir.app %>'
        importPath: './bower_components'
        httpImagesPath: '/images'
        httpGeneratedImagesPath: '/images/generated'
        httpFontsPath: '/styles/fonts'
        relativeAssets: false
        assetCacheBuster: false
        raw: 'Sass::Script::Number.precision = 10\n'
      main:
        options:
          generatedImagesDir: '<%= dir.dist %>/images/generated'

    shell:
      browserify:
        command: 'npm run browserify'

    watch:
      app:
        files: ['<%= dir.app %>/**/**.coffee'],
        tasks: ['coffee', 'concat:js'],
        options:
          livereload: '<%= connect.options.livereload %>'

      compass:
        files: ['<%= dir.app %>/**/**.sass'],
        tasks: ['concat:sass', 'compass']
        options:
          livereload: '<%= connect.options.livereload %>'

      game:
        files: ['<%= dir.game %>/**/**.coffee'],
        tasks: ['shell:browserify', 'concat:js'],
        options:
          livereload: '<%= connect.options.livereload %>'

      html:
        files: ['<%= dir.app %>/index.html'],
        tasks: ['copy:html'],
        options:
          livereload: '<%= connect.options.livereload %>'
  })

  grunt.registerTask 'default', [
    'build'
    'connect'
    'watch'
  ]

  grunt.registerTask 'build', [
    'bower_concat'
    'shell:browserify'
    'coffee'
    'concat:js'
    'concat:sass'
    'compass'
    'copy:html'
  ]

  grunt.registerTask 'deploy', [
    'build'
    'aws_s3'
  ]
