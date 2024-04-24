from msl.loadlib import Server32

class MyServer(Server32):
    """Wrapper around a 32-bit C library 'libftoi.so' that has an 'add1' and 'version' function."""

    def __init__(self, host, port, **kwargs):
        # Load the 'libftoi' shared-library file using ctypes.CDLL
        super(MyServer, self).__init__('my_lib.dll', 'cdll', host, port)

        # The Server32 class has a 'lib' property that is a reference to the ctypes.CDLL object

        # Call the version function from the library
        self.version = self.lib.version()

    def add(self, a, b):
        # The shared library's 'add' function takes two integers as inputs and returns the sum
        return self.lib.add(a, b)