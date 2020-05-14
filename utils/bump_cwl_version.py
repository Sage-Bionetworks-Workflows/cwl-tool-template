#! /usr/bin/env python3

import argparse
import glob
import logging
import yaml


log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)


def tools_list(tools_dir):
  log.debug(f'tools_dir passed to tools_list={tools_dir}')
  glob_pattern = f'{tools_dir}/*.cwl'
  log.debug(f'glob_pattern ={glob_pattern}')
  return glob.glob(glob_pattern)


def read_tool(path):
  with open(path) as file:
    tool = yaml.load(file, Loader=yaml.FullLoader)
  return tool


def edit_tool(tool, new_version):
  # this is dependent on cwl syntax -- you'll need to change this
  # if you use the list style for hints, or put your DockerRequirement
  # under 'requirements' instead of 'hints'
  docker_image = tool['hints']['DockerRequirement']['dockerPull']
  parts = docker_image.split(':')
  parts[-1] = new_version
  tool['hints']['DockerRequirement']['dockerPull'] = ':'.join(parts)
  return yaml.dump(tool)


def write_tool(path, output):
  with open(path, mode='w') as file:
    file.write(output)
    file.close()


def parse_args():
  parser = argparse.ArgumentParser(
    description='Change docker image version in cwl tool')
  parser.add_argument(
    'tool_dir',
    help='Dir where CWL tools are stored')
  parser.add_argument(
    'new_version',
    help='New docker version to set in cwl tool')
  args = parser.parse_args()
  return args.tool_dir, args.new_version


def main(tools_dir, new_version):
  tool_paths = tools_list(tools_dir)
  for tool_path in tool_paths:
    tool = read_tool(path=tool_path)
    output = edit_tool(tool=tool, new_version=new_version)
    write_tool(path=tool_path, output=output)


if __name__ == '__main__':
  tools_dir, new_version = parse_args()
  main(tools_dir=tools_dir, new_version=new_version)
