#! /usr/bin/env python

import argparse

import semver
import git
import bump_cwl_version


parser = argparse.ArgumentParser(
  description='Create a git release')
parser.add_argument(
  '--major',
  action='store_true',
  help='creates a major release')
args = parser.parse_args()
major_bump = args.major

repo = git.Repo('.') # assumes script is run from repo root
assert not repo.is_dirty(), 'Cannot create a release: repo is dirty. Commit first, then rerun script.'

# ensure everything is up to date
repo.remote().fetch()
commits_behind = len(list(repo.iter_commits('master..origin/master')))
if commits_behind != 0:
  raise Exception(f'Branch is {commits_behind} commits behind remote. Pull before attempting release.')

tags = repo.tags
# sort tags by commit date
tags_sorted = sorted(repo.tags, key=lambda t: t.commit.committed_date)
# get most recent tag
last_tag = str(tags_sorted[-1])

# use semver to create the new version
current_version = semver.VersionInfo.parse(last_tag[1:])
if major_bump:
  new_version = current_version.bump_major()
else:
  new_version = current_version.bump_minor()

# update the version for all cwl tools
tools_dir = 'cwl' # again, assuming relative to repo root
bump_cwl_version.main(tools_dir=tools_dir, new_version=str(new_version))
repo.git.add(tools_dir)
# '[skip-ci]' in commit to avoid the next patch increment --
# ci will run when the tag is pushed below
repo.git.commit( m=f'Update docker image version in CWL tool to {new_version} [skip-ci]' )
repo.remote().push()

# create and push the new tag
new_tagname = f'v{str(new_version)}'
new_tag = repo.create_tag(new_tagname)
repo.remote().push(new_tag)
