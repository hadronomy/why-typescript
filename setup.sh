#!/usr/bin/env bash
set -euo pipefail

# Write param-union.ts
cat >param-union.ts <<'TS'
type IsOverload1<T> = T extends {
  (a: infer _A): unknown;
  (b: infer _B): unknown;
}
  ? true
  : false;
type Fun = (x: string) => number;
type Fun2 = {
  (x: string): number;
  (x: number): boolean;
  (x: boolean): string;
};

type IsFunOverloadl = IsOverload1<Fun>;
type IsFun20verload1 = IsOverload1<Fun2>;

type Expect<T extends T2, T2> = T;

type ExpectFalse = Expect<IsFunOverloadl, false>;
type ExpectTrue = Expect<IsFun20verload1, true>;
TS

# Write bisect.sh
cat >bisect.sh <<'BASH'
#!/usr/bin/env bash
set -euo pipefail

# Install deps for this commit
if ! npm ci --no-audit --no-fund >/dev/null 2>&1; then
  echo "npm ci failed; skipping commit"
  exit 125
fi

# Build the compiler
if ! npm run build >/dev/null 2>&1; then
  # Fallback for older commits if needed
  if ! npx gulp local >/dev/null 2>&1; then
    echo "Build failed; skipping commit"
    exit 125
  fi
fi

# Ensure built tsc exists
if [ ! -f "./built/local/tsc.js" ]; then
  echo "Missing built/local/tsc.js; skipping commit"
  exit 125
fi

# Ensure test file exists
if [ ! -f "./param-union.ts" ]; then
  echo "Missing param-union.ts in repo root"
  exit 125
fi

# Run the test: error => BAD, clean => GOOD
if node ./built/local/tsc.js ./param-union.ts --strict --noImplicitAny --strictNullChecks --strictFunctionTypes --strictPropertyInitialization --strictBindCallApply --noImplicitThis --noImplicitReturns --alwaysStrict --noUnusedParameters --esModuleInterop --declaration --allowSyntheticDefaultImports --target ES2017 --jsx react --module ESNext --moduleResolution node --noEmit >/dev/null 2>&1; then
  echo "GOOD: Result is never (no error)"
  exit 0
else
  echo "BAD: Result is not never (compiler reported error)"
  exit 1
fi
BASH

# Make bisect script executable
chmod +x bisect.sh

# Start bisect and set range
git bisect reset || true
git bisect start
git bisect good 555ef99
git bisect bad 63717cf

# Run the bisect with the script
git bisect run ./bisect.sh
