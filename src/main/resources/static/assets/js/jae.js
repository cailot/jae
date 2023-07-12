// clean up any single quote escape charater in Json
function cleanUpJson(obj){
	const jsonString = JSON.stringify(obj, (key, value) => {
  		// If the value is a string, remove escape characters from it
  		if (typeof value === 'string') {
    		return value.replace(/'/g, '&#39;');
  		}
  			return value;
	});
	return jsonString;
}

// StringUtils.isNotBlank()
function isNotBlank(value) {
	return typeof value === 'string' && value.trim().length > 0;
}
 
// String escape characters : single/double quotes, linefeed
function encodeDecodeString(str) {
	// Encoding
	let encodedStr = str
	  .replace(/\\/g, '\\\\')    // Backslash
	  .replace(/'/g, "\\'")       // Single quote
	//   .replace(/"/g, '\\"')       // Double quote
	  .replace(/"/g, "\\'")       // Double quote to single quote
	  .replace(/\n/g, '\\n');     // Line feed
  
	// Decoding
	let decodedStr = encodedStr
	  .replace(/\\n/g, '\n')      // Line feed
	  .replace(/\\"/g, '"')       // Double quote
	  .replace(/\\'/g, "'")       // Single quote
	  .replace(/\\\\/g, '\\');    // Backslash
  
	return { encoded: encodedStr, decoded: decodedStr };
  }
