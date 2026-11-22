import Cslib.Foundations.Semantics.LTS.Basic

/-!
# Liveness of LTS via ranking functions

`lts.MustReach Q s` says that every run of `lts` starting at `s` reaches the goal set `Q`,
and never gets stuck before reaching it.

The main proof method is a *ranking function* `V : State → ℕ`: outside `Q`, a state is never
stuck and every step strictly lowers `V`. Since a natural number cannot decrease forever, every
run must reach `Q`.

## Main statements (planned)

* T1 `mustReach_of_isRanking`: a ranking function proves `MustReach`.
* T2: `Q` is reached within `V s` steps.
* T3: the total cost of reaching `Q` is at most `V s`.
* T4: `MustReach` agrees with "every execution visits `Q`".
* T5: for finitely branching LTSs, `MustReach` implies a ranking function exists.
* T6: `Terminating` is the special case where `Q` is the set of terminal states.
-/

namespace Cslib.LTS

universe u v

variable {State : Type u} {Label : Type v}

/-- Every run from `s` reaches `Q`, and never gets stuck before reaching it. -/
inductive MustReach (lts : LTS State Label) (Q : Set State) : State → Prop
  | here {s : State} : s ∈ Q → MustReach lts Q s
  | step {s : State} : ¬ lts.IsTerminal s →
      (∀ μ s', lts.Tr s μ s' → MustReach lts Q s') → MustReach lts Q s

/-- `V` is a ranking function for reaching `Q`: outside `Q`, a state is never stuck,
and every step strictly lowers `V`. -/
def IsRanking (lts : LTS State Label) (Q : Set State) (V : State → ℕ) : Prop :=
  -- TODO(human): state the ranking condition.
  sorry

/-- **T1 (soundness).** A ranking function proves that every run from `s` reaches `Q`. -/
theorem mustReach_of_isRanking (lts : LTS State Label) {Q : Set State} {V : State → ℕ}
    (h : lts.IsRanking Q V) (s : State) : lts.MustReach Q s := by
  sorry

end Cslib.LTS
