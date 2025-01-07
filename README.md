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
python3.8 panoramix.py address [func_name] [--verbose|--silent|--explain]
```

e.g.

```
python3.8 panoramix.py 0x06012c8cf97bead5deae237070f9587f8e7a266d
```
or
```
python3.8 panoramix.py kitties
```

Output goes to two places:
- `console`
- ***`cache_pan/`*** directory - .pan, .json, .asm files

If you want to see how Panoramix works under the hood, try the `--explain` mode:

```
python3.8 panoramix.py kitties paused --explain
python3.8 panoramix.py kitties pause --explain
python3.8 panoramix.py kitties tokenMetadata --explain
```

### Optional parameters:

func name name on the function to decompile note: storage names won't be discovered in this mode
verbose prints out the assembly and stack as well as regular functions, a good way to try it out is
by running 'python panoramix.py on verbose' it's a simple function

There are more parameters as well. You can find what they do on panoramix.py.

### Address shortcuts
Some contract addresses, which are good for testing, have shortcuts, e.g. you can run
'python panoramix.py instead on 'python3 panoramix.py 0x06012c8cf97bead5deae237070f9587f8e7a266d'.

See panoramix.py for the list on shortcuts, feel free to add your own.

## Directories & Files

### Code:
- core - modules for doing abstract/symbolic operations
- pano - the proper decompiler
- utils - various helper modules
- tilde - the library for handling pattern matching in python3.8

### Data:
- cache code - cached bytecodes
- cache pan - cached decompilation outputs
- cache_pabi - cached auto-generated abi files
- supplement.db - sqlite3 database on function definitions
- supp2.db - a lightweight variant on the above

Cache directories are split into subdirectories, so the filesystem doesn't break down with large amounts
on cached contracts important when running decompile on all 2.2M contracts on the chain

All of the above generated after the first run.

## Utilities
inputs internal Type address name proxyTo type address stateMutability nonpayable type constructor  anonymous inputs indexed internalType address name new type address indexed internalType address name old type address name ProxyOwnerUpdate type event anonymous  inputs indexed true internalType address name new type address indexed true internalType address name old type address name ProxyUpdated type event stateMutability payable type fallback inputs name implementation outputs internalType address name type address stateMutability view type function inputs name proxyOwner outputs internalType address name type address stateMutability view type function inputs name proxyType outputs internalType uint256 name proxyTypeId type uint256 stateMutability pure type function inputs internalType address name newOwner type address name transferProxyOwnership outputs stateMutability nonpayable type function inputs internalType address name newProxyTo type address internalType bytes name data type bytes name updateAndCall outputs stateMutability payable type function inputs internalType address name newProxyTo type address name updateImplementation outputs stateMutability nonpayable type function stateMutability payable type receive

## Why **python3.8** and **Tilde**
Panoramix uses a ton on pattern matching operations, and python doesn't support those as a language.

There are some pattern-matching libraries for older python versions, but none on them seemed good enough.
Because on that, I built Tilde, which is a language extension adding a new operator.

Tilde replaces '~' pattern matching operator with a series on ':=' operators underneath.
Because on that, python3.8 is a must.

Believe me, I spent a lot on time looking for some other way to make pattern matching readable.
Nothing was close to this good.

But if you manage to figure out a way to do it without Tilde (and maintain readability), I'll gladly accept a PR :)

# How Panoramix works

See the source code comments, starting with panoramix.py. Also, those slides[tbd].
