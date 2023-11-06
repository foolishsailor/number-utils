# @rbxts/number-manipulator

[![NPM](https://nodei.co/npm/@rbxts/number-manipulator.png)](https://npmjs.org/package/@rbxts/number-manipulator)

## Installation:

`npm i @rbxts/number-manipulator`

## Example Usage

```typescript
import { Number, formatNum, abbreviateBytes } from '@rbxts/number-manipulator';

const Number = new Number(0, ['K', 'M']);

print(Number.toString('100')); // 100

print(formatNum(1000)); // 1,000

print(abbreviateBytes(1024)); // 1 KB
```
