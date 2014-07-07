R = require 'ramda'
Promise = require 'songbird'
{exec} = require 'child_process'

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

{branch: targetBranch, repository} = argv

getBranchName = (ref) ->
  match = ref.match /^\w{40} refs\/heads\/(.*)$/
  match? and match[1] or null

isSHA = (value) ->
  /^[0-9a-f]{40}$/.test value

filesToObject = R.curry (branch, files) ->
  {branch, files: files?.length and files or null}

git = (cmd) ->
  exec.promise "git #{cmd}", cwd: repository
    .spread (stdout, stderr) -> stdout.split /\n/g
    .then R.filter R.size
    .catch (err) -> throw err.message + '\n\n' + cmd

getBranches = ->
  git 'show-ref --heads'
    .then R.map getBranchName

getChangedFilesInBranch = (branch) ->
  git "--no-pager log --pretty=%H --name-only #{targetBranch}..#{branch}"
    .then R.reject isSHA
    .then R.uniq
    .then filesToObject branch

getDiffWithBranch = R.curry (branch, file) ->
  git "--no-pager diff #{targetBranch}..#{branch} -- #{file}"
    .then (diff) -> {file, hasDiff: diff.length > 0}

getCurrentBranch = -> git 'rev-parse --abbrev-ref HEAD'
getModifiedFiles = -> git 'ls-files -dm --exclude-standard'

addUncommittedFiles = (list) ->
  Promise.all [getCurrentBranch(), getModifiedFiles()]
    .spread (currentBranch, modifiedFiles) ->
      console.log currentBranch, modifiedFiles
      list

getBranches()
  .then R.map getChangedFilesInBranch
  .then Promise.all
  .then R.filter R.prop 'files'
  .then R.map ({branch, files}) ->
    Promise
      .all files.map getDiffWithBranch(branch)
      .then R.filter R.prop 'hasDiff'
      .then R.pluck 'file'
      .then filesToObject branch
  .then Promise.all
  .then R.filter R.prop 'files'
  .then (branches) ->
    process.stdout.write JSON.stringify branches, null, 2

