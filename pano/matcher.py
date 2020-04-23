import copy
import builtins
import logging

logger = logging.getLogger(__name__)


class Any:
    pass


# Shortcuts
_ = Any


class Match:
    pass


class NoMatch(ValueError):
    def __init__(self, expression, pattern):
        self.expression = expression
        self.pattern = pattern


def _match_helper(expression, pattern, match):
    if pattern is Any:
        return

    if isinstance(pattern, (list, tuple)):
        if not isinstance(expression, (list, tuple)):
            raise NoMatch(expression, pattern)
        while True:
            if len(pattern) == 0 and len(expression) == 0:
                return
            if len(pattern) > 0 and len(expression) == 0:
                if pattern[0] is Ellipsis:
                    return
                else:
                    raise NoMatch(expression, pattern)
            if len(pattern) == 0 and len(expression) > 0:
                raise NoMatch(expression, pattern)
            if pattern[0] is Ellipsis:
                return
            _match_helper(expression[0], pattern[0], match)
            expression = expression[1:]
            pattern = pattern[1:]

    if isinstance(pattern, str) and pattern.startswith(":"):
        attr = pattern[1:]
        if ":" in attr:
            type_name, attr = attr.split(":")
            if not isinstance(expression, getattr(builtins, type_name)):
                raise NoMatch(expression, pattern)
        if hasattr(match, attr):
            if getattr(match, attr) == expression:
                return
            else:
                raise NoMatch(expression, pattern)
        setattr(match, attr, expression)
        return

    if isinstance(pattern, type):
        if isinstance(expression, pattern):
            return
        else:
            raise NoMatch(expression, pattern)

    if expression != pattern:
        raise NoMatch(expression, pattern)


def match(expression, pattern):
    """Return whether the expression matched the pattern. If it did, return a Match object.

    >>> expr = (1, 2)
    >>> bool(match(expr, (1, 2)))
    True
    >>> bool(match(expr, (1, _)))
    True
    >>> bool(match(expr, _))
    True
    >>> bool(match(expr, (_, _, _)))
    False
    >>> bool(match((1, 2, 3), (1, ...)))
    True
    >>> bool(match(expr, (2, _)))
    False
    >>> match(expr, (':one', ':two')).one
    1
    >>> match((1, 2, 3, 4), (':one', ':two', ...)).two
    2
    >>> match((1, 2, 3, 4), (int, ':two', ...)).two
    2
    >>> bool(match((1, 2, 3, 4), (tuple, ':two', ...)))
    False
    >>> bool(match((1, 2, 3, 4), (int, ':int:two', ...)))
    True
    >>> bool(match((1, "two", 3, 4), (int, ':int:two', ...)))
    False
    >>> match(("one", "two", 3, 4), (str, ':str:two', ...)).two
    'two'
    """
    m = Match()
    try:
        _match_helper(expression, pattern, m)
    except NoMatch as e:
        logger.debug(
            "match(%r, %r) failed to match %r with %r",
            expression,
            pattern,
            e.expression,
            e.pattern,
        )
        return None
    return m


def replace(expression, pattern, replacement):
    """Replace the pattern by the replacement expression, recursively.

    >>> replace((1, 2), (1, 2), (2, 3))
    (2, 3)
    >>> replace((1, 2), (2, 3), (3, 4))
    (1, 2)
    >>> replace((1, 2), 1, 2)
    (2, 2)
    >>> replace((1, 2, 3), (':a', ':a', ':b'), ('hey', ':b', ':a'))
    (1, 2, 3)
    >>> replace((1, 1, 3), (':a', ':a', ':b'), ('hey', ':b', ':a'))
    ('hey', 3, 1)
    >>> replace((1, (1, 2, 2)), (':a', (':a', ...)), ':a')
    1
    >>> replace((1, (1,)), (':a', (':a', ...)), ':a')
    1
    >>> replace((1, ()), (':a', (':a', ...)), ':a')
    (1, ())
    """
    m = Match()
    try:
        _match_helper(expression, pattern, m)
    except NoMatch:
        if isinstance(expression, list):
            return [replace(i, pattern, replacement) for i in expression]
        if isinstance(expression, tuple):
            return tuple(replace(i, pattern, replacement) for i in expression)
        return expression

    def replace_matched(e):
        if isinstance(e, list):
            return [replace_matched(i) for i in e]
        if isinstance(e, tuple):
            return tuple(replace_matched(i) for i in e)
        if isinstance(e, str) and e.startswith(":"):
            return getattr(m, e[1:])
        if e is Any or e is Ellipsis:
            raise ValueError("Cannot have matchers in the replacement expression.")
        return e

    return replace_matched(replacement)


if __name__ == "__main__":
    import doctest

    logging.basicConfig(level=logging.DEBUG)
    doctest.testmod()
