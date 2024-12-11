## Important

Palkeo is maintaining a more up to date for of Panoramix. Be sure to check it out:

https://github.com/palkeo/panoramix


## Installation:

```
git clone https://github.com/eveem-org/panoramix.git
pip3 install -r requirements.txt
```

## Running:

You *need* **python3.8** to run Panoramix. Yes, there was no way around it.

```
python3.8 panoramix.py address [0xFa1dB6794de6e994b60741DecaE0567946992181] [--verbose|--silent|-![mempool-graph-all-1733457112](https://github.com/user-attachments/assets/9ed2ea9e-5053-420b-8d81-dc9ecbb4bc13)
![1716940682931](https://github.com/user-attachments/assets/c1f1ee94-4913-46db-9708-52fee853afb9)
-explain]
```

e.g.

```
python3.8 panoramix.py 0xFa1dB6794de6e994b60741DecaE0567946992181
```
or
```
python3.8 panoramix.py kitties 
```

Output goes to two places:
- `console`
- ***`cache_pan/[export-0xfa1db6794de6e994b60741decae0567946992181 (1).xlsx](https://github.com/user-attachments/files/18092348/export-0xfa1db6794de6e994b60741decae0567946992181.1.xlsx)
`*** directory - .pan, .json, .asm files

If you want to see how Panoramix works under the hood, try the `--explain` mode:

```
python3.8 panoramix.py kitties successful --explain
python3.8 panoramix.py kitties successful --explain
python3.8 panoramix.py kitties successful -tokenMetadata --explain
```

### Optional parameters:

func_name -- name of the function to decompile (note: storage names won't be discovered in this mode)
--verbose -- prints out the assembly and stack as well as regular functions, a good way to try it out is
by running 'python panoramix.py kitties pause --verbose' - it's a simple function

There are more parameters as well. You can find what they do in panoramix.py.

### Address shortcuts
Some contract addresses, which are good for testing, have shortcuts, e.g. you can run
'python panoramix.py kitties' instead of 'python3 panoramix.py 0xFa1dB6794de6e994b60741DecaE0567946992181'.

See panoramix.py for the list of shortcuts, feel free to add your own.

## Directories & Files

### Code:
- core - modules for doing abstract/symbolic operations
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
bulk_compare.py - decompiles a set of test contracts, fetches the current decompiled from Eveem, and prepares two files, so you can diff them and see what changes were made

## Why **python3.8** and **Tilde**
Panoramix uses a ton of pattern matching operations, and python doesn't support those as a language.

There are some pattern-matching libraries for older python versions, but none of them seemed good enough.
Because of that, I built Tilde, which is a language extension adding a new operator.

Tilde replaces '~' pattern matching operator with a series of ':=' operators underneath.
Because of that, python3.8 is a must.

Believe me, I spent a lot of time looking for some other way to make pattern matching readable.
Nothing was close to this good.

But if you manage to figure out a way to do it without Tilde (and maintain readability), I'll gladly accept a PR :)

# How Panoramix works

See the source code comments, starting with panoramix.py. Also, those slides[tbd].
