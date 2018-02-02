export const PiercedLocationState = {
  // - L0: 開示し，実行する箇所 (普通の箇所)
  L0: Symbol('L0'),
  // - L1: 隠蔽し，実行する箇所 (出題はしないが，ブラックボックスにする)
  L1: Symbol('L1'),
  // - L2: 隠蔽し，実行しない箇所 (出題して設問の解答となる箇所)
  L2: Symbol('L2'),
}
