# git-branch-diff

[![GitTip](http://img.shields.io/gittip/alexgorbatchev.svg)](https://www.gittip.com/alexgorbatchev/)
[![Dependency status](https://david-dm.org/alexgorbatchev/git-branch-diff.svg)](https://david-dm.org/alexgorbatchev/git-branch-diff)
[![devDependency Status](https://david-dm.org/alexgorbatchev/generator-coffee-module/dev-status.svg)](https://david-dm.org/alexgorbatchev/generator-coffee-module#info=devDependencies)
[![Build Status](https://secure.travis-ci.org/alexgorbatchev/git-branch-diff.svg?branch=master)](https://travis-ci.org/alexgorbatchev/git-branch-diff)

[![NPM](https://nodei.co/npm/git-branch-diff.svg)](https://npmjs.org/package/git-branch-diff)

This is a git utility that compares all local branches to one other branch and shows all files that have differences. This tool is useful if you are working with production branch that is a result of squash committs instead of merges.

## Installation

    npm install git-branch-diff

## Usage Example

    git-branch-diff -b origin/production -r ./my/local/repo

    [
      {
        "branch": "patch-1",
        "files": [
          "README.md"
        ]
      },
      {
        "branch": "patch-2",
        "files": [
          "new-file.txt"
        ]
      }
    ]

# License

The MIT License (MIT)

Copyright (c) 2014 Alex Gorbatchev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
