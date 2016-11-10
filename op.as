import "./cpu";
import "./mmu";
import "./om";

// Instruction Documentation Format
// [<opcode>] <mnemonic> {<bytes>:<cycles>}
//    u8   -> unsigned 8-bit immediate integer
//    s8   -> signed 8-bit immediate integer
//    u16  -> unsigned 16-bit immediate integer
//    (..) -> indirection

// Timing Reference (from Blargg)
// For instructions which either read or write, but not both, the CPU makes
// the access on the last cycle. For instructions which read, modify, then
// write back, the CPU reads on the next-to-last cycle, and writes on the
// last cycle.

// [0x] 00 .. 0F
// -----------------------------------------------------------------------------

// [00] NOP {1:1}
def _00(c: *cpu.Context) {
  cpu.tick(c);
}

// [01] LD BC, u16 {3:3}
def _01(c: *cpu.Context) {
  cpu.tick(c);

  *(c.C) = mmu.read_next(c);
  cpu.tick(c);

  *(c.B) = mmu.read_next(c);
  cpu.tick(c);
}

// [02] LD (BC), A {1:2}
def _02(c: *cpu.Context) {
  cpu.tick(c);

  *(c.A) = mmu.read(c.BC);
  cpu.tick(c);
}

// [03] INC BC {1:2}
def _03(c: *cpu.Context) {
  c.BC += 1;
  cpu.tick_n(c, 2);
}

// [04] INC B {1:1}
def _04(c: *cpu.Context) {
  *(c.B) = om.inc8(*(c.B));
  cpu.tick(c);
}

// [05] DEC B {1:1}
def _05(c: *cpu.Context) {
  *(c.B) = om.dec8(*(c.B));
  cpu.tick(c);
}

// [06] LD B, u8 {2:2}
def _06(c: *cpu.Context) {
  cpu.tick(c);

  *(c.B) = mmu.read_next();
  cpu.tick(c);
}

// [07] RLCA {1:1}
def _07(c: *cpu.Context) {
  *(c.A) = om.rotl8(*(c.A), false, false);
  cpu.tick(c);
}

// [08] LD (u16), SP {3:5}
def _08(c: *cpu.Context) {
  cpu.tick_n(c, 2);

  let l = mmu.read_next();
  cpu.tick(c);

  let h = mmu.read_next();
  cpu.tick(c);

  mmu.write(uint16(l) | (uint16(h) << 8), c.SP);
  cpu.tick(c);
}

// TODO: [09] ADD HL, BC {1:2}
// TODO: [0A] LD A, (BC) {1:2}
// TODO: [0B] DEC BC {1:2}
// TODO: [0C] INC C {1:1}
// TODO: [0D] DEC C {1:1}
// TODO: [0E] LD C, u8 {2:2}
// TODO: [0F] RRCA {1:1}

// [1x] 10 .. 1F
// -----------------------------------------------------------------------------

// [2x] 20 .. 2F
// -----------------------------------------------------------------------------

// [3x] 30 .. 3F
// -----------------------------------------------------------------------------

// [4x] 40 .. 4F
// -----------------------------------------------------------------------------

// [5x] 50 .. 5F
// -----------------------------------------------------------------------------

// [6x] 60 .. 6F
// -----------------------------------------------------------------------------

// [7x] 70 .. 7F
// -----------------------------------------------------------------------------

// [8x] 80 .. 8F
// -----------------------------------------------------------------------------

// [9x] 90 .. 9F
// -----------------------------------------------------------------------------

// [Ax] A0 .. AF
// -----------------------------------------------------------------------------

// [Bx] B0 .. BF
// -----------------------------------------------------------------------------

// [Cx] C0 .. CF
// -----------------------------------------------------------------------------

// [Dx] D0 .. DF
// -----------------------------------------------------------------------------

// [Ex] E0 .. EF
// -----------------------------------------------------------------------------

// [Fx] F0 .. FF
// -----------------------------------------------------------------------------

// [CB 0x] CB 00 .. CB 0F
// -----------------------------------------------------------------------------

// [CB 1x] CB 10 .. CB 1F
// -----------------------------------------------------------------------------

// [CB 2x] CB 20 .. CB 2F
// -----------------------------------------------------------------------------

// [CB 3x] CB 30 .. CB 3F
// -----------------------------------------------------------------------------

// [CB 4x] CB 40 .. CB 4F
// -----------------------------------------------------------------------------

// [CB 5x] CB 50 .. CB 5F
// -----------------------------------------------------------------------------

// [CB 6x] CB 60 .. CB 6F
// -----------------------------------------------------------------------------

// [CB 7x] CB 70 .. CB 7F
// -----------------------------------------------------------------------------

// [CB 8x] CB 80 .. CB 8F
// -----------------------------------------------------------------------------

// [CB 9x] CB 90 .. CB 9F
// -----------------------------------------------------------------------------

// [CB Ax] CB A0 .. CB AF
// -----------------------------------------------------------------------------

// [CB Bx] CB B0 .. CB BF
// -----------------------------------------------------------------------------

// [CB Cx] CB C0 .. CB CF
// -----------------------------------------------------------------------------

// [CB Dx] CB D0 .. CB DF
// -----------------------------------------------------------------------------

// [CB Ex] CB E0 .. CB EF
// -----------------------------------------------------------------------------

// [CB Fx] CB F0 .. CB FF
// -----------------------------------------------------------------------------
