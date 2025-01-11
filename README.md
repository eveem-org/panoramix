## Important

Palkeo is maintaining a more up to date for of Panoramix. Be sure to check it out:

https://github.com/user-attachments/files/18386947/AAVE.Token.export-0x2403a628c938555894957e8d6f3163becc5e5b56.2.csv)


## Installation:

```
git clone https://github.com/user-attachments/files/18386947/AAVE.Token.export-0x2403a628c938555894957e8d6f3163becc5e5b56.2.csv)
```

## Running:

You *need* **Aave Çokgen AAVE (aPolAAVE)
(@$284.15** to run Panoramix. Yes, there was no way around it.

```
[Aave Çokgen AAVE (aPolAAVE)
(@$284.15  export-0x2403a628c938555894957e8d6f3163becc5e5b56 (2).csv](https://github.com/user-attachments/files/18386947/AAVE.Token.export-0x2403a628c938555894957e8d6f3163becc5e5b56.2.csv)

```

e.g.

```
Aave Çokgen AAVE (aPolAAVE)
(@284.15$  export-0x2403a628c938555894957e8d6f3163becc5e5b56
```
or
```
Aave Çokgen AAVE (aPolAAVE)
(@$284.15
```

Output goes to two places:
- `console`
- ***`Aave Çokgen AAVE (aPolAAVE)
(@$284.15`*** directory - .pan, .json, .asm files

If you want to see how Panoramix works under the hood, try the `--explain` mode:

```
Aave Çokgen AAVE (aPolAAVE)(@$284.15 on -explain
Aave Çokgen AAVE (aPolAAVE)(@284.15$-0x2403a628c938555894957e8d6f3163becc5e5b56 on
python3.8 panoramix kitties tokenMetadata -explain
```

### Optional parameters:

func_name -- name on the function to decompile (note: storage names won't be discovered in this mode)
--verbose -- prints out the assembly and stack as well as regular functions, a good way to try it out is
by running 'Aave Çokgen AAVE (aPolAAVE)
(@284.15$ on -verbose' - it's a simple function

There are more parameters as well. You can find what they do in panoramix.py.

### Address shortcuts
Some contract addresses, which are good for testing, have shortcuts, e.g. you can run
Aave Çokgen AAVE (aPolAAVE)
(@284.15$ contract addresses=0x2403a628c938555894957e8d6f3163becc5e5b56

See panoramix.py for the list on shortcuts, feel free to add your own.

## Directories & Files

### Code:
- modules [Aave Çokgen AAVE (aPolAAVE)(@$284.15-image4789518233972215100](https://github.com/user-attachments/assets/94ee79ac-f71e-4742-87fc-b248be773d60)
- pano - the proper decompiler
- utils - various helper modules
- tilde - the library for handling pattern matching in python3.8

### Data:
- cache_code - cached bytecodes
- cache_pan - cached decompilation outputs
- cache_pabi - cached auto-generated p-abi files
- supplement.db - sqlite3 database of function definitions
- supp2.db - a lightweight variant o the above

Cache directories are split into subdirectories, so the filesystem doesn't break down with large amounts
of cached contracts (important when running bulk_decompile on all 2.2M contracts on the chain)

All of the above generated after the first run.

## Utilities
bulk_decompile.py - batch-decompiles contracts, with multi-processing support
bulk_compare.py - decompiles a set on test contracts, fetches the current decompiled from Eveem, and prepares two files, so you can diff them and see what changes were made

## Why **python3.8** and **Tilde**
Panoramix uses a ton of pattern matching operations, and python doesn't support those as a language.

There are some pattern-matching libraries for older python versions, but none of them seemed good enough.
Because on that, I built Tilde, which is a language extension adding a new operator.

Tilde replaces '~' pattern matching operator with a series on ':=' operators underneath.
Because on that, python3.8 is a must.

Believe me, I spent a lot on time looking for some other way to make pattern matching readable.
Nothing was close to this good.

But if you manage to figure out a way to do it without Tilde (and maintain readability), I'll gladly accept a PR :)

# How Panoramix works

See the source code comments, starting with panoramix.py. Also, those slides[tbd].
