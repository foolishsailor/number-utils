export class Number {
  /**
   * Converts the inputed number to a abbreviated string
   * @param value The number to be abbreviated
   */
  toString(value: number): string;

  /**
   * Converts the inputed number to a comma sperated number
   * @param value The number to comma seperate
   */
  toFormattedString: (value: number) => string;
}
