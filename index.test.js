const { convert } = require('./markdownConverter')

const headerTestConfig = [
  ['# hello', '<h1>hello</h1>'],
  ['## hello', '<h2>hello</h2>'],
  ['### hello', '<h3>hello</h3>'],
  ['#### hello', '<h4>hello</h4>']
]

test.each(headerTestConfig)('Header Tests expect %s to return %s', (input, expectedResult) => {
  expect(convert(input)).toEqual(expectedResult)
})

test('Expect dodgy data to be unchanged', () => {
  expect(convert('##-- hello')).toBe('##-- hello')
})
