from typing import Any, Iterable
from pipe import Pipe, where


class PipeStrategy:
    def __init__(self, strategy):
        self.strategy = strategy

    def __getattr__(self, attr):
        return Pipe(self.strategy(attr))


class PipeTemplater(type):
    def __init__(self, child):
        self.strategy = child.strategy
        self.pipe = PipeStrategy(self.strategy)

    def __getattr__(self, attr):
        return self.strategy(attr)


class GetType(PipeTemplater):
    def __init__(self, *_):
        super().__init__(self)

    @staticmethod
    def strategy(attr):
        def get_obj_attribute(obj):
            return obj.__getattribute__(attr)

        return get_obj_attribute


class Get(metaclass=GetType):
    pass


"""
Equivalent to null chaining
"""
class NoneGetType(PipeTemplater):
    def __init__(self, *_):
        super().__init__(self)

    @staticmethod
    def strategy(attr):
        def get_obj_attribute(obj):
            if obj is None:
                return None

            return obj.__getattribute__(attr)

        return get_obj_attribute


class NoneGet(metaclass=NoneGetType):
    pass


class CallType(PipeTemplater):
    def __init__(self, *_):
        super().__init__(self)

    @staticmethod
    def strategy(attr):
        def get_obj_attribute(obj):
            return obj.__getattribute__(attr)()

        return get_obj_attribute


class Call(metaclass=CallType):
    pass


class Is:
    none = Pipe(lambda fun: lambda arg: fun(arg) is None)
    not_none = Pipe(lambda fun: lambda arg: fun(arg) is not None)

    @staticmethod
    def equal_to(value):
        return Pipe(lambda fun: lambda arg: fun(arg) == value)

    @staticmethod
    def not_equal_to(value):
        return Pipe(lambda fun: lambda arg: fun(arg) != value)

    @staticmethod
    def member_of(iter):
        return lambda x: x in iter

    @staticmethod
    def not_member_of(iter):
        return lambda x: x not in iter


def _take_first(iterable: Iterable) -> Any | None:
    iterator = iter(iterable)
    try:
        return next(iterator)
    except StopIteration as _:
        return None

first = Pipe(_take_first)

tolist = Pipe(list)
toset = Pipe(set)
totuple = Pipe(tuple)
todict = Pipe(dict)

def whereby(selector, predicate):
    return where(lambda x: predicate(selector(x)))


def Item(i):
    return lambda x: x[i]

