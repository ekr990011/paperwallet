function handleFiles(files) {
	// Check for the various File API support.
	if (window.FileReader) {
		// FileReader are supported.
		getAsText(files[0]);
	} else {
		alert('FileReader are not supported in this browser.');
	}
}

function getAsText(fileToRead) {
	var reader = new FileReader();
	// Handle errors load
	reader.onload = loadHandler;
	reader.onerror = errorHandler;
	// Read file into memory as UTF-8      
	reader.readAsText(fileToRead);
}

function loadHandler(event) {
	var csv = event.target.result;
	processData(csv);             
}

function processData(csv) {
    var allTextLines = csv.split(/\r\n|\n/);
    var lines = [];
    while (allTextLines.length) {
        lines.push(allTextLines.shift().split(','));
    }
// 	console.log(lines);
	drawOutput(lines);
}

function errorHandler(evt) {
	if(evt.target.error.name == "NotReadableError") {
		alert("Canno't read file !");
	}
}

function validatePublicAddress(address_text){
  var crypto_to_check = $('.crypto-symbol-js').text().slice(0, 3);
  return WAValidator.validate(address_text, crypto_to_check);
}

function drawOutput(lines){
	for (var i = 0; i < lines.length; i++) {
    	for (var j = 0; j < lines[i].length; j++) {
    		// console.log(lines[i][j]);
    		var address_text_to_check = lines[i][j].replace(/['"]+/g, '');
    		var valid = validatePublicAddress(address_text_to_check);
    		if (valid){
    			$('tbody').append('<tr><td>' + address_text_to_check + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
    		}
		}
	}
}