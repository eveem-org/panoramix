Panoramix
=========

This is an EVM decompiler.

It's is a fork of the Panoramix original repo that's not maintained actively by its author anymore: https://github.com/eveem-org/panoramix.git

The goal of this fork is to maintain Panoramix in a decent shape, fix some crashes, implement missing opcodes...

I also started a more ambitious rewrite of some core parts, to remove the "tilde" syntax that was using a custom python encoding and use vanilla Python instead. And would like to make it a proper python package that can be imported.

There is also a better support of timeouts, as instead of stopping entirely we will fallback and print whatever we decompiled even if it's not complete.
