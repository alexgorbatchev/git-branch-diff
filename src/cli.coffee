{exec} = require 'child_process'
gitBranchDiff = require '..'

argv = require 'yargs'
  .usage """
    Returns list of files that are changed locally from specified remote branch.
    Usage: $0 -b branch -r repository
  """

  .demand 'b'
  .alias 'b', 'branch'
  .describe 'b', 'Branch against which to diff all local branches'

  .demand 'r'
  .alias 'r', 'repository'
  .describe 'r', 'Target repository'

  .argv

{branch, repository} = argv

gitBranchDiff repository, branch
  .then (data) ->
    process.stdout.write JSON.stringify data, null, 2
