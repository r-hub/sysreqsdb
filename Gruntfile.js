'use strict';

module.exports = function (grunt) {

  // -----------------------------------------------------------

  grunt.loadNpmTasks('grunt-jsonlint');
  grunt.loadNpmTasks('grunt-tv4');

  grunt.initConfig({

    jsonlint: {
      sample: {
        src: [ 'cran/*.json', 'platforms/*.json', 'sysreqs/*.json' ]
      }
    },

    "tv4-sysreq": {
        options: {
            root: grunt.file.readJSON('schema-sysreq.json')
        },
        myTarget: {
            src: [ 'sysreqs/*.json' ]
        }
    },

    "tv4-platform": {
        options: {
            root: grunt.file.readJSON('schema-platform.json')
        },
        myTarget: {
            src: [ 'platforms/*.json' ]
        }
    }
      
  });

  // Default task.
  grunt.registerTask(
    'default',
    [ 'jsonlint', 'tv4-sysreq', 'tv4-platform' ]);

  // Travis CI task.
  grunt.registerTask(
    'travis',
    [ 'jsonlint', 'tv4-sysreq', 'tv4-platform' ]);
};
