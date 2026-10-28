# showcase_ops

**One capability bit from GBT V8, packaged standalone.** No. 56 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **作品解剖与展示**（主人令 2026-10-16：让每一次的作品都能完美的展示能力）：蒸自 **wheresryan22/anatomy**（MIT · 13,459 星 · agent-skill）的**思路与架构**—— 「**用一个真会动的实物来讲解一个概念**」：概念→会动的实物（例：cache key⇒弹子锁）→**几十个小而精确的零件**（SVG+WebGL+3D）→**带标题/提示/实时读数的画框**→指针键盘下平静地动→**放大每个关节自检**→**读数同源**（图里每个数字都来自驱动零件运动的同一模型）。我们加三条护栏：署名必在 · 未验标未验 · 读数必须可指回。op=concept/parts/frame/motion/readout/selfcheck/check/route（**全只读·零作用域**）。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-showcase-ops.git
cd gbt-showcase-ops
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_showcase_ops info                  # capability card
python -m gbt_showcase_ops spec --json           # machine-readable contract
python -m gbt_showcase_ops check --payload '{}'
python -m gbt_showcase_ops run   --payload '{}'
```

Real `info` output from this machine:

```text
showcase_ops  (creation)  v1.0.0
----------------------------------------
**作品解剖与展示**（主人令 2026-10-16：让每一次的作品都能完美的展示能力）：蒸自 **wheresryan22/anatomy**（MIT · 13,459 星 · agent-skill）的**思路与架构**—— 「**用一个真会动的实物来讲解一个概念**」：概念→会动的实物（例：cache key⇒弹子锁）→**几十个小而精确的零件**（SVG+WebGL+3D）→**带标题/提示/实时读数的画框**→指针键盘下平静地动→**放大每个关节自检**→**读数同源**（图里每个数字都来自驱动零件运动的同一模型）。我们加三条护栏：署名必在 · 未验标未验 · 读数必须可指回。op=concept/parts/frame/motion/readout/selfcheck/check/route（**全只读·零作用域**）。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : concept, parts, frame, motion, readout, selfcheck, check, route
```

Wire a real implementation:

```python
from gbt_showcase_ops import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（8 个）**：`concept`、`parts`、`frame`、`motion`、`readout`、`selfcheck`、`check`、`route`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `showcase_ops` |
| domain | `creation` |
| handler | `showcase_ops` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [creation/showcase_ops](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/showcase_ops.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
