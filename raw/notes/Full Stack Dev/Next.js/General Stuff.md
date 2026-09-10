# Running a TypeScript File with Node

## Node v22.7+ (built-in)
```bash
node --experimental-strip-types file.ts
```

## `tsx` (zero-config, any Node version)
```bash
npx tsx file.ts
```

## `ts-node`
```bash
npx ts-node file.ts
```

`tsx` is the simplest zero-config option if your Node version doesn't support `--experimental-strip-types` yet.

---

# Viewing Individual Test Results in Vitest

By default, Vitest only reports at the **test** level (`it`/`test`), not at the **assertion** level (`expect`). Individual `expect` lines don't get their own output.

## Option 1: Split expects into separate `it` blocks
```ts
describe('math utils', () => {
  it('adds two numbers', () => {
    expect(add(1, 2)).toBe(3);
  });

  it('handles negatives', () => {
    expect(add(-1, -2)).toBe(-3);
  });
});
```
Each `it` block gets its own pass/fail line in the output.

## Option 2: Use the verbose reporter
```bash
npx vitest --reporter=verbose
```

Or in `vitest.config.ts`:
```ts
export default defineConfig({
  test: {
    reporters: ['verbose'],
  },
});
```

The verbose reporter prints every passing test name rather than collapsing them.

---

# Running a Single Test File in Vitest

```bash
npx vitest run utils.test.ts
```

It matches by partial filename, so `utils` alone would run any test file containing "utils" in the path.
