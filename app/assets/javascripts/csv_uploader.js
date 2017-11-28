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

function drawOutput(lines){
	for (var i = 0; i < lines.length; i++) {
    	for (var j = 0; j < lines[i].length; j++) {
    		// console.log(lines[i][j]);
    		var address_text_to_check = lines[i][j].replace(/['"]+/g, '');
    		var valid = WAValidator.validate(address_text_to_check, 'BTC');
    		if (valid){
    			before_address_text = '<div class="col-md-12 js-csv"><div class="col-xs-7"><p><span class="label label-warning grid-address">'
    			after_address_text = '</span></p></div><div class="col-xs-2"><p><span class="label label-info grid-crypto js-btc-check">0.00 BTC</span></p></div><div class="col-xs-2"><p><span class="label label-success grid-fiat js-fiat-check">0.00 USD</span></p></div><div class="col-xs-1"><p><span class="glyphicon glyphicon-remove js-remove"></span></p></div></div>'
    			$('.boohoo').after(before_address_text + address_text_to_check + after_address_text);
    		}
		}
	}
}
// 	Clear previous data
// 	document.getElementById("output").innerHTML = "";
// 	var table = document.createElement("table");
// 	for (var i = 0; i < lines.length; i++) {
		// var row = table.insertRow(-1);
		// for (var j = 0; j < lines[i].length; j++) {
		// 	var firstNameCell = row.insertCell(-1);
		// 	firstNameCell.appendChild(document.createTextNode(lines[i][j]));
		// }
// 	}
// 	document.getElementById("output").appendChild(table);
// }