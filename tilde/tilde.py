from tokenize import tokenize, untokenize, NUMBER, STRING, NAME, OP, NL, NEWLINE
from io import BytesIO

"""
    python pattern matching

        exp ~ (int, :x, int:y, z, 99, ...)
        exp ~ ('sth', *rest)
        exp ~ (int:x, x + 5)
        exp ~ ('sth', ('sth', *rest))

    usage:
        - in the main project file do 'import tilde.tilde'
        - every module imported after that can have '# coding: tilde' at the beginning and use tilde

    missing features:
        - matching lists
        - breaks now when there is a function call inside of an exp (e.g. ~ (sth(sth)))
"""

import tokenize


def translate(readline):
    prev_type = None
    prev_name = None
    tokens = []
    for t in tokenize.tokenize(readline):
        tokens.append((t[0], t[1], t[2][0], t[3][0]))

    last_line = 1

    while len(tokens) > 0:
        type, name, line_no, end_line_no = tokens.pop(0)

        if type in (NL, NEWLINE):
            last_line += 1

        if type == STRING and "\n" in name:
            last_line = end_line_no

        while line_no > last_line:
            yield NL, "\\\n"
            last_line += 1

        if name == "tilde":
            yield type, "utf-8"

        if prev_type == tokenize.NAME and type == tokenize.OP and name == "~":
            var = name

            type, name = tokens.pop(0)[:2]
            assert (type, name) == (tokenize.OP, "(")
            par_count = 1
            out = [(type, name)]
            while par_count > 0:
                type, name = tokens.pop(0)[:2]
                out.append((type, name))
                if (type, name) == (tokenize.OP, "("):
                    par_count += 1
                if (type, name) == (tokenize.OP, ")"):
                    par_count -= 1

            tuples = make_tuples(out)

            rule_0 = "True"  # f'(__x := {prev_name}) or True'
            ruleset = [rule_0] + make_ruleset(tuples, prev_name)

            out_str = " and ".join(
                f"({r})" if r != "is not None" else r for r in ruleset
            )
            yield STRING, " is not None and (" + out_str + ")"

        else:
            yield type, name

        prev_type = type
        prev_name = name


def make_ruleset(tuples, base):

    res = []
    res.append(f"type({base}) == tuple")
    tuples = list(tuples)

    last = tuples[-1]
    if last[0] == "..." or last[0] == "*":
        res.append(f"len({base}) >= {len(tuples)-1}")  # ... means 0 or more ending args
        if last[1] is not None:
            res.append(
                f"({last[1]} := {base}[{len(tuples)-1}:]) or True"
            )  # copy all the rest into the last name
        tuples.pop()

    else:
        res.append(f"len({base}) == {len(tuples)}")

    for idx, t in enumerate(tuples):
        if t == (None, None, None):
            continue

        el_id = f"{base}[{idx}]"
        if t[0] is not None and t[0] != "~":
            assert t[0] != "..."  # can only be at the end
            res.append(f"type({el_id}) == {t[0]}")

        if type(t[1]) == str:
            res.append(f"({t[1]} := {el_id}) or True")  # otherwise it fails for 0
        elif type(t[1]) == tuple:
            pass  # skipping for now

        if t[2] is not None:
            res.append(f"{el_id} == {t[2]}")

    for idx, t in enumerate(tuples):
        el_id = f"{base}[{idx}]"
        if t[0] == "~":
            #            res.append(f'__x := {el_id}')
            res.extend(make_ruleset(t[1], el_id))

    return res
    # first find all nontuples


def make_tuples(out):
    assert out[0] == (OP, "(")
    out.pop(0)

    res = []
    exp = []
    while len(out) > 0:
        el = out[0]

        if el == (OP, "("):
            res.append(("~", make_tuples(out), None))
        elif el == (OP, ")"):
            out.pop(0)
            if len(exp) > 0:
                res.append(make_exp(exp))
            return tuple(res)
        elif el == (OP, ","):
            out.pop(0)
            if len(exp) > 0:
                res.append(make_exp(exp))
            exp = []
        else:
            out.pop(0)
            exp.append(el)

    assert False


def make_exp(exp):
    check_type, out_name, concrete = None, None, None

    if len(exp) == 1 and exp[0][1] == "_":
        return (None, None, None)
    if len(exp) == 2 and exp[0][1] == "*" and exp[1][0] == NAME:
        exp = [(OP, "..."), (OP, ":"), exp[1]]

    if exp[0][1] in ("...", "int", "str", "list", "tuple"):
        check_type = exp[0][1]
        exp.pop(0)

    if len(exp) == 2 and exp[0][1] == ":":
        out_name = exp[1][1]

    elif len(exp) > 0:
        concrete = tokenize.untokenize(exp)  # .decode()

    return (check_type, out_name, concrete)


def untilde(x):
    return str(
        tokenize.untokenize(translate(BytesIO(x.encode("utf-8")).readline)).decode()
    )


def tilde_decode(s):
    x = BytesIO(s).read().decode("utf-8")
    assert x[0] == "#"
    x = x[1:]
    x = untilde(x.replace("tilde", "xilde"))
    x = "# " + x.replace("xilde", "tilde")

    return x, len(x)


"""

    register `tilde` codec

"""

import codecs, io, encodings
from encodings import utf_8


class StreamReader(utf_8.StreamReader):
    def __init__(self, *args, **kwargs):
        codecs.StreamReader.__init__(self, *args, **kwargs)
        data = tokenize.untokenize(translate(self.stream.readline))
        self.stream = i.StringIO(data)


def search_function(s):
    if s != "tilde":
        return None
    utf8 = encodings.search_function("utf8")  # Assume utf8 encoding
    return codecs.CodecInfo(
        name="tilde",
        encode=utf8.encode,
        decode=tilde_decode,
        incrementalencoder=utf8.incrementalencoder,
        incrementaldecoder=utf8.incrementaldecoder,
        streamreader=StreamReader,
        streamwriter=utf8.streamwriter,
    )


codecs.register(search_function)
