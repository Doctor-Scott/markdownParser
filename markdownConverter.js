function convert (markdownString) {
  const splitString = markdownString.split('\n')
  const HTMLArray = splitString.map(line => {
    return convertLine(line)
  })
  const HTML = HTMLArray.join('\n')
  console.log(HTML)
  return HTML
}

function convertLine (line) {
  const lineType = interpretLineType(line)
  switch (lineType) {
    case 'heading':
      return parseHeading(line)

    default:
      return line
  }
}

function parseHeading (line) {
  const splitString = line.split(' ')

  const headingSize = splitString[0].length
  const string = line.slice(headingSize + 1)

  const isValid = splitString[0].split('').every(char => char === '#')

  if (headingSize > 6 || !isValid) {
    return line
  }

  return `<h${headingSize}>${string}</h${headingSize}>`
}

function interpretLineType (line) {
  const firstChar = line[0]
  switch (firstChar) {
    case '#':
      return 'heading'

    case '-':
      return checkDash(line)

    default:
      return line
  }
}

function checkDash (line) {
  const firstChar = line[0]
  // TODO
}

module.exports = { convert }
