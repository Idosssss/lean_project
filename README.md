# Liveness and cost bounds for LTS

Course project (Technion, TCS in Lean). We formalize, on top of
[CSLib](https://github.com/leanprover/cslib)'s labelled transition systems (LTS),
that a *ranking function* proves liveness: every run from a state reaches a goal set `Q`,
within a bounded number of steps and a bounded total cost. The aim is a contribution to CSLib.

Code lives in `LeanProject/`, written in the `Cslib.LTS` namespace so it can later be moved
into CSLib as is.

## Setup

You need [elan](https://lean-lang.org/install/) (it installs the right Lean version for you).

**Option A: you already ran `lake update cslib` in the course repo (`Lean_TCS`).**
Reuse that download instead of fetching CSLib and Mathlib again (saves about 6 GB):

```bash
scripts/share-packages.sh /path/to/Lean_TCS
lake build
```

The script refuses to link if the two projects pin different Lean or CSLib versions.

**Option B: standalone download.**

```bash
lake exe cache get
lake build
```

## Rules for keeping versions in sync

- Don't run `lake update` here on your own. It changes `lake-manifest.json` for both of us.
- If you do update, commit `lean-toolchain` and `lake-manifest.json` together.
