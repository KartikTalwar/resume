import yaml
from pprint import pprint as pp

r = open('data/hackathons.yaml').read()
y = yaml.load(r)


pp(y)