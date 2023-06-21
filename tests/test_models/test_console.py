#!/usr/bin/python3
""" """
import unittest
from tests.test_models.test_base_model import test_basemodel
from models.amenity import Amenity
from console import HBNBCommand


class test_Console(unittest.TestCase):
    """ """

    def __init__(self):
        """ """
        self.run = HBNBCommand()

    def test_create(self):
        """ """
        new = self.run.do_create()
        self.assertEqual(str, str)