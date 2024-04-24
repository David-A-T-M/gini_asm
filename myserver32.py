import ctypes
from msl.loadlib import Server32


class MyServer32(Server32):
    """Wrapper around a 32-bit C library 'libftoi.so' that has an 'add1' and 'version' function."""

    def __init__(self, host, port, **kwargs):
        # Load the 'libftoi' shared-library file using ctypes.CDLL
        super(MyServer32, self).__init__('libftoi.so', 'cdll', host, port)

        # The Server32 class has a 'lib' property that is a reference to the ctypes.CDLL object

        # Call the version function from the library
        self.lib.add1.restype = ctypes.c_int
        self.lib.add1.argtypes = [ctypes.c_float]
        # self.version = self.lib.version()   #used if c function doesn't take arguments

    def add1(self, f):
        # The shared library's 'add1' function takes a float and returns the integer part of the number plus one
        return self.lib.add1(f)
