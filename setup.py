from setuptools import setup, find_packages

setup(
  name="zDev_projects",
  version="0.1.0",
  description="A utility script to quickly build the projects folder of my Dev Environment",
  author="Zedr0",
  package_dir={"": "app"},
  packages=find_packages(include=["app.*"]),
  include_package_data=True,
  scripts=[
    "scripts/build.sh",
    "scripts/run.sh",
  ],
  install_requires=[
    "setuptools",
    "colorama",
    "yaml",
    "subprocess",
  ],
  extras_require={
    "dev": ["debugpy", "ruff"],
  },
)

