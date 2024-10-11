const HEADING = 'HEADING'
function convert (markdownString) {
  const splitString = markdownString.split('\n')
  const HTMLArray = splitString.map(line => {
    return convertLine(line)
  })
  const HTML = HTMLArray.join('\n')
  return HTML
}

function convertLine (line) {
  const lineType = interpretLineType(line)
  switch (lineType) {
    case HEADING:
      return parseHeading(line)

    default:
      return line
  }
}

function parseHeading (line) {
  const splitString = line.split(' ')
  const headingSize = splitString[0].length
  const string = line.slice(headingSize + 1)

  return `<h${headingSize}>${string}</h${headingSize}>`
}

function interpretLineType (line) {
  const firstChar = line[0]
  switch (firstChar) {
    case '#':
      return headerTagIsValid(line) ? HEADING : 'none'

    case '-':
      return checkDash(line)

    default:
      return 'none'
  }
}

function headerTagIsValid(line){
  const splitString = line.split(' ')
  const isValid = splitString[0].split('').every(char => char === '#')
  const headingSize = splitString[0].length
  if (headingSize > 6 || !isValid) {
    return false
  }
  return true
}

function checkDash (line) {
  const firstChar = line[0]
  // TODO
}

module.exports = { convert }
