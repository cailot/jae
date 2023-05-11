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