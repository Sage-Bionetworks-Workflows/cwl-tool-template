#! /usr/bin/env python3

import argparse
import glob
import logging
import os

import chevron
import yaml

log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)

ERROR_UNEXPECTED_TYPE = 'Object is neither a list nor a dictionary'
ERROR_MISSING_DOCKER_REQUIREMENT = 'CWL tool is missing DockerRequirement'
ERROR_MISSING_DOCKER_PULL = 'Please specify "dockerPull" in your DockerRequirement and rerun script'


def tools_list(tools_dir):
  log.debug(f'tools_dir passed to tools_list={tools_dir}')
  glob_pattern = f'{tools_dir}/*.mustache'
  log.debug(f'glob_pattern ={glob_pattern}')
  return glob.glob(glob_pattern)


def create_tool(template_path, new_version, tools_dir):
  cwl_input = {'version': new_version}
  tool_name = os.path.basename(template_path).replace(".mustache", "")
  with open(template_path, 'r') as mus_f:
    template = chevron.render(mus_f, cwl_input)
  tool_path = os.path.join(tools_dir, tool_name)
  with open(tool_path, "w") as tool_f:
    tool_f.write(template)


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
  parser.add_argument(
    'template_dir',
    help='Dir where CWL tool templates are stored')
  args = parser.parse_args()
  return args.tool_dir, args.new_version, args.template_dir


def main(tools_dir, new_version, template_dir):
  template_paths = tools_list(template_dir)
  for template_path in template_paths:
    create_tool(template_path=template_path, new_version=new_version,
                tools_dir=tools_dir)


if __name__ == '__main__':
  tools_dir, new_version, template_dir = parse_args()
  main(tools_dir=tools_dir, new_version=new_version,
       template_dir=template_dir)
