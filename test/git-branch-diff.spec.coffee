require 'coffee-errors'

{expect} = require 'chai'
{exec} = require 'child_process'

describe 'git-branch-diff', ->
  before (done) ->
    exec "tar xzvf test-repos.tar.gz", cwd: __dirname, (err, stdout) ->
      done err

  after (done) ->
    exec "rm -fr origin workspace", cwd: __dirname, (err, stdout) ->
      done err

  it 'returns expected results', (done) ->
    exec "../git-branch-diff.js -b origin/master -r ./workspace", cwd: __dirname, (err, stdout) ->
      expect(JSON.parse stdout).to.eql require './expected'
      done()
