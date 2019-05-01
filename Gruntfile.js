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

    tv4: {
        options: {
            root: grunt.file.readJSON('schema-sysreq.json')
        },
        myTarget: {
            src: [ 'sysreqs/*.json' ]
        }
    }

  });

  // Default task.
  grunt.registerTask('default', [ 'jsonlint', 'tv4' ]);

  // Travis CI task.
  grunt.registerTask('travis', [ 'jsonlint', 'tv4' ]);
};
