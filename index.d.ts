interface NumberConstructor {
  /**
   * Converts the inputed number to a abbreviated string
   * @param value The number to be abbreviated
   */
  toString(value: number, decimals: number): string;

  /**
   * Converts the inputed number to a comma sperated number
   * @param value The number to comma seperate
   */
  toFormattedString: (value: number, decimals: number) => string;
}

declare const Number: NumberConstructor;

export = Number;
