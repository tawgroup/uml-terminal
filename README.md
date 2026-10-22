# uml-terminal

Skill `uml-terminal` cho Claude Code, Codex, Cursor và Antigravity.

Bắt agent **vẽ luồng ra ngay terminal** thay vì tả bằng chữ: viết PlantUML sequence diagram, render bằng `plantuml -tutxt` thành box-drawing unicode (`┌─┐ ╔═╗ ─>`), dán vào câu trả lời trong fenced code block. Không HTML, không Artifact, không PNG. Nói "vẽ luồng", "vẽ sơ đồ", "draw the flow", "minh họa cho tôi" là nó vẽ.

Ví dụ thật (luồng therapist dời lịch trong một hệ thống telehealth, 3 nhánh tách thành 3 sơ đồ): xem [`examples/`](./examples).

```
LUONG B2 - pilot, ca con <= 12h - CHI duoc goi Care Desk

                  ┌─┐             ┌───┐                ┌─────┐  ┌──┐ ┌─────┐
                  │T│             │API│                │Voice│  │CD│ │Slack│
                  └┬┘             └─┬─┘                └──┬──┘  └─┬┘ └──┬──┘
                   │  Reschedule    │                     │       │     │
                   │───────────────>│                     │       │     │
                   │ chi co         │                     │       │     │
                   │ Call CareDesk  │                     │       │     │
                   │< ─ ─ ─ ─ ─ ─ ─ │                     │       │     │
                   │                │         goi         │       │     │
                   │                │────────────────────>│       │     │
                   │                │                     │ ring  │     │
                   │                │                     │──────>│     │
                   │              ╔═════════════╤═════════════════════════╗
                   │              ║ alt bat may │         │       │     │ ║
                   │              ╟─────────────┘         │       │     │ ║
                   │              ║ │         tu doi lich │       │     │ ║
                   │              ║ │<────────────────────────────│     │ ║
                   │              ║─│khong bat may ─ ─ ─ ─│─ ─ ─ ─│─ ─ ─│─║
                   │              ║ │           │URGENT   │       │     │ ║
                   │              ║ │──────────────────────────────────>│ ║
                   │              ╚═════════════╧═════════════════════════╝
```

## Tại sao không vẽ tay ASCII

Agent vẽ tay không bao giờ thẳng hàng. PlantUML tính layout, agent chỉ việc viết `A -> B : label`. Cái skill này dạy là **các rule để sơ đồ vừa 100 cột terminal**: tối đa 6 participant, label ≤ 20 ký tự/dòng, mỗi nhánh một sơ đồ riêng, không `note` trong `alt` (renderer crash), không `\n` trong điều kiện `alt` (in nguyên chữ), đo width bằng ký tự chứ không phải byte.

## Cần gì

```bash
brew install plantuml   # kéo luôn OpenJDK
```

Chỉ sequence diagram render được ra text. Activity / class / state phải ra PNG.

## Cài

```bash
git clone https://github.com/tawgroup/uml-terminal.git
cd uml-terminal
./install.sh
```

Script tạo symlink vào 4 chỗ:

- `~/.claude/skills/uml-terminal` — Claude Code, mọi project
- `~/.agents/skills/uml-terminal` — Codex
- `~/.cursor/skills/uml-terminal` — Cursor
- `~/.gemini/config/skills/uml-terminal` — Antigravity CLI (`agy`)

Symlink chứ không copy. Sửa file trong repo là cả 4 harness thấy ngay.

Nếu đã có bản copy cũ ở đó, script đổi tên thành `uml-terminal.bak` rồi mới link. Xoá `.bak` sau khi kiểm tra.

Cài xong thoát hẳn Claude Code / Codex / Cursor / `agy` rồi mở lại. Skill chỉ nạp lúc khởi động.

## Gỡ

```bash
./uninstall.sh
```

## Dùng

```text
vẽ luồng login hiện tại cho tôi xem
draw the flow from webhook to DB write
/uml-terminal luồng A và luồng B khác nhau chỗ nào
```

Render tay:

```bash
bash skills/uml-terminal/scripts/render.sh examples/A.puml
```
